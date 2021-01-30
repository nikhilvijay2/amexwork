/*
 * Created by sjaya44 on 2020-12-09.
 */

import {LightningElement,api,wire,track} from 'lwc';
import Captcha from '@salesforce/label/c.Captcha';
import initCaptcha from '@salesforce/apex/CaptchaLightningController.initializeCaptcha';
import Captcha_Failure from '@salesforce/label/c.Captcha_Failure';

export default class CaptchaLwc extends LightningElement {

    @track resourceURLs=[];
    @track resourceURL = window.location.origin;
    @track enteredCode;
    @track capResponse;
    @track correctCode = '';
    @track label;
    contentVersions;
    @track resourceURL;
    contentURL;
    @track files= [];

    connectedCallback() {
        this.label = {Captcha, Captcha_Failure};
        this.reloadCaptcha();
    }


     reloadCaptcha(){
         initCaptcha()
                .then(result => {
                    const files = result.contentVersions;
                    this.resourceURL= result.contentURL;

                    for (let i = 0; i < files.length; i++) {
                        var letter = files[i].Title;

                        if (letter.indexOf("X1") !== -1) {
                            letter = letter.replace("X1", "");
                        }
                        this.resourceURLs.push(this.resourceURL[files[i].Id]);
                        this.correctCode +=  letter.replace(".jpg", "");
                    }
                })
                .catch(error => {
                    this.errorMessage = 'An enrollment request has already been received.';
                })
    }

   @api handleCaptcha() {
        const inputField = this.template.querySelector('lightning-input').value;
       this.template.querySelector('lightning-input').classList.remove('c-form-control-warning');
       this.template.querySelector('lightning-input').classList.remove('c-form-control-success');

       this.enteredCode = inputField;
        let success = false;

       console.log('typeof', this.enteredCode );
        if (this.enteredCode) {
       success = this.correctCode.toUpperCase() === this.enteredCode.toUpperCase()
            if(success){
                console.log('success loop');
                let srcElement = this.template.querySelector('.testClass');
                const style = document.createElement('style');
                style.innerText = `c-captcha_lwc .testClass .slds-input {background-color: #FFFFFF;border-color: #54C2B2;}`;
                srcElement.appendChild(style);
                const selectedEvent = new CustomEvent("success", {
                    detail: ({success : true})
                });
                this.dispatchEvent(selectedEvent);
            }

        }


        if (!success) {
            this.template.querySelector('lightning-input').value = '';
            this.template.querySelector('lightning-input').placeholder = 'Captcha Failed. Try again';
            let srcElement = this.template.querySelector('.testClass');
            const style = document.createElement('style');
            style.placeholder = 'Captcha Failed. Try again';
            style.innerText = `c-captcha_lwc .testClass .slds-input {background-color: #fbefec;}`;
            srcElement.appendChild(style);
            this.resourceURLs = [];
            this.enteredCode = '';
            this.correctCode = '';
            this.reloadCaptcha();

        }
    }

}