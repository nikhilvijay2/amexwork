@isTest
public class ContactTriggerTest {
	//Create Account
	//create contact with US
	//Createcontact with Non US
	//change accounts
	//delete contact
	//
	@testsetup
    static void createData(){
        List<Account> accList = new List<Account>();
        for(integer i=0;i<2;i++){
            Account acc = new Account(Name='Test'+i);
            accList.add(acc);
        }
        insert accList;
    }
    
    //Contact with a US country
    static testmethod void validUSCountry(){
        Id accId = [Select Id from Account Where name='Test1' ].Id;
        
        Test.startTest();
        Contact con = new Contact(LastName='Test1',MailingCountry='US',AccountId=accId);
        insert con;
        Test.stopTest();
        Decimal count = [Select US_Contact_Count__c from Account where ID=:accId].US_Contact_Count__c;
        
        system.assertEquals(1, count);
    }
}