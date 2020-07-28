/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "TouchID.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Cordova/CDV.h>

static NSString *const FingerprintDatabaseStateKey = @"FingerprintDatabaseStateKey";

@implementation TouchID

- (void) isAvailable:(CDVInvokedUrlCommand*)command {

    LAContext *context = [[LAContext alloc] init];
    
    
    
    // Hide "Enter Password" button
    context.localizedFallbackTitle = @"";
    context.localizedCancelTitle   = @"";
    context.maxBiometryFailures = @5;

    
  if (NSClassFromString(@"LAContext") == NULL) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
    return;
  }

  [self.commandDelegate runInBackground:^{

    NSError *error = nil;
    LAContext *laContext = [[LAContext alloc] init];

      
     
      
      // Hide "Enter Password" button
      laContext.localizedFallbackTitle = @"";
      laContext.localizedCancelTitle   = @"";
      laContext.maxBiometryFailures = @5;

  

    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
      NSString *biometryType = @"touch";

        
        
        
        // Hide "Enter Password" button
        laContext.localizedFallbackTitle = @"";
        laContext.localizedCancelTitle   = @"";
        laContext.maxBiometryFailures = @5;

        
      if (@available(iOS 11.0, *)) {
        if (laContext.biometryType == LABiometryTypeFaceID) {
          biometryType = @"face";
        }
      }
      [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:biometryType]
                                  callbackId:command.callbackId];
    } else {
      NSArray *errorKeys = @[@"code", @"localizedDescription"];
      [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error dictionaryWithValuesForKeys:errorKeys]]
                                  callbackId:command.callbackId];
    }
  }];
}

- (void)setLocale:(CDVInvokedUrlCommand*)command{
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)has:(CDVInvokedUrlCommand*)command{
  	self.TAG = (NSString*)[command.arguments objectAtIndex:0];
    BOOL hasLoginKey = [[NSUserDefaults standardUserDefaults] boolForKey:self.TAG];
    if(hasLoginKey){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"No Password in chain"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)save:(CDVInvokedUrlCommand*)command{
	 	self.TAG = (NSString*)[command.arguments objectAtIndex:0];
    NSString* password = (NSString*)[command.arguments objectAtIndex:1];
    @try {
        self.MyKeychainWrapper = [[KeychainWrapper alloc]init];
        [self.MyKeychainWrapper mySetObject:password forKey:(__bridge id)(kSecValueData)];
        [self.MyKeychainWrapper writeToKeychain];
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:self.TAG];
        [[NSUserDefaults standardUserDefaults]synchronize];

        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch(NSException *exception){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Password could not be save in chain"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void) didFingerprintDatabaseChange:(CDVInvokedUrlCommand*)command {
  // Get enrollment state
  [self.commandDelegate runInBackground:^{
    LAContext *laContext = [[LAContext alloc] init];
    NSError *error = nil;

    // we expect the dev to have checked 'isAvailable' already so this should not return an error,
    // we do however need to run canEvaluatePolicy here in order to get a non-nil evaluatedPolicyDomainState
    if (![laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
      [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]] callbackId:command.callbackId];
      return;
    }

    // only supported on iOS9+, so check this.. if not supported just report back as false
    if (![laContext respondsToSelector:@selector(evaluatedPolicyDomainState)]) {
      [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO] callbackId:command.callbackId];
      return;
    }

   
      
      
      // Hide "Enter Password" button
      laContext.localizedFallbackTitle = @"";
      laContext.localizedCancelTitle   = @"";
      laContext.maxBiometryFailures = @5;

      
      
    NSData * state = [laContext evaluatedPolicyDomainState];
    if (state != nil) {

      NSString * stateStr = [state base64EncodedStringWithOptions:0];

      NSString * storedState = [[NSUserDefaults standardUserDefaults] stringForKey:FingerprintDatabaseStateKey];

      // whenever a finger is added/changed/removed the value of the storedState changes,
      // so compare agains a value we previously stored in the context of this app
      BOOL changed = storedState != nil && ![stateStr isEqualToString:storedState];

      [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:changed] callbackId:command.callbackId];

      // Store enrollment
      [[NSUserDefaults standardUserDefaults] setObject:stateStr forKey:FingerprintDatabaseStateKey];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
  }];
}

-(void)delete:(CDVInvokedUrlCommand*)command{
	 	self.TAG = (NSString*)[command.arguments objectAtIndex:0];
    @try {

        if(self.TAG && [[NSUserDefaults standardUserDefaults] objectForKey:self.TAG])
        {
            self.MyKeychainWrapper = [[KeychainWrapper alloc]init];
            [self.MyKeychainWrapper resetKeychainItem];
        }


        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.TAG];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch(NSException *exception) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Could not delete password from chain"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }


}

-(void)verify:(CDVInvokedUrlCommand*)command{
    // Hide "Enter Password" button
    self.laContext.localizedFallbackTitle = @"";
    self.laContext.localizedCancelTitle   = @"";
    self.laContext.maxBiometryFailures = @5;

    
    
    
	 	self.TAG = (NSString*)[command.arguments objectAtIndex:0];
	  NSString* message = (NSString*)[command.arguments objectAtIndex:1];
    self.laContext = [[LAContext alloc] init];
    self.MyKeychainWrapper = [[KeychainWrapper alloc]init];

    // Hide "Enter Password" button
    self.laContext.localizedFallbackTitle = @"";
    self.laContext.localizedCancelTitle   = @"";
    self.laContext.maxBiometryFailures = @10;

    
    BOOL hasLoginKey = [[NSUserDefaults standardUserDefaults] boolForKey:self.TAG];
    if(hasLoginKey){
        BOOL touchIDAvailable = [self.laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
        // Hide "Enter Password" button
        self.laContext.localizedFallbackTitle = @"";
        self.laContext.localizedCancelTitle   = @"";
        self.laContext.maxBiometryFailures = @5;

        
        if(touchIDAvailable){
            
            // Hide "Enter Password" button
            self.laContext.localizedFallbackTitle = @"";
            self.laContext.localizedCancelTitle   = @"";
            self.laContext.maxBiometryFailures = @5;
            
            [self.laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL success, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{

                if(success){
                    NSString *password = [self.MyKeychainWrapper myObjectForKey:@"v_Data"];
                    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: password];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }
                if(error != nil) {
                    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: [NSString stringWithFormat:@"%li", error.code]];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }
                });
            }];

        }
        else{
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"-1"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }
    else{
           CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"-1"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}
@end
