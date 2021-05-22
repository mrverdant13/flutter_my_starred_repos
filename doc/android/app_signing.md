# Android app signing

As described in the [Flutter docs][app_signing_docs_link], to publish on the Play Store, you need to give your app a digital signature:

> On Android, there are two signing keys: deployment and upload. The end-users download the `.apk` signed with the ‘deployment key’. An ‘upload key’ is used to authenticate the `.aab`/`.apk` uploaded by developers onto the Play Store and is re-signed with the deployment key once in the Play Store.

**This project template has a default implementation for app signing by using an upload keystore.**

---

## Create the upload keystore

There are two methods to create an upload keystore: with Android Studio and with the `keytool`.

### Generate a keystore with Android Studio

Check [this documentation][keystore_generation_link].

### Generate a keystore with commands:

1. Execute one of the following commands:

   ```sh
   # On Linux/MacOS
   $ keytool -genkey -v -keystore ./upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

   # On Windows
   $ keytool -genkey -v -keystore .\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   > **NOTES:**
   >
   > - The keytool command might not be in your path—it’s part of Java, which is installed as part of Android Studio. For the concrete path, run `flutter doctor -v` and locate the path printed after ‘Java binary at:’. Then use that fully qualified path replacing java (at the end) with keytool. If your path includes space-separated names, such as `Program Files`, use platform-appropriate notation for the names. For example, on Mac/Linux use `Program\ Files`, and on Windows use `"Program Files"`.
   >
   > - The `-storetype` JKS tag is only required for Java 9 or newer. As of the Java 9 release, the keystore type defaults to PKS12.

2. These previous commands will prompt you to enter some values. Take note of them in a safe place, since they will be used later.

3. Then, a keystore named `upload-keystore.jks` will be created within the folder where the commands were executed. Place this file within the `android/app/` folder.

   > **DO NOT CHECK THE KEYSTORE INTO PUBLIC SOURCE CONTROL.**

---

## Reference de keystore from the app

This template offers two methods to reference the upload keystore from the app: with a properties file and with environment variables.

<!-- TODO: Since `keyAlias` and `storeFile` do not change, they can be hardcoded in the gradle config and then ignored in the setup process. -->

### Using a `key.properties` file

Create a file named `key.properties` in the `android/` folder and set its content as follows:

```properties
keyAlias=upload
storePassword=<password from previous step>
keyPassword=<password from previous step>
storeFile=../upload-keystore.jks
```

> Since the keystore is located in the `android/` folder and this file is read in the `android/app/` folder, it is necessary to go one level up in the tree.

> **DO NOT CHECK THE `key.properties` FILE INTO PUBLIC SOURCE CONTROL.**

### Using environment variables

Set the following environment variables in your PC:

```sh
# On Linux/MacOS
$ export ANDROID_KEYSTORE_KEY_ALIAS=upload
$ export ANDROID_KEYSTORE_KEY_PASSWORD=<password from previous step>
$ export ANDROID_KEYSTORE_STORE_PASSWORD=<password from previous step>
$ export ANDROID_KEYSTORE_FILE_PATH=../upload-keystore.jks

# On windows
$ set ANDROID_KEYSTORE_KEY_ALIAS=upload
$ set ANDROID_KEYSTORE_KEY_PASSWORD=<password from previous step>
$ set ANDROID_KEYSTORE_STORE_PASSWORD=<password from previous step>
$ set ANDROID_KEYSTORE_FILE_PATH=../upload-keystore.jks
```

> Since the keystore is located in the `android/` folder and this file is read in the `android/app/` folder, it is necessary to go one level up in the tree.

<!-- ? LINKS -->

<!-- Android documentation -->

[keystore_generation_link]: https://developer.android.com/studio/publish/app-signing#generate-key

<!-- Flutter documentation -->

[app_signing_docs_link]: https://flutter.dev/docs/deployment/android#signing-the-app
