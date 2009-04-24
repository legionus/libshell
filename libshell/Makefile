DESTDIR =
datadir = /usr/share
man3dir = ${datadir}/man/man3
bindir = /bin

bin_TARGETS = shell-args shell-config shell-error shell-getopt \
	shell-ini-config shell-ip-address shell-mail-address shell-quote \
	shell-regexp shell-signal shell-unittest shell-version shell-var

data_TARGETS = COPYING SYMS

man_TARGETS = docs/libshell.man docs/shell-error.man

install: install-bin install-man

install-bin: ${bin_TARGETS}
	install -d -m755 ${DESTDIR}${bindir}
	cp -a $^ ${DESTDIR}${bindir}/

install-man: ${man_TARGETS}
	install -d -m755 ${DESTDIR}${man3dir}
	for i in $^; do \
		d="$${i%.man}.3"; d="$${d##*/}"; \
		install -m644 $$i ${DESTDIR}${man3dir}/$$d; \
	done
