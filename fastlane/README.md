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

### ios change_app_version

```sh
[bundle exec] fastlane ios change_app_version
```

Change App Version

### ios build_ipa_dev

```sh
[bundle exec] fastlane ios build_ipa_dev
```

Build IOS IPA Dev

### ios build_ipa_prod

```sh
[bundle exec] fastlane ios build_ipa_prod
```

Build IOS IPA Prod

### ios build_ipa_stg

```sh
[bundle exec] fastlane ios build_ipa_stg
```

Build IOS IPA Stag

### ios deploy_ipa_dev

```sh
[bundle exec] fastlane ios deploy_ipa_dev
```

Deploy IOS IPA Dev

### ios deploy_ipa_prod

```sh
[bundle exec] fastlane ios deploy_ipa_prod
```

Deploy IOS IPA Production

### ios deploy_ipa_stg

```sh
[bundle exec] fastlane ios deploy_ipa_stg
```

Deploy IOS IPA Staging

----


## Android

### android change_app_version

```sh
[bundle exec] fastlane android change_app_version
```

Set App Version Code

### android build_apk_dev

```sh
[bundle exec] fastlane android build_apk_dev
```

Build Android APK Development

### android build_apk_stg

```sh
[bundle exec] fastlane android build_apk_stg
```

Build Android APK Staging

### android build_apk_prod

```sh
[bundle exec] fastlane android build_apk_prod
```

Build Android APK Production

### android build_aab_prod

```sh
[bundle exec] fastlane android build_aab_prod
```

Build Android AAB Production

### android deploy_apk_dev

```sh
[bundle exec] fastlane android deploy_apk_dev
```

Deploy Android APK Development

### android deploy_apk_stg

```sh
[bundle exec] fastlane android deploy_apk_stg
```

Deploy Android APK Staging

### android deploy_apk_prod

```sh
[bundle exec] fastlane android deploy_apk_prod
```

Deploy Android APK Production

### android deploy_aab_prod

```sh
[bundle exec] fastlane android deploy_aab_prod
```

Deploy Android AAB Production to playstore beta

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
