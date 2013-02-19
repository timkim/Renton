ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

USEFILE=

EXTRA_SRCVPATH+=$(PROJECT_ROOT)/public \
    $(PROJECT_ROOT)/src \
    
# Extra include path for libfreetype and for target overrides and patches
EXTRA_INCVPATH+=$(QNX_INCLUDE) \
                $(QNX_INCLUDE)/qt4 \
                $(QNX_INCLUDE)/qt4/Qt \
                $(QNX_INCLUDE)/qt4/QtCore \
	

# Extra library search path for target overrides and patches
EXTRA_LIBVPATH+=$(QNX_TARGET)/../target-override/$(CPUVARDIR)/lib \
	$(QNX_TARGET)/../target-override/$(CPUVARDIR)/usr/lib

# Compiler options for enhanced security and recording the compiler options in release builds
CCFLAGS+=-fstack-protector-strong -fPIC -D_FORTIFY_SOURCE=2 -Wtrampolines -Wall -Wextra -Wformat=2

# Linker options for enhanced security
LDFLAGS+=-Wl,-rpath,./app/native/plugins/jnext,-z,relro,-z,now,-s

# Add your required library names, here
LIBS+=

include $(MKFILES_ROOT)/qmacros.mk

# Suppress the _g suffix from the debug variant
BUILDNAME=$(NAME)$(IMAGE_SUFF_$(BUILD_TYPE))
BUILDNAME_SAR=$(IMAGE_PREF_AR)$(NAME)S$(IMAGE_SUFF_AR)

include $(MKFILES_ROOT)/qtargets.mk

OPTIMIZE_TYPE_g=none
OPTIMIZE_TYPE=$(OPTIMIZE_TYPE_$(filter g, $(VARIANTS)))
