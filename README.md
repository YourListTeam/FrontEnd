# YourList Front-End

This is the subfolder for the front-end of the YourList application. This is a Flutter application for the front end. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

#### Flutter

Flutter code is written in Dart, a client-oriented language. Installation instructions for the Dart SDK can be found in the official [Dart documentation](https://dart.dev/get-dart)

To set up Flutter you can see the official [Flutter documentation](https://flutter.dev/docs/get-started/install). Ensure Flutter is on your path by running the following command:

```
$ flutter --version
Flutter 1.12.13+hotfix.8 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 0b8abb4724 (8 weeks ago) • 2020-02-11 11:44:36 -0800
Engine • revision e1e6ced81d
Tools • Dart 2.7.0
```

#### Andriod Studio

Android Studio is our recommended IDE for working with Flutter. Andriod Studio is also required for setting up and running an Andriod Emulator. The instructions for installing Andriod Studio can be found on the [Andriod Studio site](https://developer.android.com/studio). We would also recommend installing the Flutter plug-in and Dart plug-in for Andriod Studio.

#### Gradle

We utilize Gradle to build automation for our application. Instructions for installing Gradle on your OS can be found on the [offical Gradle website](https://gradle.org/install/). Verify Gradle is installed by running the following command.

```
$ gradle --version

------------------------------------------------------------
Gradle 6.1.1
------------------------------------------------------------

Build time:   2020-01-24 22:30:24 UTC
Revision:     a8c3750babb99d1894378073499d6716a1a1fa5d

Kotlin:       1.3.61
Groovy:       2.5.8
Ant:          Apache Ant(TM) version 1.10.7 compiled on September 1 2019
JVM:          13.0.2 (Oracle Corporation 13.0.2+8)
OS:           Mac OS X 10.15.3 x86_64
```

#### XCode

XCode is optional for working with Flutter, but for running an iOS simulator, XCode is required. We will not go in-depth for XCode, but instructions for setting up can be found [here](https://developer.apple.com/xcode/).

### Installing

#### Flutter Prep
Before going further, ensure you run the `flutter doctor` command in your terminal. This will highlight if any components required for either developing or running flutter are missing. 

#### Google Sign-In - Andriod

First import the YourListApp/andriod Andriod subfolder into Andriod Studio as a Gradle Project, note that this may take a few minutes the first time. 

![](https://i.imgur.com/eVrwpX8.png)

When it finishes all its processes open a Gradle tab (usually located on the right of the project) then locate ‘signingReport’ and run it by double-clicking it.

![](https://i.imgur.com/Gsb5oCK.png)

A similar hash will be visible in the Run section at the bottom of the Android Studio.

![](https://i.imgur.com/BI8QwFY.png)

Then go to Firebase console, and then the Andriod section. 

![](https://i.imgur.com/CI8KfxH.png)

Lastly add your SHA-1 key to firebase, by just clicking add fingerprint and pasting the key you obtained from previous steps.

![](https://i.imgur.com/w9ZHzlK.png)

#### Google Sign-In - iPhone

From the Firebase Console for your project download the GoogleService-Info.plist file. Then, open XCode, by running the following commands.

```
$ cd YourListApp/ios
$ open Runner.xcworkspace
```
You will need to add the GoogleService-Info to the Runner. This is required to run Google Sign-On on iOS.

![](https://i.imgur.com/g1PtPvx.png)

### Development

To begin development, import the YourListApp folder as a Gradle project. To run Flutter, an emulator is required. To create an Andriod emulator, click the AVD Manager button.

![](https://i.imgur.com/q9ftsfO.png)

Then create a Virtual Device, and run it. This may take a few minutes to start up.

![](https://i.imgur.com/zI1IYAA.png)

Then you can the green play button, and Gradle will run and build the Flutter application. This will install the application onto your emulator. For iOS testing, the process is similar, although the AVD Manager is not required. For this, the iOS Simulator must be used to create an emulator for an iOS device.

![](https://i.imgur.com/Rtxdt3t.png)

This requires installing [CocoaPods](https://cocoapods.org/). Verify CocoaPods is installed correctly, and then install required dependencies. This will install all dependencies into a `Pods` folder.

```
$ pod --version
1.9.1
$ cd YourListApp/ios
$ pod install
```

Furthermore, running the application will require updating the URL parameter inside of the `YourListApp/lib/res/val/strings.dart`. Currently, this is configured to point to our development server at `mcsapps.utm.utoronto.ca`. 

Running either the Andriod or iOS emulators requires setting up the Google Firebase Authentication. 

## Deployment

For deployment on iOS, we will need to open XCode the same way as before, and he will need to create and set a Team for signing the application during development.

![](https://i.imgur.com/dPg1zDL.png)

## Built With

* [Flutter](https://flutter.dev/) - The front-end framework used
* [Gradle](https://gradle.org/) - Build Automation!
* [Firebase](https://firebase.google.com/) - Client-side authentication on the Cloud
* [Chopper](https://pub.dev/packages/chopper) - Code Generation for HTTP Clients
* [Material Design](https://material.io/design/) - Design language 
* [Andriod Studio](https://developer.android.com/studio) - IDE for mobile development

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Krish Chowdhary** - *Mentor and PM* - [krishchow](https://github.com/krishchow)

* **Arthur Azarskyy** - *Front-End Lead* - [anshu-p](https://github.com/anshu-p)

* **Anshu Pandey** - *Back-End Lead* - [ArturAzarskyy](https://github.com/ArturAzarskyy)

* **JP Moreno** - *Developer* - [jp-moreno](https://github.com/jp-moreno)

See also the list of [contributors](https://github.com/UTMCSC301/project-yourlist/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thank you to Sadia Sharmin and Ilir Dema for your support in making this project possible!
* Thank you, Andrew Wang, for all of your help in setting up the infrastructure for this project!
