/**
 * Created by ndingari on 12/23/20.
 */
import {LightningElement, wire, api, track} from 'lwc';
import NPP_Style from '@salesforce/resourceUrl/NPP_Resources';
import getgmpcRecords from '@salesforce/apex/GMPCHomePageController.GMPCHomePageController';
import getGmpcComments from '@salesforce/apex/GMPCHomePageController.getGmpcComments';
import getGmpcAttachements from '@salesforce/apex/GMPCHomePageController.getGmpcAttachements';
import updateStatus from '@salesforce/apex/GMPCHomePageController.updateStatus';
import getupdatedRecord from '@salesforce/apex/GMPCHomePageController.getupdatedRecord';
import getupdatedGmpcAttachements from '@salesforce/apex/GMPCHomePageController.getupdatedGmpcAttachements';

export default class Gmpchomepage extends LightningElement {
    @track onclick = true;
    @track hiderecords = true;
    @track detailpage = false;
    nppstyle = NPP_Style + '/GMPC-App-Icon.png' ;
    error;
    @track data;
    @track oppList = [];
    @track comList = [];
    @track attList = [];
    @track gmpcId; // GMPC Id
    @track reId; // GMPCId passed to comments
    @track recId;
    @track com = false;
    @track att = false;
    @track showAttachment = true;
    @track renderAttachmentModal=false;
    @track renderAddComments=false;
    @track disableButton = false;
    @track hide = true;
    @track name;
    @track isLoading = false;
    @api recordId;
    @track parameters;
    @track isNew = true;
    @track noPrev = true;
    @track noNext = true;
    @track page = 1;
    @track totalRecordCount = 0;
    @track totalPage = 1;
    @track pageSize = 10;
    @track pageItems = [];
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track markPartialCompleted = false;
    @track nonStatus = false;
    @track statusvalue;



    cols = [
        {label: 'View',type: 'button-icon', initialWidth: 75, typeAttributes: {iconName: 'action:preview',
                title: 'Preview', variant: 'border-filled', alternativeText: 'View'}},
        {label:'Request Number', fieldName: "Name", type: "text",typeAttributes: { linkify: true }},
        {label:'Merchant', fieldName:'Merchant_Name__c', type:'text'},
        {label:'Effective Date', fieldName:'Requested_Pricing_Change_Effective_Date__c', type:'text', typeAttributes: {
                day: "numeric",
                month: "numeric",
                year: "numeric"
            }},
        {label:'Status', fieldName:'Status__c', type:'text'},
        {label:'Created Date', fieldName:'CreatedDate', type:'date',typeAttributes: {
                day: 'numeric',
                month: 'numeric',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            }},
    ];

    comcols = [{label:'Comment Number', fieldName:'Name', type:'text'},
        {label:'Comment', fieldName:'Comment__c', type:'text'},
        {label:'Created Date', fieldName:'CreatedDate', type:'text',typeAttributes: {
                day: "numeric",
                month: "numeric",
                year: "numeric"
            }}];

    attcols = [{label: 'View', type: 'button',  initialWidth: 135, typeAttributes:
            { label: 'Download File', name: 'Download_file', title: 'Click to Download File' }},
        {label:'Title', fieldName:'Title', type:'text'},
        {label:'Created Date', fieldName:'CreatedDate', type:'text'}
    ];
    params;


   connectedCallback() {
       this.gmpcRecords();
   }


    gmpcRecords() {
        getgmpcRecords()
            .then(data=>{
            this.pageItems = data;
            this.totalRecordCount = data.length;
            this.totalPage = Math.ceil(this.totalRecordCount / this.pageSize);
            if (this.totalPage > 1) {
                this.noNext = false;
            }
            this.data = this.pageItems.slice(0, this.pageSize);
            this.endingRecord = this.pageSize;
            this.error = undefined;
        }).catch(error=> {
            this.error = error;
            this.oppList = undefined;
        })

    }

    viewRecord(event){
        if(event.detail.row.Status__c === 'Pricing Change Completed' || event.detail.row.Status__c ==='Draft'){
            this.disableButton = true;
        } else {
            this.disableButton = false;
        }
        this.name = event.detail.row.Name;
        this.gmpcId  =  event.detail.row.Id;
        console.log('gmpcId', this.gmpcId)
        this.reId = event.detail.row.Id;
        this.recId = event.detail.row.Id;
        this.onclick = false;
        this.detailpage = true;
        this.nonStatus = true;
        this.markPartialCompleted = false;
        this.com = true;
        this.att = true;
        this.handleGetComments(this.reId);
        this.handleGetAttachments(this.recId);
        this.renderAddComments = false;
        var status = event.detail.row.Status__c;

        var el = this.template.querySelector('lightning-datatable');
        var selected = el.getSelectedRows();
        let selectedIdsArray = [];

        for (const element of selected) {
            selectedIdsArray.push(element.Id);
        }
    }

