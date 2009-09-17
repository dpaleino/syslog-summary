XP = xsltproc --nonet \
				--param man.charmap.use.subset "0" \
				--param make.year.ranges "1" \
				--param make.single.year.ranges "1"

version = $(shell grep ^version syslog-summary | cut -d\" -f2)

install:
	mkdir -p $(DESTDIR)/usr/bin/
	mkdir -p $(DESTDIR)/etc/syslog-summary/
	install -m 755 syslog-summary $(DESTDIR)/usr/bin/syslog-summary
	install -m 644 ignore.rules $(DESTDIR)/etc/syslog-summary/ignore.rules

uninstall:
	[ ! -f $(DESTDIR)/usr/bin/syslog-summary ] || rm -v $(DESTDIR)/usr/bin/syslog-summary
	[ ! -d $(DESTDIR)/etc/syslog-summary ] || rm -vrf $(DESTDIR)/etc/syslog-summary/

syslog-summary.1: syslog-summary.1.xml
	$(XP) $<

dist: clean
	mkdir syslog-summary-$(version)/
	find . -maxdepth 1 -type f | xargs cp -t syslog-summary-$(version)/
	@rm -rf syslog-summary-$(version)/.git/
	tar zcf syslog-summary-$(version).tar.gz syslog-summary-$(version)/
	rm -rf syslog-summary-$(version)/

clean:
	@find . -type d -name "syslog-summary-*" | xargs rm -rf
	@find . -type f -name "*.tar.gz" -delete
