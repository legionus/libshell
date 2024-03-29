GEN_VERS   = $(CURDIR)/../gen-version.sh

PROJECT = cgrep
VERSION = $(shell $(GEN_VERS))

DESTDIR ?=
bindir  ?= /usr/bin
datadir ?= /usr/share
mandir  ?= ${datadir}/man
man1dir ?= ${mandir}/man1

SCDOC ?= scdoc
INSTALL = install
CP      = cp -a
TOUCH_R = touch -r
MKDIR_P = mkdir -p

PROGRAMS = cgrep
MAN1PAGES = $(PROGRAMS:=.1)
TARGETS = $(PROGRAMS)

.PHONY:	all install install-man clean

all: $(TARGETS)

%: %.in
	sed \
		-e 's,@VERSION@,$(VERSION),g' \
		<$< >$@
	$(TOUCH_R) $< $@
	chmod --reference=$< $@

%.1: %.md
	@[ -z "$(SCDOC)" ] || $(SCDOC) < $< > $@

install: $(PROGRAMS)
	$(MKDIR_P) -m755 $(DESTDIR)$(bindir)
	$(CP) $(PROGRAMS) $(DESTDIR)$(bindir)/

install-man: $(MAN1PAGES)
	if [ -n "$(SCDOC)" ]; then \
	  $(MKDIR_P) -m755 $(DESTDIR)$(man1dir); \
	  $(INSTALL) -p -m644 $(MAN1PAGES) $(DESTDIR)$(man1dir)/; \
	fi

install: install-man

clean:
	$(RM) $(TARGETS) $(MAN1PAGES) *~
