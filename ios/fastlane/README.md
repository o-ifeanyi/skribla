fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios set_full_version

```sh
[bundle exec] fastlane ios set_full_version
```

Set Info.plist Version and Build Number

### ios dev

```sh
[bundle exec] fastlane ios dev
```

Deploy a dev build to Firebase App Distribution

### ios prod

```sh
[bundle exec] fastlane ios prod
```

Deploy a prod build to TestFlight

### ios patch

```sh
[bundle exec] fastlane ios patch
```

Patch latest prod build on App Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
