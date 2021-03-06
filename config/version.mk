# Versioning of the ROM

ifeq ($(BUILD_IS_JENKINS),1)
	ROM_BUILDTYPE := NIGHTLY
endif
ifdef BUILDTYPE_RELEASE
	ROM_BUILDTYPE := RELEASE
endif

ifndef ROM_BUILDTYPE
	ROM_BUILDTYPE := HOMEMADE
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst nameless_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifdef BUILDTYPE_RELEASE
	ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)
else
ifeq ($(ROM_BUILDTIME_LOCAL),y)
	ROM_VERSION := $(PLATFORM_VERSION)-$(shell date +%Y%m%d-%H%M%z)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
else
	ROM_VERSION := $(PLATFORM_VERSION)-$(shell date -u +%Y%m%d)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
endif
endif

NAMELESS_VERSION := $(ROM_VERSION)

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	ro.modversion=NamelessROM-$(ROM_VERSION) \
	ro.nameless.version=$(ROM_VERSION) \
	ro.nameless.date=$(shell date +"%Y%m%d")
