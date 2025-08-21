GEN_DEPS   = $(CURDIR)/gen-deps.sh
GEN_SYMS   = $(CURDIR)/gen-syms.sh
GEN_SINGLE = $(CURDIR)/gen-single.sh
GEN_VERS   = $(CURDIR)/gen-version.sh

# https://git.sr.ht/~sircmpwn/scdoc
SCDOC ?= scdoc

PROJECT = libshell
VERSION = $(shell $(GEN_VERS))

DESTDIR ?=
datadir ?= /usr/share
man3dir ?= ${datadir}/man/man3
bindir  ?= /bin

SUBDIRS = utils

capability_TARGETS = shell-regexp
bin_TARGETS = $(filter-out shell-lib,$(wildcard shell-*))
data_TARGETS = COPYING

mddocs_TARGETS = $(wildcard docs/shell-*.md)
docs_TARGETS = docs/libshell.md $(mddocs_TARGETS)
man_TARGETS = $(docs_TARGETS:.md=.3)

.PHONY: $(SUBDIRS)

all: ${bin_TARGETS} ${man_TARGETS} ${capability_TARGETS} DEPS SYMS $(SUBDIRS)

DEPS:
	PATH="$(CURDIR):$(PATH)" $(GEN_DEPS) ${bin_TARGETS} > $@

SYMS:
	PATH="$(CURDIR):$(PATH)" $(GEN_SYMS) ${bin_TARGETS} > $@

shell-lib: ${bin_TARGETS}
	PATH="$(CURDIR):$(PATH)" $(GEN_SINGLE) ${bin_TARGETS} > $@

shell-regexp: shell-quote
	ln -s -- $^ $@

%.3: %.md
	@[ -z "$(SCDOC)" ] || $(SCDOC) < $< > $@

man: ${man_TARGETS}

install: install-bin install-man install-data $(SUBDIRS)

install-data: DEPS SYMS
	install -d -m755 ${DESTDIR}${datadir}/${PROJECT}
	cp $^ ${DESTDIR}${datadir}/${PROJECT}/

install-single: shell-lib
	install -d -m755 ${DESTDIR}${bindir}
	cp $^ ${DESTDIR}${bindir}/

install-bin: ${bin_TARGETS}
	install -d -m755 ${DESTDIR}${bindir}
	cp -a $^ ${DESTDIR}${bindir}/

install-man: ${man_TARGETS}
	if [ -n "$(SCDOC)" ]; then \
	  install -d -m755 ${DESTDIR}${man3dir}; \
	  install -m644 $^ ${DESTDIR}${man3dir}; \
	fi

$(SUBDIRS):
	$(MAKE) $(MFLAGS) -C "$@" $(MAKECMDGOALS)

$(PROJECT)-$(VERSION).tar.xz:
	tar --transform='s,^,$(PROJECT)-$(VERSION)/,' -Jcf $@ \
	    shell-* gen-* contrib tests docs LICENSE COPYING Makefile

$(PROJECT)-$(VERSION).tar.sign: $(PROJECT)-$(VERSION).tar.xz
	xz -d -c $^ | \
	    gpg --armor --detach-sign \
	        --default-key $(GPG_KEY) \
	        --output $@

tar: $(PROJECT)-$(VERSION).tar.xz
release: $(PROJECT)-$(VERSION).tar.sign

check:
	@cd tests; \
	    for sh in $${CHECK_SHELL:-/bin/sh /bin/dash /bin/bash /bin/bash3 /bin/bash4 /bin/mksh /bin/yash /bin/pdksh}; do \
	    [ -x "$$sh" ] || continue; \
	    export TEST_SHELL="$$sh"; \
	    echo "Running tests with $$sh"; \
	    if ! "$$sh" -efu ./runtests; then \
	        echo "Tests failed with $$sh"; \
	        echo; \
	        exit 1; \
	    fi; \
	done
	@sed -n -e 's/^## \([^[:space:]]\+\)$$/\1/p'        ${mddocs_TARGETS} |sort -uo "$(CURDIR)/.shell-funcs-documented"
	@sed -n -e 's/^\([A-Za-z][A-Za-z0-9_]\+\)().*/\1/p' ${bin_TARGETS}    |sort -uo "$(CURDIR)/.shell-funcs"
	@comm -13 \
	    "$(CURDIR)/.shell-funcs-documented" \
	    "$(CURDIR)/.shell-funcs" \
	        > "$(CURDIR)/.shell-funcs-not-documented"; \
	rc=0; \
	if [ "$$(wc -l < "$(CURDIR)/.shell-funcs-not-documented")" != "0" ]; then \
	    echo >&2 "ERROR: some functions are not documented:"; \
	    cat "$(CURDIR)/.shell-funcs-not-documented"; \
	    echo; \
	    rc=1; \
	else \
	    echo "All functions are documented."; \
	    echo; \
	fi; \
	rm -f -- \
	    "$(CURDIR)/.shell-funcs-documented" \
	    "$(CURDIR)/.shell-funcs-not-documented" \
	    "$(CURDIR)/.shell-funcs"; \
	exit $$rc;

verify:
	@for f in ${bin_TARGETS}; do \
	    ftype=$$(file -b "$$f"); \
	    [ -z "$${ftype##*shell script*}" ] || continue; \
	    echo "Checking $$f"; \
	    shellcheck -s dash -e SC1090,SC1091,SC2004,SC2015,SC2034,SC2086,SC2154 "$$f"; \
	done

clean: $(SUBDIRS)
	$(RM) -- ${man_TARGETS} ${capability_TARGETS} shell-lib DEPS SYMS
