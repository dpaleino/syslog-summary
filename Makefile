XP = xsltproc --nonet \
				--param man.charmap.use.subset "0" \
				--param make.year.ranges "1" \
				--param make.single.year.ranges "1"

install:
	install -m 755 syslog-summary $(DESTDIR)/usr/bin/syslog-summary
	install -m 644 ignore.rules $(DESTDIR)/etc/syslog-summary/ignore.rules

uninstall:
	[ ! -f $(DESTDIR)/usr/bin/syslog-summary ] || rm -v $(DESTDIR)/usr/bin/syslog-summary
	[ ! -d $(DESTDIR)/etc/syslog-summary ] || rm -vrf $(DESTDIR)/etc/syslog-summary/

syslog-summary.1: syslog-summary.1.xml
	$(XP) $<

