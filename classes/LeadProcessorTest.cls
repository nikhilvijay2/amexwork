@isTest
public class LeadProcessorTest {
    @testSetup
    
    static void testSetup(){
        List<Lead> leList = new List<Lead>();
        
        for(Integer i=0;i<200;i++){
            leList.add(new Lead(LastName='Test Lead'+i, Company='Company'+i, Status='Open-Not Contacted'));
        }
        
        insert leList;
        
        
    }
    
    static testmethod void testLead(){
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        
        system.assertEquals(200, [select count() from Lead Where LeadSource='Dreamforce']);
        
    }

}