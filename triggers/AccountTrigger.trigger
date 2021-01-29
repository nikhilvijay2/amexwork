trigger AccountTrigger on Account (after insert) {
    Set<Id> accountId = new Set<Id>();
    List<Account> accId = new List<Account>();
    List<Contact> cnt = new List<Contact>();
    
    if(Trigger.isInsert){
        
        for(account a: trigger.old){
            if(a.Contact__c == NULL){
                
                accountId.add(a.Id);
            }
        }
        
        for(Account acc: [Select id, name from Account where id =: accountId]){
            
            Contact c = new Contact(Lastname= acc.Name, AccountId= acc.Id);
            cnt.add(c);
            //acc.Contact__c = c.LastName;
            accId.add(acc);
        }
        
        if(accId.size()>0){
            update accId;
        }
        if(cnt.size()>0){
            insert cnt;
        }
        
        
        
    }
    
}