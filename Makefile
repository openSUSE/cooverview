CGI_DIR ?= /srv/www/cgi-bin

install:
	mkdir -p $(DESTDIR)$(CGI_DIR)
	install -m 755 ./cooverview $(DESTDIR)$(CGI_DIR)/cooverview

config:
	mkdir -p $(DESTDIR)/etc/cooverview
	install -m 644 ./config.yml.template $(DESTDIR)/etc/cooverview/config.yml
