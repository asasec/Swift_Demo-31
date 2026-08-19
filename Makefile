TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

JinxSwiftTweak_FILES = Sources/Tweak.swift load.s

# SPM tarafından derlenen Jinx modülünün yolunu buluyoruz
SPM_MODULE_DIR = $(shell find .build -name "Jinx.swiftmodule" 2>/dev/null | head -n 1 | xargs dirname)
JinxSwiftTweak_SWIFTFLAGS = -swift-version 5 -I$(SPM_MODULE_DIR)
JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

# Derlemeden önce SPM'i doğru iOS SDK ve platform parametreleriyle çalıştırıyoruz
before-all::
	swift package resolve
	swift build \
		-Xswiftc "-sdk" -Xswiftc "$(shell xcrun --sdk iphoneos --show-sdk-path)" \
		-Xswiftc "-target" -Xswiftc "arm64-apple-ios14.0" \
		-Xswiftc "-Xllvm" -Xswiftc "-aarch64-use-tbi"

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
