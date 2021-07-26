# Flavors

This project supports three different flavors for the Android platform which are implemented following the [official flavoring documentation][product_flavors_configuration_link]:

- Development
- Staging
- Production

## Flavor-specific source sets

There is a collection of folders we should pay attention to. They are called [source sets][source_sets_link] and are located in the `android/app/src/` folder.

Among all of those source sets, you can find three of them linked to an specific flavor as follows:

- Development: `dev` source set
- Staging: `stg` source set
- Production: `main` source set

> **Note:** consider this when creating a new android flavor.

Each of these folders contains data regarding each specific flavor except for the `main` source set, which contains fallback data if it is not found in the others.

As an example, you could check the `res/values/strings.xml` file within each flavor source set folder. This file defines the app label or app name for each flavor.

<!-- ? LINKS -->

<!-- Android documentation -->

[product_flavors_configuration_link]: https://developer.android.com/studio/build/build-variants#product-flavors
[source_sets_link]: https://developer.android.com/studio/build#sourcesets
