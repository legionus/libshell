Name: libshell
Version: 0.0.1
Release: alt1

Summary:  A library of shell functions
License: GPL
Group: Development/Other
BuildArch: noarch

Source: %name-%version.tar

%description
This package contains common functions for shell projects to increase code reuse.


%prep
%setup -q

%install
install -d %buildroot/bin
install -p -m755 -t %buildroot/bin *

%files
/bin/*

%changelog
* Thu Feb 22 2007 Alexey Gladkov <legion@altlinux.ru> 0.0.1-alt1
- Initial revision.

