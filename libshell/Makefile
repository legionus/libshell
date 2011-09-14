PROJECT = libshell
DESTDIR ?=
datadir = /usr/share
man3dir = ${datadir}/man/man3
bindir = /bin

GEN_DEPS = $(CURDIR)/gen-deps.sh
GEN_SYMS = $(CURDIR)/gen-syms.sh

bin_TARGETS = shell-args shell-cmdline shell-config shell-error shell-getopt \
	shell-ini-config shell-ip-address shell-mail-address shell-quote \
	shell-regexp shell-signal shell-unittest shell-version shell-var \
	shell-source shell-string shell-run

data_TARGETS = COPYING

man_TARGETS = docs/libshell.man docs/shell-error.man

install: install-bin install-man
	install -d -m755 ${DESTDIR}${datadir}/${PROJECT}
	$(GEN_DEPS) ${DESTDIR}${bindir}/shell-* > ${DESTDIR}${datadir}/${PROJECT}/DEPS
	$(GEN_SYMS) ${DESTDIR}${bindir}/shell-* > ${DESTDIR}${datadir}/${PROJECT}/SYMS

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
