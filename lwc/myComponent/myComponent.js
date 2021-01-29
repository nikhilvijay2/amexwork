import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.ContactLister';

export default class contactList extends LightningElement {}
@api recordId;
const columns = [
    {label: 'First Name', fieldName: 'FirstName'},
    {label: 'Last Name', fieldName: 'LastName'},
    {label: 'Title', fieldName: 'Title'},
    {label: 'Email', fieldName: 'email', type: 'email'},
];
error;
columns = columns;

@wire(getContacts)
contacts;