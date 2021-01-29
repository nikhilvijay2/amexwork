@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void testSchedulable(){
        
        List<Lead> leList = new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead l = new Lead();
            l.Company = 'Company' + i;
            l.LastName = 'Test' + i;
            l.Status = 'Open - Not Contacted';
            leList.add(l);
        }
        
        if(leList.size()>0){
            insert leList;
        }
        
        
       Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        List<Lead> lt = [SELECT Id 
            FROM Lead 
            WHERE Id IN :leList];
        System.assertEquals(200, leList.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
    }

}