import React, { useState } from 'react';
const KEY_NAME = "KEY_NAME";
const state = ({ currentKeyValue: "SecretValue" });
/**
    * Util function to check if touchid is defined
    * If is not defined a console warn is sent
    * If is defined, the callback is executed, sending touchid instance as parameter
    * @param {*} successCallback 
    */
const touchIdPluginExists = () => {
    if (window.plugins && window.plugins.touchid) {
        return true;
    }
    else {
        console.warn("touchid is not defined. Is this running on cordova?");
        alert('No touchid plugin');
    }

}
/**
 * Called by UI when login button is clicked
 * @param {*} e 
 */
const handleLoginClick = (e) => {
    
    console.log('currentKeyValue ' + state.currentKeyValue);
    if (touchIdPluginExists()) {
        window.plugins.touchid.save(KEY_NAME, state.currentKeyValue, function () {
            console.log('calling onLogin');
            onLogin();
        }, (err) => {console.warn("save failed with ", err)})
    }


};
/**
 * Called by UI when input changes
 * @param {*} newValue 
 */
const onSecretChange = (newValue) => {
    state.currentKeyValue = newValue;
    console.log("onSecretChange: " + state.currentKeyValue);
    if (window.plugins && window.plugins.touchid) {
        window.plugins.touchid.save(KEY_NAME, state.currentKeyValue, function () {
            console.log("value updated.");
        })
    }
    else {
        console.warn("touchid is not defined. Is this running on cordova?");
        alert('No touchid plugin');
    }
}
/**
 * tries to get value for keyName in touchid
 * @param {*} keyName 
 */
const retrieveFromTouchId = (keyName) => {

    if (touchIdPluginExists()) {
        window.plugins.touchid.verify(keyName, "Use TouchID to get password", (password) => {
            alert("The stored password is: " + password);
        }, (errorMessage) => {
            alert("TouchID Failed: " + errorMessage);
        })
    };
};

// Login
const onLogin = () => {

    if (touchIdPluginExists()) {
        window.plugins.touchid.isAvailable(() => {
            // verify that the key exists, as expected
            window.plugins.touchid.has(KEY_NAME, function () {
                retrieveFromTouchId(KEY_NAME);
            }, function () {
                alert("Touch ID available but no Password Key available");
            });

        }, (errorMessage) => {
            alert("isAvailable failed : " + JSON.stringify(errorMessage));
        })
    };
}

function Login() {

    
    return (
        <div className="row mt-3">
            <div className="col-12">
                <h2 className="text-left">Description</h2>
                <hr />
                <p className="text-left">
                    Click on the button bellow to get the store password in key chain using the touchid. <br />
                    The stored password can be changed near the "Stored password" text
                </p>
            </div>

            <div className="input-group mt-2 mb-3">
                <div className="input-group-prepend">
                    <span className="input-group-text" id="basic-addon1">Stored password</span>
                </div>
                <input type="text" name="currentKeyValue"
                    value={state.currentKeyValue}
                    onChange={e => onSecretChange(e.target.value)
                    }
                    disabled="true"
                    className="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1"
                />
            </div>



            <div className="col-12 mt-5">
                <button id="login" type="submit" onClick={handleLoginClick} className="btn btn-primary" >Get stored password with touchID</button>
            </div>

        </div>


    )
    
}

export default Login;
