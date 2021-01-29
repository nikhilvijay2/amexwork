global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, Name, LeadSource from Lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> Scope){
        
        List<Lead> leadList = new List<Lead>();
        for(Lead l: Scope){
            l.LeadSource = 'Dreamforce';
            leadList.add(l);
            recordsProcessed = recordsProcessed + 1;
        }
    update leadList;
    }
    
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);
        
    }

}