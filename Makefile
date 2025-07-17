package:
	@cd "$$(make -s prepare)" && \
	make -s create-package

changelog:
	@cd "$(CURDIR)/virt-aa-helper-hook" && make -s changelog

changelog-update:
	@cd "$$(make -s prepare)" && \
	make -s changelog-update && \
	cp -fa "debian/changelog" "$(CURDIR)/virt-aa-helper-hook/debian/changelog"

changelog-update-stdin:
	@cd "$$(make -s prepare)" && \
	make -s changelog-update-stdin && \
	cp -fa "debian/changelog" "$(CURDIR)/virt-aa-helper-hook/debian/changelog"

changelog-release:
	@cd "$$(make -s prepare)" && \
	make -s changelog-release && \
	cp -fa "debian/changelog" "$(CURDIR)/virt-aa-helper-hook/debian/changelog"

changelog-release-stdin:
	@cd "$$(make -s prepare)" && \
	make -s changelog-release-stdin && \
	cp -fa "debian/changelog" "$(CURDIR)/virt-aa-helper-hook/debian/changelog"

clean:
	@rm -rf "$(CURDIR)/build"

prepare: clean
	@mkdir -p "$(CURDIR)/build"
	@cp -ra "$(CURDIR)/virt-aa-helper-hook" "$(CURDIR)/build/virt-aa-helper-hook"
	@cd "$(CURDIR)/build/virt-aa-helper-hook" && make -s move-upstream

version:
	@cd "$(CURDIR)/virt-aa-helper-hook" && make -s version
