VERSION = 1.2

build:
	gcc -Wall -fPIC -shared -o "$(CURDIR)/virt-aa-helper-hook.so" "$(CURDIR)/virt-aa-helper-hook.c" -ldl

install:
	install "$(CURDIR)/virt-aa-helper-hook" "$(DESTDIR)/usr/lib/libvirt/"
	install "$(CURDIR)/virt-aa-helper-hook.so" "$(DESTDIR)/usr/lib/libvirt/"
	[ -d "$(DESTDIR)/usr/lib/systemd/system/libvirtd.service.d" ] || mkdir "$(DESTDIR)/usr/lib/systemd/system/libvirtd.service.d"
	cp -a "$(CURDIR)/10-virt-aa-helper-hook.conf" "$(DESTDIR)/usr/lib/systemd/system/libvirtd.service.d/"
	cp -a "$(CURDIR)/usr.lib.libvirt.virt-aa-helper-hook" "$(DESTDIR)/etc/apparmor.d/"

move-upstream:
	@dir="$$(echo "$(CURDIR)" | sed 's/\(-[0-9]\+\.[0-9]\+\)\?$$/-$(VERSION)/')" && \
	mv "$(CURDIR)" "$$dir" && \
	echo "$$dir"

changelog:
	@cd "$(CURDIR)" && dpkg-parsechangelog --file "debian/changelog"

changelog-update:
	@cd "$(CURDIR)" && dch --maintmaint --fromdirname

changelog-update-stdin:
	@cd "$(CURDIR)" && text="$$(cat)" && dch --maintmaint --fromdirname "$$text"

changelog-release:
	@cd "$(CURDIR)" && dch --maintmaint --release

changelog-release-stdin:
	@cd "$(CURDIR)" && text="$$(cat)" && dch --maintmaint --release "$$text"

create-orig-source:
	@cd "$(CURDIR)" && tar -czf "../virt-aa-helper-hook_$(VERSION).orig.tar.gz" .

create-package: create-orig-source
	@cd "$(CURDIR)" && debuild -us -uc

version:
	@echo "$(VERSION)"
