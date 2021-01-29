public class mytriggercount{
public static void counttrigger(contact [] cts){
set<id> accidlist = new set<id>();
for(contact con:cts){
accidlist.add(con.Accountid);
}
list<account> acc = new list<account>();
for(Account a:[select id,US_Contact_Count__c,(select id from contacts)from Account where id IN:accidlist]){
a.US_Contact_Count__c = a.contacts.size();
acc.add(a);
}
update acc;
}
}


/*public class AccountHelper {
    
    public static void noOfConts(List<Contact> IdList){
        
       // Map<Id, contact> cntMap = new Map<Id, Account>();
        set<Id> AccountId = new set<Id>();
        List<Account> accList = new List<Account>();
        
        
        
        
        for(Contact con: IdList){
            if(con.MailingCountry == 'US' && con.AccountId != NULL){
                AccountId.add(con.AccountId);
            }
        }
        
        for(Account a : [Select Id, name, (select Id, name from Contacts) from 
                         Account Where Id=:AccountId]){
            a.US_Contact_Count__c = a.contacts.size();
                             accList.add(a);
                             
        }
        try{if(accList.size()>0){
            update accList;
        }} catch(DmlException e){
            system.debug('Error' +e.getMessage());
        }
        
        
    }

}*/