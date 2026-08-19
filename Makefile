TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

JinxSwiftTweak_FILES = Sources/Tweak.swift load.s

# SPM modül dizini
SPM_MODULE_DIR = $(shell find .build -name "Jinx.swiftmodule" 2>/dev/null | head -n 1 | xargs dirname)

# Theos'un Swift derleyicisine (swiftc) iPhoneOS SDK'sını ve hedef mimariyi zorluyoruz
SDK_PATH = $(shell xcrun --sdk iphoneos --show-sdk-path)

JinxSwiftTweak_SWIFTFLAGS = -swift-version 5 -I$(SPM_MODULE_DIR) \
    -sdk "$(SDK_PATH)" \
    -target arm64-apple-ios14.0

JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	swift package resolve
	swift build \
		-Xswiftc "-sdk" -Xswiftc "$(SDK_PATH)" \
		-Xswiftc "-target" -Xswiftc "arm64-apple-ios14.0"

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
