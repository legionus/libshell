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

CHECK_SHELL =
CHECK_SHELL += /bin/sh                         # POSIX Shell
CHECK_SHELL += /bin/dash                       # Debian Almquist Shell (https://git.kernel.org/pub/scm/utils/dash/dash.git)
CHECK_SHELL += /bin/bash /bin/bash3 /bin/bash4 # GNU Bourne-Again Shell (https://git.savannah.gnu.org/cgit/bash.git)
CHECK_SHELL += /bin/mksh /bin/lksh             # MirBSD Korn Shell (https://mbsd.evolvis.org/mksh.htm)

check-tests:
	@cd tests; rc=0; \
	for TEST_SHELL in $(wildcard $(CHECK_SHELL)); do export TEST_SHELL; \
	    echo "Running tests with $$TEST_SHELL"; \
	    if ! $$TEST_SHELL -efu ./runtests; then \
	        echo >&2 "ERROR: tests failed."; \
	        echo; \
	        rc=1; \
	    fi; \
	done; \
	exit $$rc;

check-documented:
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
	    rc=1; \
	else \
	    echo "All functions are documented."; \
	fi; \
	echo; \
	rm -f -- \
	    "$(CURDIR)/.shell-funcs-documented" \
	    "$(CURDIR)/.shell-funcs-not-documented" \
	    "$(CURDIR)/.shell-funcs"; \
	exit $$rc;

check: check-tests check-documented

NULL  =
SPACE = $(NULL) $(NULL)
COMMA = ,

DISABLE_SHELLCHECK =
DISABLE_SHELLCHECK += SC1090 # (warning): ShellCheck can't follow non-constant source. Use a directive to specify location.
DISABLE_SHELLCHECK += SC1091 # (info): Not following: file was not specified as input (see shellcheck -x).
DISABLE_SHELLCHECK += SC2004 # (style): $/${} is unnecessary on arithmetic variables.
DISABLE_SHELLCHECK += SC2015 # (info): Note that A && B || C is not if-then-else. C may run when A is true.
DISABLE_SHELLCHECK += SC2034 # (warning): foo appears unused. Verify it or export it.
DISABLE_SHELLCHECK += SC2086 # (info): Double quote to prevent globbing and word splitting.
DISABLE_SHELLCHECK += SC2154 # (warning): variable is referenced but not assigned.
DISABLE_SHELLCHECK += SC2295 # (info): Expansions inside ${..} need to be quoted separately, otherwise they match as patterns.
DISABLE_SHELLCHECK += SC2329 # (info): This function is never invoked. Check usage (or ignored if invoked indirectly).

verify:
	@for f in ${bin_TARGETS}; do \
	    ftype=$$(file -b "$$f"); \
	    [ -z "$${ftype##*shell script*}" ] || continue; \
	    echo "Checking $$f"; \
	    shellcheck -s dash -e $(subst $(SPACE),$(COMMA),$(sort $(DISABLE_SHELLCHECK))) "$$f"; \
	done

clean: $(SUBDIRS)
	$(RM) -- ${man_TARGETS} ${capability_TARGETS} shell-lib DEPS SYMS
