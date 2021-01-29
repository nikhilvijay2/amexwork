trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    
    List<Task> tskList = new List<Task>();
    
    for(opportunity opp: trigger.new){
        
        if(opp.StageName=='Closed Won'){
            
            Task tsk = new Task();
            tsk.Subject = 'Follow Up Test Task';
            tsk.WhatId = opp.Id;
            tskList.add(tsk);
        }
    }
    
    if(tskList.size()>0){
        insert tskList;
    }

}