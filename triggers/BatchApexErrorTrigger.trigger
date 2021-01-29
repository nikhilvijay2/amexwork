trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    
    List<BatchLeadConvertErrors__c> bce = new List<BatchLeadConvertErrors__c>();
    
    for(BatchApexErrorEvent bae : Trigger.new){
        
        BatchLeadConvertErrors__c blc = new BatchLeadConvertErrors__c();
        blc.AsyncApexJobId__c = bae.AsyncApexJobId;
        blc.Records__c = bae.JobScope;
        blc.StackTrace__c = bae.StackTrace;
        bce.add(blc);
        
    }
    
    insert bce;

}