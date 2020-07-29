cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-biometric-keychain.TouchID",
      "file": "plugins/cordova-plugin-biometric-keychain/www/touchid.js",
      "pluginId": "cordova-plugin-biometric-keychain",
      "clobbers": [
        "window.plugins.touchid"
      ]
    },
    {
      "id": "cordova-plugin-ios-keychain.Keychain",
      "file": "plugins/cordova-plugin-ios-keychain/www/keychain.js",
      "pluginId": "cordova-plugin-ios-keychain",
      "clobbers": [
        "window.Keychain"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-biometric-keychain": "0.0.4",
    "cordova-plugin-ios-keychain": "3.0.1",
    "cordova-plugin-whitelist": "1.3.4"
  };
});