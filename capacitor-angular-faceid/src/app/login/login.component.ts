import { Component, OnInit } from '@angular/core';
import { FingerPrintAuth } from 'capacitor-fingerprint-auth';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.less']
})
export class LoginComponent implements OnInit {
  constructor() {

  }
  static readonly emailKey: string = "EMAIL_KEY";
  static readonly passwordKey: string = "PASSWORD_KEY";

  storedUsername: string = 'value';
  storedPassword: string = 'secretPassword';
  email: string = 'myStoreEmail@keychain.ios';
  password = '';
  //modal control
  loginSuccess: boolean = false;
  loginFailedMessage: string = '';

  
  async onLogin() {
    this.loginSuccess = false;
    this.loginFailedMessage = '';
    let auth = new FingerPrintAuth();
    let available = await auth.available()
      .then(() => this.fingerPrintLogin(auth))
      .catch((err) => {
        console.log('warn');
        this.loginFailedMessage = 'Touchid login is not available. Err message: ' + err;
      });

  }

  async fingerPrintLogin(auth: FingerPrintAuth) {
    let fingerprintAuth = await new FingerPrintAuth()
    .verify()
    .then(() => this.loginSuccess = true)
      .catch(err => {
        console.log(`Biometric ID NOT OK: ${JSON.stringify(err)}`);
        this.loginFailedMessage = `Biometric ID NOT OK: ${JSON.stringify(err)}`;
      });
    /*fingerprintAuth.verify(
      {
        message: 'Scan your finger', // optional (used on both platforms) - for FaceID on iOS see the notes about NSFaceIDUsageDescription
        fallbackTitle: "Scan failed. Please insert your password", //The localized title for the fallback button in the dialog presented to the user during authentication.
        cancelTitle: "Cancel"
      })
      .then(() => this.loginSuccess = true)
      .catch(err => {
        console.log(`Biometric ID NOT OK: ${JSON.stringify(err)}`);
        this.loginFailedMessage = `Biometric ID NOT OK: ${JSON.stringify(err)}`;
      });
      */
  }



  ngOnInit(): void {

  }

}
