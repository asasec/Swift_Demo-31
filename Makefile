TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

JinxSwiftTweak_FILES = Sources/Tweak.swift load.s

# Dinamik olarak Jinx modülünün yerini bulup SWIFTFLAGS'e ekleyeceğiz
SPM_MODULE_DIR = $(shell find .build -name "Jinx.swiftmodule" -exec dirname {} \;)
JinxSwiftTweak_SWIFTFLAGS = -swift-version 5 -I$(SPM_MODULE_DIR)
JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

# Swift build komutuna iOS SDK ve platform parametrelerini tam olarak ekliyoruz
before-all::
	swift package resolve
	swift build --triple arm64-apple-ios12.0 -Xswiftc "-sdk" -Xswiftc "$(shell xcrun --sdk iphoneos --show-sdk-path)" -Xswiftc "-target" -Xswiftc "arm64-apple-ios12.0" -Xswiftc "-parse-as-library"
	@echo "--- JINX MODUL DIZINI ---"
	@echo $(SPM_MODULE_DIR)

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH:/aggregate.mk) # veya $(THEOS_MAKE_PATH)/aggregate.mk
