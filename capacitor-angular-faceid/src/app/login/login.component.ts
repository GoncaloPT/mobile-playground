import 'capacitor-secure-storage-plugin';
import { Component, OnInit } from '@angular/core';
import { FingerPrintAuth } from 'capacitor-fingerprint-auth';
import { Plugins } from '@capacitor/core';

const { SecureStoragePlugin } = Plugins;
const emailKey: string = "EMAIL_KEY";
const passwordKey: string = "PASSWORD_KEY";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.less']
})

export class LoginComponent implements OnInit {
  constructor() {

  }


  infoMessage: string = '';
  storedUsername: string = '';
  storedPassword: string = '';
  email: string = '';
  password = '';
  //modal control
  loginSuccess: boolean = false;
  loginFailedMessage: string = '';


  /**
   * When login button is pressed.
   * This represents a manual login, we should store credentials in secure storage
   */
  onLogin() {
    this.loginSuccess = false;
    this.loginFailedMessage = '';
    console.log('this.email ', this.email);
    console.log('this.password ', this.password);
    SecureStoragePlugin.set({ key: emailKey, value: this.email });
    SecureStoragePlugin.set({ key: passwordKey, value: this.password });
    this.email = '';
    this.password = '';
    this.infoMessage = 'Credentials stored. Please reload the page to try touchid login';
  }

  ngOnInit(): void {
    // Do we have a stored email?
    SecureStoragePlugin.get({ key: emailKey })
      .then(keyValue => {
        this.storedUsername = keyValue.value;
        SecureStoragePlugin.get({ key: passwordKey })
          .then((entry) => {
            this.storedPassword = entry.value;
            this.tryLoginWithTouchId();
          })
          .catch(err => {
            console.warn(err);
            this.loginFailedMessage = 'No password exists in storage. Please login manually';
          });
      }
      )
      .catch(err => {
        console.warn(err);
        this.loginFailedMessage = 'No email exists in storage. Please login manually';
      });


  }

  async tryLoginWithTouchId(): Promise<void> {
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
      .then(() => {
        this.loginSuccess = true;

      })
      .catch(err => {
        console.log(`Biometric ID NOT OK: ${JSON.stringify(err)}`);
        this.loginFailedMessage = `Biometric ID NOT OK: ${JSON.stringify(err)}`;
      });

  }



}
