@isTest
public class AccountProcessorTest {
    
    @isTest static void countofcontacts(){
        List<Contact> cntList = new List<Contact>();
        
        Account a = new Account(Name='Test Account');
        insert a;
        
        
            Contact c = new Contact(LastName='Test Contact', AccountId = a.Id);
            cntList.add(c);
        
        
        insert cntList;
        
        set<Id> accId = new set<Id>();
        accId.add(a.Id);
        Test.startTest();
        AccountProcessor.countContacts(accId);
        Test.stopTest();
        
        Account acc = [select Number_Of_Contacts__c from Account Where ID = :a.Id LIMIT 1];
        
        system.assertEquals(1,Integer.valueOf(acc.Number_Of_Contacts__c));
    }

}