fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android set_full_version

```sh
[bundle exec] fastlane android set_full_version
```

Set Gradle Version and Build Number

### android dev

```sh
[bundle exec] fastlane android dev
```

Deploy a dev build to Firebase App Distribution

### android prod

```sh
[bundle exec] fastlane android prod
```

Deploy a prod build to Google Play Internal Test

### android patch

```sh
[bundle exec] fastlane android patch
```

Patch latest prod build on Google Play

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
