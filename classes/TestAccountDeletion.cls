@isTest
public class TestAccountDeletion {
    
    @isTest static void setup(){
        Account a = new Account(Name= 'Test Account');
        insert a;
        
        Opportunity opp = new Opportunity(Name=a.Name + 'Opportunity',
                                          StageName = 'Prospecting', CloseDate = system.today().addDays(10), AccountId=a.Id );
        insert opp;
        
        Database.DeleteResult result = Database.delete(a,false);
        
        system.assert(!result.isSuccess());
        
        system.assert(result.getErrors().size()>0);
        system.assertEquals('Account with related opportunity cant be deleted',result.getErrors()[0].getMessage());
    
    }
    
    
    

}