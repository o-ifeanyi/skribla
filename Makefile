clean:
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	flutter pub get
	cd ios && pod install

gen:
	dart run build_runner build --delete-conflicting-outputs
	flutter gen-l10n
	dart format --line-length 100 --set-exit-if-changed lib
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

deploy_web:
	sh web_flavor_setup.sh $(flavor)
	flutter build web --release \
	--target lib/main_$(flavor).dart \
	--web-renderer canvaskit \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json
	firebase deploy --only hosting --project=skribla-$(flavor)

patch_mobile:
	cd ios && bundle exec fastlane patch
	cd android && bundle exec fastlane patch

gh_release:
	@version=$$(cat pubspec.yaml | grep -o 'version:[^:]*' | cut -f2 -d":" | xargs); \
	echo "Creating GitHub release for: $${version}"; \
	gh release create "$${version}" --generate-notes

deploy:
	sh release_notes.sh
	sh web_flavor_setup.sh $(flavor)

	flutter build web --release \
	--target lib/main_$(flavor).dart \
	--web-renderer canvaskit \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json
	
	firebase deploy --only hosting --project=skribla-$(flavor)

	cd ios && bundle exec fastlane $(flavor)

	flutter build macos --config-only \
	--flavor $(flavor) \
	--target lib/main_$(flavor).dart \
	--dart-define-from-file /Users/ifeanyionuoha/skribla/$(flavor)_creds.json

	cd android && bundle exec fastlane $(flavor)


auth:
	firebase login --reauth

.PHONY: clean gen loc splash format functions configure_dev configure_prod deeplink deploy_web patch_mobile deploy auth