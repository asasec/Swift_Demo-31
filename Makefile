TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

JinxSwiftTweak_FILES = Sources/Tweak.swift load.s

# SPM bağımlılıklarını derleme öncesi çöz ve Jinx modül yolunu ekle
SPM_BUILD_DIR = $(THEOS_PROJECT_DIR)/.swiftpm/xcode/derivedData/Build/Products/Debug-iphoneos
JinxSwiftTweak_SWIFTFLAGS = -swift-version 5 -I$(SPM_BUILD_DIR)/Modules -F$(SPM_BUILD_DIR)
JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

# Theos derlemeden hemen önce SPM paketlerini indirip derlesin
before-all::
	swift package resolve
	swift build -Xswiftc "-sdk" -Xswiftc "$(shell xcrun --sdk iphoneos --show-sdk-path)" -Xswiftc "-target" -Xswiftc "arm64-apple-ios12.0"

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
