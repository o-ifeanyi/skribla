clean:
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	flutter pub get
	cd ios && pod install

gen:
	dart run build_runner build --delete-conflicting-outputs
	flutter pub get

loc:
	flutter gen-l10n

splash:
	dart run flutter_native_splash:create

format:
	dart format --line-length 100 --set-exit-if-changed lib

functions:
	firebase deploy --only functions --project=skribla-$(flavor)

configure_dev:
	flutterfire configure --project=skribla-dev \
	--out=lib/firebase_options_dev.dart \
	--ios-bundle-id=com.skribla.ios.dev \
	--macos-bundle-id=com.skribla.macos.dev \
	--android-package-name=com.skribla.android.dev \
	--web-app-id=1:1056704511056:web:c268b2cdb298bbf326e555

configure_prod:
	flutterfire configure --project=skribla-prod \
	--out=lib/firebase_options_prod.dart \
	--ios-bundle-id=com.skribla.ios.prod \
	--macos-bundle-id=com.skribla.macos.prod \
	--android-package-name=com.skribla.android.prod \
	--web-app-id=1:676660663299:web:6912a4b78f5b8cbcb82a36

deeplink:
	adb shell am start -a android.intent.action.VIEW \
  	-c android.intent.category.BROWSABLE \
  	-d https://dev.skribla.com \
  	com.skribla.android.dev

serve_web:
	sh web_flavor_setup.sh $(flavor)
	flutter build web \
	--target lib/main_$(flavor).dart \
	--web-renderer canvaskit \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json
	firebase serve --only hosting --project=skribla-$(flavor)

deploy_web:
	sh web_flavor_setup.sh $(flavor)
	flutter build web \
	--target lib/main_$(flavor).dart \
	--web-renderer canvaskit \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json
	firebase deploy --only hosting --project=skribla-$(flavor)

patch_mobile:
	yes | shorebird patch --platforms=android \
	--flavor=$(flavor) \
	--target=lib/main_$(flavor).dart \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json

	yes | shorebird patch --platforms=ios \
	--flavor=$(flavor) \
	--target=lib/main_$(flavor).dart \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json

deploy_mobile:
	sh release_notes.sh

	yes | shorebird release ios \
	--export-method ad-hoc \
	--flavor dev \
	--target lib/main_dev.dart \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/dev_creds.json

	yes | shorebird release android --artifact=apk \
	--flavor dev \
	--target lib/main_dev.dart \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/dev_creds.json

	firebase appdistribution:distribute build/ios/ipa/skribla.ipa  \
    --app 1:1056704511056:ios:3c65b99d3d4ab0e526e555  \
    --release-notes-file "release_notes.txt" --groups "dev_testers"

	firebase appdistribution:distribute build/app/outputs/apk/dev/release/app-dev-release.apk  \
    --app 1:1056704511056:android:b1a81f5adcdab0d926e555  \
    --release-notes-file "release_notes.txt" --groups "dev_testers"

auth:
	firebase login --reauth

.PHONY: clean gen loc splash format functions configure_dev configure_prod deeplink serve_web deploy_web patch_mobile deploy_mobile auth