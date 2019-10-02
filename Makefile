
WWW_DIR ?= /srv/www
CGI_DIR ?= $(WWW_DIR)/cgi-bin
HTDOCS_DIR ?= $(WWW_DIR)/htdocs/cooverview

install: cgi_bin js css templates

cgi_bin:
	[ -d $(DESTDIR)$(CGI_DIR) ] || mkdir -p $(DESTDIR)$(CGI_DIR)
	install -m 755 ./cooverview $(DESTDIR)$(CGI_DIR)/cooverview

js:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/js ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/js
	install -m 644 ./js/bootstrap.bundle.min.js $(DESTDIR)$(HTDOCS_DIR)/js/bootstrap.bundle.min.js
	install -m 644 ./js/bootstrap.min.js $(DESTDIR)$(HTDOCS_DIR)/js/bootstrap.min.js
	install -m 644 ./js/font-awesome.min.js $(DESTDIR)$(HTDOCS_DIR)/js/font-awesome.min.js
	install -m 644 ./js/jquery.min.js $(DESTDIR)$(HTDOCS_DIR)/js/jquery.min.js
	install -m 644 ./js/js.cookie.js $(DESTDIR)$(HTDOCS_DIR)/js/js.cookie.js
	install -m 644 ./js/cooverview.js $(DESTDIR)$(HTDOCS_DIR)/js/cooverview.js

css:
	[ -d $(DESTDIR)$(HTDOCS_DIR)/css ] || mkdir -p $(DESTDIR)$(HTDOCS_DIR)/css
	install -m 644 ./css/bootstrap.min.css $(DESTDIR)$(HTDOCS_DIR)/css/bootstrap.min.css
	install -m 644 ./css/font-awesome.css $(DESTDIR)$(HTDOCS_DIR)/css/font-awesome.css

config:
	[ -d $(DESTDIR)/etc/cooverview ] || mkdir -p $(DESTDIR)/etc/cooverview
	@if [ -f ./config.yml ];then \
		install -m 644 ./config.yml $(DESTDIR)/etc/cooverview/config.yml;\
	else \
		install -m 644 ./config.yml.template $(DESTDIR)/etc/cooverview/config.yml;\
	fi

templates:
	[ -d $(DESTDIR)/etc/cooverview/templates ] || \
	  mkdir -p $(DESTDIR)/etc/cooverview/templates
	install -m 644 ./templates/index.html.tt2 $(DESTDIR)/etc/cooverview/templates/index.html.tt2
	install -m 644 ./templates/header.tt2 $(DESTDIR)/etc/cooverview/templates/header.tt2
	install -m 644 ./templates/details.tt2 $(DESTDIR)/etc/cooverview/templates/details.tt2
	install -m 644 ./templates/modal.tt2 $(DESTDIR)/etc/cooverview/templates/modal.tt2
	install -m 644 ./templates/title.tt2 $(DESTDIR)/etc/cooverview/templates/title.tt2
	install -m 644 ./templates/navbar.tt2 $(DESTDIR)/etc/cooverview/templates/navbar.tt2
	install -m 644 ./templates/predefined_search_buttons.tt2 $(DESTDIR)/etc/cooverview/templates/predefined_search_buttons.tt2
	
.PHONY: config cgi_bin js css templates
