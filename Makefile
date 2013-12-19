GEN_DEPS   = $(CURDIR)/gen-deps.sh
GEN_SYMS   = $(CURDIR)/gen-syms.sh
GEN_SINGLE = $(CURDIR)/gen-single.sh
GEN_VERS   = $(CURDIR)/gen-version.sh

PROJECT = libshell
VERSION = $(shell $(GEN_VERS))

DESTDIR ?=
datadir ?= /usr/share
man3dir ?= ${datadir}/man/man3
bindir  ?= /bin

capability_TARGETS = shell-regexp
bin_TARGETS = $(filter-out shell-lib,$(wildcard shell-*))
data_TARGETS = COPYING

man_TARGETS = docs/libshell.man docs/shell-error.man

all: ${bin_TARGETS} ${capability_TARGETS} DEPS SYMS

DEPS:
	PATH="$(CURDIR):$(PATH)" $(GEN_DEPS) ${bin_TARGETS} > $@

SYMS:
	PATH="$(CURDIR):$(PATH)" $(GEN_SYMS) ${bin_TARGETS} > $@

shell-lib: ${bin_TARGETS}
	PATH="$(CURDIR):$(PATH)" $(GEN_SINGLE) ${bin_TARGETS} > $@

shell-regexp: shell-quote
	ln -s $^ $@

install: install-bin install-man install-data

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
	install -d -m755 ${DESTDIR}${man3dir}
	for i in $^; do \
		d="$${i%.man}.3"; d="$${d##*/}"; \
		install -m644 $$i ${DESTDIR}${man3dir}/$$d; \
	done

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
	@cd tests; ./runtests

clean:
	$(RM) -- $(capability_TARGETS) shell-lib DEPS SYMS
