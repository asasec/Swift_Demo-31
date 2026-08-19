TARGET := iphone:clang:latest:latest

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = JinxSwiftTweakPrefs

JinxSwiftTweakPrefs_FILES = RootListController.swift

JinxSwiftTweakPrefs_FRAMEWORKS = UIKit

JinxSwiftTweakPrefs_PRIVATE_FRAMEWORKS = Preferences

JinxSwiftTweakPrefs_EXTRA_FRAMEWORKS = CepheiPrefs

JinxSwiftTweakPrefs_INSTALL_PATH = /Library/PreferenceBundles

JinxSwiftTweakPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
