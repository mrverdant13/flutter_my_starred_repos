# Android app splash screen

For the Android platform, **this project uses a different app splash screen per flavor and per theme** defined by using [source sets][source_sets_link] and [resource qualifiers][resource_qualifiers_link]. Thus, it is recommended to check the [template documentation on Android flavor-specific source sets][flavor_specific_source_sets].

---

## Splash asset location

Although you can use a non-vector asset image, **this app uses a vector graphic for the splash screen**.

This vector graphic is implemented with a [VectorDrawable resource][vector_drawable_resource_link] and, as any other drawable resource, it should be located in the `res/drawable` folder within an specific flavor source set.

However, to show a different splash image for both light and dark theme separately, we must place the proper vector graphic in the `res/drawable` and `res/drawable-night` folders respectively within the appropriate flavor source set.

For this project, the drawable files are named `ic_launch_image.xml`, which is the default name employed for the app splash resource for Android.

---

## Splash drawable creation tools

There are several tools that can help you create a drawable for the splash screen. Nevertheless, the vast majority of them are based on SVG or PSD files, so you should have your splash image in this format.

The following is a list of some tools that can be used for splash drawable generation:

- [Android's Image Assets Studio][splash_drawable_with_image_assets_studio_link]
- [Shape Shifter][shape_shifter_link]

<!-- ? LINKS -->

<!-- Project documentation -->

[flavor_specific_source_sets]: https://github.com/mrverdant13/flutter_my_starred_repos/blob/main/doc/android/flavors.md#flavor-specific-source-sets

<!-- Android documentation -->

[splash_drawable_with_image_assets_studio_link]: https://developer.android.com/studio/write/image-asset-studio#create-legacy
[resource_qualifiers_link]: https://developer.android.com/guide/topics/resources/providing-resources#AlternativeResources
[shape_shifter_link]: https://shapeshifter.design/
[source_sets_link]: https://developer.android.com/studio/build#sourcesets
[vector_drawable_resource_link]: https://developer.android.com/guide/topics/graphics/vector-drawable-resources
