DEFINES             := --dart-define-from-file=local.dart_defines
RELEASE             := --obfuscate --split-debug-info=build/debug-info
SENTRY_AUTH_TOKEN   := $(shell grep SENTRY_AUTH_TOKEN local.dart_defines | cut -d= -f2-)

export SENTRY_AUTH_TOKEN

.PHONY: run build-apk build-aab build-ipa

run:
	flutter run $(DEFINES)

build-apk:
	flutter build apk $(DEFINES) $(RELEASE)

build-aab:
	flutter build appbundle $(DEFINES) $(RELEASE)

build-ipa:
	flutter build ipa $(DEFINES) $(RELEASE)
