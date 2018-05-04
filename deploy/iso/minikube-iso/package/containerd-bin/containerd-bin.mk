################################################################################
#
# docker-bin
#
################################################################################

CONTAINERD_BIN_VERSION = 1.1.0
CONTAINERD_BIN_SITE = https://github.com/containerd/containerd/releases/download/$(CONTAINERD_BIN_VERSION)/containerd-$(CONTAINERD_BIN_VERSION).linux-amd64.tar.gz
CONTAINERD_BIN_SOURCE = containerd-$(CONTAINERD_BIN_VERSION).linux-amd64.tar.gz 

define CONTAINERD_BIN_USERS
	- -1 containerd -1 - - - - -
endef

define CONTAINERD_BIN_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 \
		$(@D)/containerd \
		$(TARGET_DIR)/bin/containerd

	$(INSTALL) -D -m 0755 \
		$(@D)/ctr \
		$(TARGET_DIR)/bin/ctr

endef

define CONTAINERD_BIN_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 \
		$(BR2_EXTERNAL)/package/containerd-bin/containerd.socket \
		$(TARGET_DIR)/run/containerd/containerd.sock

endef

$(eval $(generic-package))
