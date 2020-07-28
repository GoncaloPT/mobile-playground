/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
const KEY_NAME = "MY_KEY";
var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function () {
        this.receivedEvent('deviceready');


    },

    // Update DOM on a Received Event
    receivedEvent: function (id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();


function loginClicked() {

    // insert the key for later usage
    window.plugins.touchid.save(KEY_NAME, "This is the stored passphrase", function() {
        onLogin();
    });
    
}
function retrieveFromTouchId(keyName){
    window.plugins.touchid.verify(KEY_NAME, "Use TouchID to get password", (password) => {
        alert("The stored password is: " + password);
    }, (errorMessage) => {
        alert("TouchID Failed: " + errorMessage);
    });

}
// Login
function onLogin() {

    
    if (window.plugins.touchid) {
        window.plugins.touchid.isAvailable(() => {
            
            // verify that the key exists, as expected
            window.plugins.touchid.has(KEY_NAME, function() {
                retrieveFromTouchId(KEY_NAME);
            }, function() {
                alert("Touch ID available but no Password Key available");
            });

        }, (errorMessage) => {
            alert("isAvailable failed : " + JSON.stringify(errorMessage));
        })
    }
    else {
        alert("touchid plugin not loaded!");
    }
}
document.getElementById('login').addEventListener("click", loginClicked);
