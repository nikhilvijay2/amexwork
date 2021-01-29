global class AccountProcessor {
    
    @future
    
    public static void countContacts(Set<Id> AccountIds){
        
            List<Account> accList = new List<Account>();
            List<Account> lstAccount = [Select Id, Number_Of_Contacts__c, (select Id, AccountId from contacts)
                                        from Account Where ID IN :AccountIds];
        
        for(Account a: lstAccount){

               a.Number_Of_Contacts__c = a.Contacts.Size();
            accList.add(a);
        }

        if(accList.size()>0){
            update accList;
        }
         
            
        }
    }