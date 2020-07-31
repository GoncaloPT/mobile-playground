# Capacitor + Ionic POC faceid
This POC is to demonstrate the usage of capacitor with a already made angular application.
The use case will be to enable an easy login using faceid


## Executed steps
* Create angular web app with a login form
`ng new capacitor-angular-faceid`  
`ng generate component login`
* Add capacitor to the web application
`ng add @capacitor/angular`  
`npx cap init`  
~~changed capacitor.config.json to used as webDir the value "dist/capacitor-angular-faceid"~~ ( this did not work, capacitor always appends www to the config)  
changed outputPath in angular.json to www  and removed dist folder
`ng build --prod`  
`npx cap add ios`

* Add capacitor plugins
`npm i capacitor-fingerprint-auth`
`npm i capacitor-secure-storage-plugin`
`npx cap update`

## Build angular + capacitor 
`npm build --prod` Builds the angular app into www and then build ios package to platform/ios(capacitor)

## Summary
Capacitor seems to be enterprise license oriented since it doesn't have any out-of-the-box plugins. The existent free plugins are community supported and lack many of the desired features, like keychain access for instance.
Capacitor site advocate that cordova/ionic plugins may also be used.

I've tried to develop the application without adding ionic, since the target app only uses angular.
This proved to be a hard task since must plugins exist in ionic.

~~Current application can do touchid authentication but fails to access a secure storage ( like keychain ) since there is no plugin for that. Therefore a development using only capacitor would have to develop those plugins or wait for the community to develop them.~~ ( just found a plugin that enables this - secure-storage )

* There are incompatible plugins 
https://capacitorjs.com/docs/cordova/known-incompatible-plugins

### Plugins reference
https://github.com/triniwiz/capacitor-fingerprint-auth  
https://github.com/martinkasa/capacitor-secure-storage-plugin

## Screens

- Landing / index
![Landing](screens/IMG_0139.png?raw=true "Landing")

- Trying to login 
![Login try](screens/IMG_0142.png?raw=true "login-try")

- Login Failed, wrong biometrics
![Login failed](screens/IMG_0143.png?raw=true "login-failed")

- Login Ok
![Login ok](screens/IMG_0141.png?raw=true "login-ok")

### Useful stuff
`npx cap open ios` - open xcode