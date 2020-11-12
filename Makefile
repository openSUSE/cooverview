
WWW_DIR ?= /srv/www
CGI_DIR ?= $(WWW_DIR)/cgi-bin
HTDOCS_DIR ?= $(WWW_DIR)/htdocs/cooverview

install: cgi_bin js css templates themes webfonts

cgi_bin:
	[ -d $(DESTDIR)$(CGI_DIR) ] || mkdir -p $(DESTDIR)$(CGI_DIR)
	install -m 755 ./cooverview $(DESTDIR)$(CGI_DIR)/cooverview

js:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/js ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/js
	install -m 644 ./js/bootstrap.bundle.min.js $(DESTDIR)$(HTDOCS_DIR)/js/bootstrap.bundle.min.js
	install -m 644 ./js/bootstrap.min.js $(DESTDIR)$(HTDOCS_DIR)/js/bootstrap.min.js
	install -m 644 ./js/fontawesome.min.js $(DESTDIR)$(HTDOCS_DIR)/js/fontawesome.min.js
	install -m 644 ./js/jquery.min.js $(DESTDIR)$(HTDOCS_DIR)/js/jquery.min.js
	install -m 644 ./js/js.cookie.js $(DESTDIR)$(HTDOCS_DIR)/js/js.cookie.js
	install -m 644 ./js/cooverview.js $(DESTDIR)$(HTDOCS_DIR)/js/cooverview.js

css:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/css ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/css
	install -m 644 ./css/bootstrap.min.css $(DESTDIR)$(HTDOCS_DIR)/css/bootstrap.min.css
	install -m 644 ./css/fontawesome.min.css $(DESTDIR)$(HTDOCS_DIR)/css/fontawesome.min.css
	install -m 644 ./css/brands.min.css $(DESTDIR)$(HTDOCS_DIR)/css/brands.min.css
	install -m 644 ./css/solid.min.css $(DESTDIR)$(HTDOCS_DIR)/css/solid.min.css

webfonts:
	[ -d $(DESTDIR)$(HTDOCS_DIR) ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)
	cp -av webfonts $(DESTDIR)$(HTDOCS_DIR)/webfonts

config:
	[ -d $(DESTDIR)/etc/cooverview ] || mkdir -p $(DESTDIR)/etc/cooverview
	@if [ -f ./config.yml ];then \
		install -m 644 ./config.yml $(DESTDIR)/etc/cooverview/config.yml;\
	else \
		install -m 644 ./config.yml.template $(DESTDIR)/etc/cooverview/config.yml;\
	fi

favicon:
	install -m 644 ./themes/favicon.ico $(DESTDIR)$(WWW_DIR)/htdocs/

templates:
	[ -d $(DESTDIR)/etc/cooverview/templates ] || \
	  mkdir -p $(DESTDIR)/etc/cooverview/templates
	install -m 644 ./templates/index.html.tt2 $(DESTDIR)/etc/cooverview/templates/index.html.tt2
	install -m 644 ./templates/header.tt2 $(DESTDIR)/etc/cooverview/templates/header.tt2
	install -m 644 ./templates/footer.tt2 $(DESTDIR)/etc/cooverview/templates/footer.tt2
	install -m 644 ./templates/details.tt2 $(DESTDIR)/etc/cooverview/templates/details.tt2
	install -m 644 ./templates/modal.tt2 $(DESTDIR)/etc/cooverview/templates/modal.tt2
	install -m 644 ./templates/title.tt2 $(DESTDIR)/etc/cooverview/templates/title.tt2
	install -m 644 ./templates/navbar.tt2 $(DESTDIR)/etc/cooverview/templates/navbar.tt2
	install -m 644 ./templates/search_buttons.tt2 $(DESTDIR)/etc/cooverview/templates/search_buttons.tt2

themes: theme_suse theme_opensuse

theme_opensuse:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/css/ ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/css/
	[ -d $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/img/ ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/img/
	install -m 644 ./themes/opensuse/css/chameleon.css  $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/css/chameleon.css
	install -m 644 ./themes/opensuse/img/logo-white.svg $(DESTDIR)$(HTDOCS_DIR)/themes/opensuse/img/logo-white.svg

theme_suse:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/themes/suse/css/ ]     || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/themes/suse/css/
	[ -d $(DESTDIR)$(HTDOCS_DIR)/themes/suse/img/ ]     || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/themes/suse/img/
	install -m 644 ./themes/suse/css/chameleon.css      $(DESTDIR)$(HTDOCS_DIR)/themes/suse/css/chameleon.css
	install -m 644 ./themes/suse/img/suse.svg           $(DESTDIR)$(HTDOCS_DIR)/themes/suse/img/suse.svg
	
.PHONY: config cgi_bin js css templates themes theme_opensuse theme_suse webfonts
