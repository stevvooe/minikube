################################################################################
#
# containerd-bin
#
################################################################################

CONTAINERD_BIN_VERSION = 1.1.0
CONTAINERD_BIN_SITE = https://github.com/containerd/containerd/releases/download/v$(CONTAINERD_BIN_VERSION)
CONTAINERD_BIN_SOURCE = containerd-$(CONTAINERD_BIN_VERSION).linux-amd64.tar.gz 

define CONTAINERD_BIN_USERS
	- -1 containerd -1 - - - - -
endef

define CONTAINERD_BIN_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 \
		$(@D)/bin/containerd \
		$(TARGET_DIR)/bin/containerd

	$(INSTALL) -D -m 0755 \
		$(@D)/bin/ctr \
		$(TARGET_DIR)/bin/ctr
	
	$(INSTALL) -D -m 0755 \
		$(@D)/bin/containerd-shim \
		$(TARGET_DIR)/bin/containerd-shim
         
        mkdir -p $(TARGET_DIR)/var/lib/containerd	 
endef

define CONTAINERD_BIN_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 \
		$(BR2_EXTERNAL)/package/containerd-bin/containerd.sock \
		$(TARGET_DIR)/run/containerd/containerd.sock
        
        $(INSTALL) -D -m 644 \
		$(BR2_EXTERNAL_MINIKUBE_PATH)/package/containerd-bin/containerd.service \
		$(TARGET_DIR)/etc/systemd/system/containerd.service
        $(call link-service,containerd.service)	
endef

$(eval $(generic-package))
