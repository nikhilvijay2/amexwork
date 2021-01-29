@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    static void testSet(){
        List<Account> acclist = new List<Account>();
        for(Integer i=0;i<50;i++){
            Account a = new Account(Name='Test' + i, BillingState = 'NY');
            accList.add(a);
        }
        
        
        for(Integer j=0; j<50;j++){
            Account a = new Account(Name='Test' + j, BillingState = 'CA');
            accList.add(a);
        }
        
        if(accList.size()>50){
            insert accList;
        }
    }
    
    static testmethod void checkstate(){
        
        contact co = new Contact(FirstName = 'demo', LastName = 'demo');
        insert co;
        string state = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(co,'CA');
        
        Test.startTest();
        system.enqueueJob(apc);
        Test.stopTest();
        
        
        
    }

}