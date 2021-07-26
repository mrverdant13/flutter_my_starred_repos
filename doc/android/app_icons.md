# Android app icons setup

For the Android platform, **this app uses a different app icon per flavor** defined by using [source sets][source_sets_link]. Thus, it is recommended to check the [template documentation on Android flavor-specific source sets][flavor_specific_source_sets].

---

## Icons assets location

Android has two ways to display an app icon or a launcher icon: [adaptive and legacy icon][adaptive_legacy_launcher_icons_link].

**This project only implements Android legacy icons for now.**

These legacy icons are intended for use on devices running Android 7.1 (API level 25) or lower, which don't support adaptive icons. However, when no adaptive icons are set, the legacy ones serve as fallback.

Legacy icons consist of PNG images [located in the `res/mipmap-<density qualifier>` directories][legacy_icons_location_link] within the appropriate flavor source set, where [_"density qualifier"_ is an identifier for a density bucket][density_buckets_qualifiers_link].

For this app, the images are named `ic_launcher.png`, which is the default name employed for the app icon asset for Android.

---

## Legacy icons creation tools

There are several tools that can help you create legacy launcher icons.

The following list shows some of them:

- [Android's Image Assets Studio][legacy_icons_with_image_assets_studio_link]
- [App Icon Generator][legacy_icons_with_app_icon_generator_link]
- [EasyAppIcon][legacy_icons_with_easy_app_icon]
- [MakeUpIcon][legacy_icons_with_make_up_icon_link]

<!-- ? LINKS -->

<!-- Project documentation -->

[flavor_specific_source_sets]: https://github.com/mrverdant13/flutter_my_starred_repos/blob/main/doc/android/flavors.md#flavor-specific-source-sets

<!-- Android documentation -->

[adaptive_legacy_launcher_icons_link]: https://developer.android.com/studio/write/image-asset-studio#launcher
[density_buckets_qualifiers_link]: https://developer.android.com/training/multiscreen/screendensities#TaskProvideAltBmp
[legacy_icons_with_app_icon_generator_link]: https://appicon.co
[legacy_icons_with_easy_app_icon]: https://easyappicon.com/
[legacy_icons_with_image_assets_studio_link]: https://developer.android.com/studio/write/image-asset-studio#create-legacy
[legacy_icons_with_make_up_icon_link]: https://makeappicon.com/
[legacy_icons_location_link]: https://developer.android.com/training/multiscreen/screendensities#mipmap
[source_sets_link]: https://developer.android.com/studio/build#sourcesets