    handlePartialCompleted(event){
        this.detailpage = false;
        this.nonStatus = false;
        this.markPartialCompleted = true;
        this.com = false;
        this.att = false;
        this.disableButton = true;

    }

    handleFullyCompleted(event){
        this.handleCompletedStatus(this.recId);
        this.markPartialCompleted = false;
        this.com = false;
        this.att = false;
    }

    handleCompletedStatus(recId){
        updateStatus({recordId : recId})
            .then(result =>{
                console.log('result.data', result)
                this.parameters = result;
                this.statusvalue = result.Status__c;
                this.disableButton = true;
                this.att = true;
                this.com = true;

            })
            .catch(error =>{
                this.errorMsg = error;
                console.log('error', JSON.stringify(error));
            })
    }

    handleGetComments(reId){
        getGmpcComments({reqId : reId})
            .then(result =>{
                this.comList = result;
                console.log('comList', this.comList)
            })
            .catch(error =>{
                this.errorMsg = error;

            })
    }

    handleGetupdateComments(reId){
        getupdatedRecord({recordId : reId})
            .then(result =>{
                this.comList = result;
                console.log('comList', this.comList)
            })
            .catch(error =>{
                this.errorMsg = error;

            })
    }

    handleGetAttachments(recId){
        getGmpcAttachements({gmId : recId})
            .then(result =>{
                this.attList = result;
                console.log('result', this.attList)
            })
            .catch(error =>{
                this.errorMsg = error;
            })
    }

    opendetail(event){
        console.log('calling',event.detail.row.Id )
        console.log('event.target.dataset.recordId',event.target.dataset.recordId)
        this.onclick = true;
    }

    viewattRecord(event){
        var attId = event.detail.row.ContentDocumentId;
        let urlString = window.location.href;
        this.baseURL = urlString.substring(0, urlString.indexOf('/s'));
        window.open(this.baseURL+'/sfc/servlet.shepherd/document/download/' + attId );
    }

    handleBack(event){
        this.detailpage = false;
        this.onclick = true;
        this.markPartialCompleted = false;
        this.com = false;
        this.att = false;
        this.gmpcRecords();
    }

    handlePrevious() {
        if (this.page > 1) {
            this.page--;
            this.noNext = false;
            if (this.page === 1) {
                this.noPrev = true;
            }
            this.displayRecordsForPage(this.page);
        }
    }

    handleNext() {
        if ((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page++;
            this.noPrev = false;
            if (this.page === this.totalPage) {
                this.noNext = true;
            }
            this.displayRecordsForPage(this.page);
        }
    }

    displayRecordsForPage(page) {
        this.startingRecord = (page - 1) * this.pageSize;
        this.endingRecord = this.pageSize * page;
        if (this.endingRecord > this.totalRecordCount) {
            this.endingRecord = this.totalRecordCount;
        }
        this.data = this.pageItems.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord++;
    }
    handleClick(event) {
        this.renderAttachmentModal=true;
    }

    handleComments(event) {
        this.com = false;
        this.att = false;
        this.renderAddComments=true;
        this.onclick = false;//main dattable
        this.detailpage = false; //detail page
        this.markPartialCompleted = false;
    }

    handleSubmit(event) {
        this.markPartialCompleted = false;
        const fields = event.detail.fields;
        event.preventDefault();
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        setTimeout(() => {
            this.handleGetupdateComments(this.reId);
        }, 500)
        this.renderAddComments = false;
        this.detailpage = true;
        this.com = true;
        this.att = true;

    }

    handleSubmitAction(event){
        this.markPartialCompleted = false;
        const fields = event.detail.fields;
        event.preventDefault();
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        this.detailpage = true;
        this.com = true;
        this.att = true;
        this.disableButton = true;

    }

    handleCancelAction(event) {
        this.renderAddComments = false;
        this.detailpage = true;
        this.com = true;
        this.att = true;
        this.markPartialCompleted = false;

    }

    CancelCommentAction(event){
        this.renderAddComments = false;
        this.detailpage = true;
        this.com = true;
        this.att = true;
    }

    handleSuccess(event) {
        getupdatedGmpcAttachements({gmId : recId})
            .then(result =>{
                this.attList = result;
                console.log('result2', this.attList)
            })
            .catch(error =>{
                this.errorMsg = error;
            })

        this.renderAddComments = false;
        this.detailpage = true;
        this.att = true;
        this.com = true;

    }
    getLatestAttachments(){
        this.getRecords(this.gmpcId);
        this.renderAttachmentModal = false;

    }
    getRecords(gmpcId){
        getupdatedGmpcAttachements({gmId : gmpcId})
            .then(result =>{
                this.attList = result;
            })
            .catch(error =>{
                this.errorMsg = error;
            })
    }

    cancelModal(){
        this.renderAttachmentModal = false;
    }


}