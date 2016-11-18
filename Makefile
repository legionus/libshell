GEN_DEPS   = $(CURDIR)/gen-deps.sh
GEN_SYMS   = $(CURDIR)/gen-syms.sh
GEN_SINGLE = $(CURDIR)/gen-single.sh
GEN_VERS   = $(CURDIR)/gen-version.sh

# github.com/legionus/md2man
MD2MAN ?= md2man

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

docs_TARGETS = docs/libshell.md $(shell ls -1 docs/shell-*.md)
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
	ln -s $^ $@

%.3: %.md
	@[ -z "$(MD2MAN)" ] || $(MD2MAN) -output $@ $<

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
	if [ -n "$(MD2MAN)" ]; then \
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
	@cd tests; ./runtests

clean: $(SUBDIRS)
	$(RM) -- $(man_TARGETS) $(capability_TARGETS) shell-lib DEPS SYMS
