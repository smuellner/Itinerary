# Itinerary - A route planning application for iOS
The application uses information from [HERE](http://www.here.com) using their [Maps API](https://developer.here.com) to allow to search for places and calculate a route for a start location and multiple stops.

[![Build Status](https://travis-ci.org/smuellner/Itinerary.svg?branch=master)](https://travis-ci.org/smuellner/Itinerary)

## Requirements
* [Xcode 7](https://developer.apple.com/xcode/)
* [CocoaPods](https://cocoapods.org) @optional

### Setup Itinerary
#### Set the HERE Maps API credentials
To use the HERE Maps API you need to fill in your Maps API credentials by opening the information property list file 'Info.plist' of the Itinerary application with your favorite editor e.g.:

```bash
~/<DownloadFolder>/Itinerary/Itinerary$ open Info.plist
```

Where you fill in the generated appId for the key 'PRHereAppId' and the appCode for the key 'PRHereAppCode'.

Key | Value
------------ | -------------
PRHereAppId | Your generated HERE API Key
PRHereAppCode | Your generated HERE API Code

You can request your HERE Maps API credentials from the [HERE developer website](https://developer.here.com).

## Run Itinerary
To run the Itinerary application open the 'Itinerary.xcworkspace' file in Xcode:

```bash
~/<DownloadFolder>/Itinerary$ open Itinerary.xcworkspace
```

Then you can just run it in Xcode using the selected simulator.



## Development Setup
For further development of the 'Itinerary' application or the 'PlacesAndRouting' framework it is necessary to install the CocoaPods.

### CocoaPods
Setup CocoaPods according to the installation documentation from their website [CocoaPods - Getting Started](https://guides.cocoapods.org/using/getting-started.html).
The simplest way should be tu run 'gem install' of the CocoaPods in your terminal:

```bash
$ sudo gem install cocoapods
```

#### Update CocoaPods
Go to the folder to where you downloaded the GitHub sources of the Itinerary application using the terminal and change to the application directory.
Now you can just update the CocoaPods of the project using the command:

```bash
~/<DownloadFolder>/Itinerary$ pod update
```

## Dependencies 

### Itinerary application 
* [MagicalRecord ~> 2.3.2](https://github.com/magicalpanda/MagicalRecord)
* [SCLAlertView-Objective-C ~> 1.0.2](https://github.com/dogo/SCLAlertView)
* PlacesAndRouting ~> 1.0.0

### Places and Routing framework 
* [AFNetworking ~> 3.0.4](https://github.com/AFNetworking/AFNetworking)
* [YYModel ~> 1.0.1](https://github.com/ibireme/YYModel)


## License (MIT)

Copyright (C) 2016 Sascha Müllner

See the attached LICENSE file.