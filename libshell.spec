Name: libshell
Version: 0.0.5
Release: alt1

Summary:  A library of shell functions
License: GPL
Group: Development/Other
BuildArch: noarch
Packager: Alexey Gladkov <legion@altlinux.ru>

Source: %name-%version.tar

%description
This package contains common functions for shell projects to increase code reuse.


%prep
%setup -q

%install
mkdir -p %buildroot/bin
cp -a shell-* %buildroot/bin/
chmod 644 %buildroot/bin/*

%files
/bin/*
%doc COPYING SYMS

%changelog
* Thu Jun 05 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.5-alt1
- Add shell-unittest for writing Unit tests.

* Wed May 28 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.4-alt1
- Add shell-ip-address to IP address validation;
- Add shell-mail-address to mail address validation;
- shell-getopt:
  + Handle first '-' in short options;
  + Fix POSIXLY_CORRECT mode.

* Thu Mar 13 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.3-alt1
- shell-getopt: getopt():
  + Add --alternative handle;
  + Allow empty arguments;
  + Improve getopt(1) compatibility;
  + Ignore first '-' in options.
- shell-config:
  + Add shell_config_del() and shell_config_comment() functions.

* Sun Mar 09 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.2-alt4
- shell-getopt: Move getopt(), getsubopt(), getopts() and getoptex()
  from experimental state.
- shell-quote: Move string_quote_remove() from experimental state.

* Wed Feb 27 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.2-alt2
- shell-config: shell_config_set():
  + Fix value quoting.
- shell-getopt: getopt():
  + Fix GETOPT_ALLOW_UNKNOWN=1;
  + Fix return codes;
  + Fix params handling.

* Fri Feb 22 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.2-alt1
- Add shell-version to trac API changes.
- Add shell-getopt. This is getopts(1), getopt(1) and getsubopt(3)
  shell implementation (if __libshell_experimental is set).
- Rename shell-regexp to shell-quote.
- shell-quote:
  + Add string_quote_remove() to remove ' or " symbols from start
  and end of string (if __libshell_experimental is set).
  + Remove unquote_sed_regexp(), unquote_shell() functions.

* Mon Jan 28 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt4
- Add shell-config to read and write shell-like config files:
  + shell-config: shell_config_get() read value from config file;
  + shell-config: shell_config_set() change or write value
    to config file;
- shell-args:
  + opt_check_read(), opt_check_dir() Fix error message.
- shell-regexp:
  + Add new functions: unquote_sed_regexp(), unquote_shell().

* Thu Sep 20 2007 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt3
- Workaround quoting for ash.

* Fri Jul 06 2007 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt2
- shell-error: Rename info() to message().

* Thu Feb 22 2007 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt1
- Initial revision.
