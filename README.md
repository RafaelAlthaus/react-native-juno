[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# react-native-juno

React Native Bridge for Juno's SDK. For more information, visit the official [Android](https://github.com/tamojuno/direct-checkout-android) or [iOS](https://github.com/tamojuno/direct-checkout-ios) repositories.

## Getting started

`$ npm install react-native-juno --save`

### Extra steps for iOS

`$ cd ios && pod install`

Run this on the root of your project to make it compatible with Swift.
`$ npm install react-native-swift`
`$ react-native swiftify`

Keep in mind that this lib requires at least Swift 4 and Deployment Target 11.0.

### Extra steps for Android

In your `AndroidManifest.xml` add permission for internet and your public token.

```xml
<manifest>

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
           ...
           android:name=".MainApplication"
           ...>

        <meta-data
                android:name="br.com.juno.directcheckout.public_token"
                android:value="YOUR_PUBLIC_TOKEN"/>

            ...

    </application>

</manifest>
```

### If you're running React Native =< 0.59

`$ react-native link react-native-juno`

### Manual installation (optional)


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-juno` and add `RNJuno.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNJuno.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactnative.juno.RNJunoPackage;` to the imports at the top of the file
  - Add `new RNJunoPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-juno'
  	project(':react-native-juno').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-juno/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-juno')
  	```


## Usage

Most of the functions detailed on the official documentation were implemented on this bridge. Here is some examples of each one of them.

```javascript
import RNJuno from 'react-native-juno';

// You need to initialize the SDK before using the card hash method.
// The first parameter is your public key. This can be null on Android since it's already declared on the Manifest file.
// The second parameter is whether to run it on production or Sandbox. TRUE for production, FALSE for sandbox.
RNJuno.initialize("AC2261A2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5", true);

// This function returns a hash for the credit card informed.
// The first parameter is the Credit Card Number.
// The second parameter is the Holders Name.
// The third parameter is the Security Code.
// The fourth parameter is the Expiration Month.
// The fifth parameter is the Expiration Year.
// The sixth parameter is a callback function, containing the error message as the first parameter (String) and the hash as the second parameter (String).
RNJuno.getCardHash("5362682003164890", "Rafael Althaus", "123", "01", "2025", (error, data) => {
      if (error) {
        console.log("ERROR: " + error);
      } else {
        console.log("HASH: " + data);
      }
});

// Returns if the card number is valid.
// The first parameter is the card number.
// The second parameter is a callback function informing if the number is valid as TRUE of FALSE.
RNJuno.isValidCardNumber("5362682003164890", (data) => {
      console.log("VALID CARD NUMBER: " + data);
});

// Returns if the expire date is valid.
// The first parameter is the month number.
// The second parameter is the year number.
// The third parameter is a callback function informing if the date is valid as TRUE of FALSE.
RNJuno.isValidExpireDate("01", "2025", (data) => {
      console.log("VALID EXPIRE DATE: " + data);
});

// Returns if the security code is valid.
// The first parameter is the security code.
// The second parameter is the card number.
// The third parameter is a callback function informing if the security code is valid as TRUE of FALSE.
RNJuno.isValidSecurityCode("123", "5362682003164890", (data) => {
      console.log("VALID SECURITY CODE: " + data);
});
```

## Known issues

- I wasn't able to implement the `getCardType` function because it was declared as private on the SDK;
- We currently need to declare `retrofit2` as a dependency is this project since it's needed in the SDK and it's not declared in it;
- We're not able to set the public token dynamically on init in Android since the Android SDK only gets the token from the Manifest meta-data. We would really like to have an option to pass the token as a parameter in the initialize function in the future.

## Sharing is caring

All contributions are welcome! Let's maintain this project as up-to-date and bug free as possible. If you're having any trouble, feel free to open an issue, I'll respond ASAP.