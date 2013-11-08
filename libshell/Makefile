PROJECT = libshell
DESTDIR ?=
datadir = /usr/share
man3dir = ${datadir}/man/man3
bindir = /bin

GEN_DEPS   = $(CURDIR)/gen-deps.sh
GEN_SYMS   = $(CURDIR)/gen-syms.sh
GEN_SINGLE = $(CURDIR)/gen-single.sh

bin_TARGETS = $(wildcard shell-*)
data_TARGETS = COPYING

man_TARGETS = docs/libshell.man docs/shell-error.man

install: install-bin install-man
	install -d -m755 ${DESTDIR}${datadir}/${PROJECT}
	$(GEN_DEPS) ${bin_TARGETS} > ${DESTDIR}${datadir}/${PROJECT}/DEPS
	$(GEN_SYMS) ${bin_TARGETS} > ${DESTDIR}${datadir}/${PROJECT}/SYMS

install-single: ${bin_TARGETS}
	install -d -m755 ${DESTDIR}${bindir}
	$(GEN_SINGLE) ${bin_TARGETS} > ${DESTDIR}${bindir}/shell-lib

install-bin: ${bin_TARGETS}
	install -d -m755 ${DESTDIR}${bindir}
	cp -a $^ ${DESTDIR}${bindir}/

install-man: ${man_TARGETS}
	install -d -m755 ${DESTDIR}${man3dir}
	for i in $^; do \
		d="$${i%.man}.3"; d="$${d##*/}"; \
		install -m644 $$i ${DESTDIR}${man3dir}/$$d; \
	done

check:
	@cd tests; ./runtests
