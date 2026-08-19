TARGET := iphone:clang:latest:latest
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JinxSwiftTweak

# Tweak.swift, load.s ve Sources/Jinx altındaki tüm Swift dosyalarını dahil ediyoruz
JinxSwiftTweak_FILES = Sources/Tweak.swift load.s $(shell find Sources/Jinx -name '*.swift')
JinxSwiftTweak_SWIFTFLAGS = -swift-version 5
JinxSwiftTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
