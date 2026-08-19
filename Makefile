TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

JinxSwiftTweak_FILES = Sources/Tweak.swift load.s

# swift build komutunun Jinx modülünü çıkardığı dizini Theos'a tanıtıyoruz
SPM_MODULE_DIR = $(THEOS_PROJECT_DIR)/.build/arm64-apple-ios/debug
JinxSwiftTweak_SWIFTFLAGS = -swift-version 5 -I$(SPM_MODULE_DIR)
JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

# Theos derlemeye başlamadan önce SPM'i çalıştırsın
before-all::
	swift package resolve
	swift build -Xswiftc "-sdk" -Xswiftc "$(shell xcrun --sdk iphoneos --show-sdk-path)" -Xswiftc "-target" -Xswiftc "arm64-apple-ios12.0"

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
