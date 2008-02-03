Name: libshell
Version: 0.0.1
Release: alt4

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
install -d %buildroot/bin
install -p -m644 -t %buildroot/bin shell-*

%files
/bin/*
%doc COPYING SYMS

%changelog
* Mon Jan 28 2008 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt4
- Add shell-version to trac API changes.
- Add shell-getopt. This is getopts(1) shell implementation.
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

