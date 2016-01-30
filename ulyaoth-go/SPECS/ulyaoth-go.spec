AutoReqProv: no
%define debug_package %{nil}
%global __os_install_post %{nil}

Summary: The Go Programming Language
Name: ulyaoth-go
Version: 1.5.3
Release: 1%{?dist}
BuildArch: x86_64
URL: https://golang.org/
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.net>

Source0: https://storage.googleapis.com/golang/go%{version}.linux-amd64.tar.gz
BuildRoot:  %{_tmppath}/ulyaoth-golang-%{version}-%{release}-root-%(%{__id_u} -n)

License: BSD

Provides: go
Provides: ulyaoth-go

%description
Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.

%prep
%setup -q -n go

%install
%{__mkdir} -p $RPM_BUILD_ROOT/usr/local
cp -rf %{_builddir}/go $RPM_BUILD_ROOT/usr/local/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%dir /usr/local/go
/usr/local/go/*

%post
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-go!

Please find the official documentation for go here:
* https://golang.org/

For any additional information or help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%changelog
* Sat Jan 30 2016 Sjir Bagmeijer <sbagmeijer@ulyaoth.net> 1.5.3-1
- Creating initial release with Go 1.5.3.