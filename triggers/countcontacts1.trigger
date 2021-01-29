trigger countcontacts1 on Contact (after insert,after update,after delete,after undelete) {
if(trigger.isafter){
if(trigger.isinsert){
mytriggercount.counttrigger(trigger.new);
}
}
if(trigger.isafter){
if(trigger.isundelete){
mytriggercount.counttrigger(trigger.new);
}

}
if(trigger.isafter){
if(trigger.isupdate){
mytriggercount.counttrigger(trigger.new);
}
}
if(trigger.isafter){
if(trigger.isupdate){
mytriggercount.counttrigger(trigger.old);
}
}
if(trigger.isafter){
if(trigger.isdelete){
mytriggercount.counttrigger(trigger.old);
}
}
}
    
    
    
    
    
    
    
    
    
    /*
     trigger Contacttrigger on Contact (after insert,after Update,After Delete) {
	   if(trigger.isAfter){
        if(trigger.isUpdate){
        AccountHelper.noOfConts(trigger.new);
    }
    } 
    

    
    
    Set<Id> accountIds = new Set<Id>();

	List<Account> updateAccList  = new List<Account>();
    if(Trigger.isInsert ){
        for(Contact c : Trigger.new){
            if(c.MailingCountry=='US'){
                accountIds.add(c.accountId);
            }
        }
    }
    
    if(Trigger.isUpdate){
        for(Contact c : Trigger.new){
            if(trigger.oldMap.get(c.Id).mailingcountry!=c.MailingCountry || trigger.oldMap.get(c.ID).AccountId!=c.AccountId){
                 accountIds.add(c.accountId);
                accountIds.add(trigger.oldMap.get(c.Id).AccountId);
            }
        }
    }
    
    if(Trigger.isDelete){
        for(Contact c : Trigger.old){
            if(c.MailingCountry=='US'){
                accountIds.add(c.accountId);
            }
        }
    }
    
    For(Account a : [Select Id,US_Contact_Count__c,(select ID,mailingcountry from Contacts where mailingcountry='US') from Account where id=:accountIds]){
        a.US_Contact_Count__c = a.contacts.size();
        updateAccList.add(a);
    }
    
    if(updateAccList.size()>0){
        update updateAccList;
    }*/