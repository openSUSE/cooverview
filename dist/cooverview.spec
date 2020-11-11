#
# spec file for package cooverview
#
# Copyright (c) 2018 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#
%define www_dir /srv/www
%define cgi_dir %{www_dir}/cgi-bin
%define htdocs_dir %{www_dir}/htdocs

Name:           cooverview
Version:        0.0.0
Release:        0
Summary:        A simple CGI script to read and display container info from a docker registry
License:        GPL-2.0-or-later
Group:          Productivity/Networking/Web/Frontends
Url:            https://github.com/openSUSE/cooverview
Source:         %{name}-%{version}.tar.xz
#BuildRequires:  
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Requires:       perl(YAML)
Requires:       perl(JSON::MaybeXS)
Requires:       perl(Net::Docker::Registry::Client)
Requires:       perl(Template)
BuildArch:      noarch

%description
Container Overview - A simple CGI script to read container information from a docker registry and display it

%prep
%setup -q

%build
# Nothing to do

%install
export DESTDIR=%{buildroot}
export CGI_DIR=%{cgi_dir}
%make_install
make config
mkdir -p %{buildroot}%{_defaultdocdir}/%{name}/contrib
cp contrib/index.html %{buildroot}%{_defaultdocdir}/%{name}/contrib

%files
%defattr(-,root,root)
%doc README.md
%license LICENSE
%dir %{cgi_dir}
%{cgi_dir}/*
%dir /etc/cooverview/
%config (noreplace) /etc/cooverview/config.yml
/etc/cooverview/templates
%dir %{www_dir}
%dir %{htdocs_dir}
%dir %{htdocs_dir}/cooverview
%dir %{htdocs_dir}/cooverview/js
%dir %{htdocs_dir}/cooverview/css
%{htdocs_dir}/cooverview/css/bootstrap.min.css
%{htdocs_dir}/cooverview/css/fontawesome.css
%{htdocs_dir}/cooverview/js/bootstrap.bundle.min.js
%{htdocs_dir}/cooverview/js/bootstrap.min.js
%{htdocs_dir}/cooverview/js/jquery.min.js
%{htdocs_dir}/cooverview/js/cooverview.js
%{htdocs_dir}/cooverview/js/js.cookie.js
%{htdocs_dir}/cooverview/js/fontawesome.min.js
%dir %{htdocs_dir}/cooverview/themes/
%{htdocs_dir}/cooverview/themes/suse/
%{htdocs_dir}/cooverview/themes/opensuse/
%{_defaultdocdir}/%{name}/contrib/

%changelog
