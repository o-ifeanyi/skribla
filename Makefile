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

run:
	flutter run \
	--flavor $(flavor) \
	--target lib/main_$(flavor).dart

format:
	dart format --line-length 80 --set-exit-if-changed lib

functions:
	firebase deploy --only functions --project=draw-and-guess-$(flavor)

configure_dev:
	flutterfire configure --project=draw-and-guess-dev \
	--out=lib/firebase_options_dev.dart \
	--ios-bundle-id=app.ifeanyi.drawAndGuess.dev \
	--android-package-name=app.ifeanyi.draw_and_guess.dev \
	--web-app-id=1:773620093493:web:8bc4fefdbf393ec549177c

configure_prod:
	flutterfire configure --project=draw-and-guess-prod \
	--out=lib/firebase_options_prod.dart \
	--ios-bundle-id=app.ifeanyi.drawAndGuess.prod \
	--android-package-name=app.ifeanyi.draw_and_guess.prod \
	--web-app-id=1:866543961476:web:a2294c8345ca1f156389d1

deploy_dev:
	firebase login --reauth
	sh release_notes.sh

	flutter build ipa --release \
	--export-method ad-hoc \
	--flavor dev \
	--target lib/main_dev.dart

	flutter build apk --release \
	--flavor dev \
	--target lib/main_dev.dart

	firebase appdistribution:distribute build/ios/ipa/drawAndGuess.ipa  \
    --app 1:2121200722:ios:d096f1b7a4d858eb309b8b  \
    --release-notes-file "release_notes.txt"  --groups "beta_testers"

	firebase appdistribution:distribute build/app/outputs/apk/dev/release/app-dev-release.apk  \
    --app 1:2121200722:android:ca8d79b1be12b17f309b8b  \
    --release-notes-file "release_notes.txt"  --groups "beta_testers"

auth:
	firebase login --reauth

.PHONY: clean gen loc splash run format functions configure_dev configure_prod deploy_dev auth