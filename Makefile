PREFIX   = /usr/local
DATADIR  = $(PREFIX)/share/textadept/lexers

install:
	mkdir -p $(DESTDIR)$(DATADIR)
	cp lexers/berry.lua $(DESTDIR)$(DATADIR)

uninstall:
	rm -rf $(DESTDIR)$(DATADIR)/berry.lua

.PHONY: install uninstall