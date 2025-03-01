NSCA := nsca
NSCA_VERS := 2.9.1
NSCA_DIR := $(NSCA)-$(NSCA_VERS)

NSCA_PATCHING := $(BUILD_HELPER_DIR)/$(NSCA_DIR)-patching
NSCA_BUILD := $(BUILD_HELPER_DIR)/$(NSCA_DIR)-build
NSCA_INSTALL := $(BUILD_HELPER_DIR)/$(NSCA_DIR)-install

#NSCA_INSTALL_DIR := $(INTERMEDIATE_INSTALL_BASE)/$(NSCA_DIR)
NSCA_BUILD_DIR := $(PACKAGE_BUILD_DIR)/$(NSCA_DIR)
#NSCA_WORK_DIR := $(PACKAGE_WORK_DIR)/$(NSCA_DIR)

$(NSCA_BUILD): $(NSCA_PATCHING)
	cd $(NSCA_BUILD_DIR) && \
	cp $(PACKAGE_BASE)/config* . && \
	./configure
	$(MAKE) -C $(NSCA_BUILD_DIR) all
	$(TOUCH) $@

$(NSCA_INSTALL): $(NSCA_BUILD)
	install -m 755 $(NSCA_BUILD_DIR)/src/nsca $(DESTDIR)$(OMD_ROOT)/bin
	install -m 755 $(NSCA_BUILD_DIR)/src/send_nsca $(DESTDIR)$(OMD_ROOT)/bin

	$(MKDIR) $(DESTDIR)$(OMD_ROOT)/share/doc/nsca
	install -m 644 $(NSCA_BUILD_DIR)/README $(DESTDIR)$(OMD_ROOT)/share/doc/nsca
	install -m 644 $(NSCA_BUILD_DIR)/LEGAL $(DESTDIR)$(OMD_ROOT)/share/doc/nsca
	install -m 644 $(NSCA_BUILD_DIR)/SECURITY $(DESTDIR)$(OMD_ROOT)/share/doc/nsca
	install -m 755 $(PACKAGE_DIR)/$(NSCA)/NSCA $(DESTDIR)$(OMD_ROOT)/lib/omd/hooks/
	install -m 755 $(PACKAGE_DIR)/$(NSCA)/NSCA_TCP_PORT $(DESTDIR)$(OMD_ROOT)/lib/omd/hooks/
	$(TOUCH) $@
