# Cordova 

This POC is to tryout ios touchid using cordova

## Installed plugins

ios-keychain `cordova plugin add https://github.com/ionic-team/cordova-plugin-ios-keychain`

## Usefull information

- List all the possible targers
cordova emulate ios --list

- Run specific target
cordova emulate ios --target="iPhone-6s, 9.3"

- Run on device
cordova run ios

## Development using react

The base application is a react website. Therefore react tools can be used for a faster development  
- use `npm start` to run the application in the browser. This will not give you access to native ( cordova ) functionality maybe be used to develop the look&feel 

## Screens 

- Landing / index
![Screen 1](screens/IMG_0137.PNG?raw=true "screen1")

- After button pressed
![Screen 2](screens/IMG_0138.PNG?raw=true "screen2")