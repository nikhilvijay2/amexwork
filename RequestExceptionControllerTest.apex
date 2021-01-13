@IsTest
public class RequestExceptionControllerTest {
    
    @testsetup static void setup() {
        Account testAcct = new Account(Name = 'Test Account');
        insert testAcct; 
        Contact cnt = new Contact(FirstName = 'Test',LastName='Contact',Email='test@sfdc.com', AccountId = testAcct.Id);
        insert cnt;
        
        User testUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        RecordType exceptionRT = [SELECT Id, Name from RecordType where sobjecttype ='Exceptions__c' and DeveloperName ='Connectivity' limit 1];
        RecordType processRT = [SELECT id FROM RecordType WHERE  SobjectType = 'Processes__c' AND DeveloperName = 'Connectivity'];
        
        Processes__c process = new Processes__c();
        process.Account_Name__c = testAcct.Id;
        process.Process_Sub_types__c = 'General Maintenance';
        process.Name = 'Test';
        process.Primary_Contact__c = cnt.Id;
        process.Region__c = 'EMEA';
        process.Project_Description__c = 'Test Description';
        process.RecordTypeId = processRT.Id;
        Insert process;
        
        Request__c request = new Request__c();
        request.Account__c = testAcct.Id;
        request.Submitter__c = testUser.Id;
        request.Device_Provider_Name__c = 'Test';
        request.Device_Software_Name__c = 'Test';
        request.Device_Name_Model__c = 'Test';
        request.Message_Specification__c = 'APACS 30';
        request.Device_Interface__c = 'Dual Interface';
        request.PIN_Pad__c = 'Device and PIN Pad';
        request.Contact_Name__c = 'Test cnt';
        request.Contact_Email__c = 'test@salesforce.com';
        request.Submission_Date__c = System.today();
        insert request;
        }
    
    @IsTest static void testgetTemplateValue(){
         Processes__c processExc = [SELECT Id, Name, Account_Name__c, Region__c, RecordTypeId FROM Processes__c ];
        RecordType exceptionRtId = [SELECT Id, Name from RecordType where sobjecttype ='Exceptions__c' and DeveloperName ='Connectivity' limit 1];
         RequestExceptionController.ExceptionWrapper ew =  RequestExceptionController.getProcessException(processExc.Id);
        System.assertEquals(processExc.Account_Name__c, ew.accountName);
        System.assertEquals(processExc.Id, ew.projectName);
        System.assertEquals(processExc.Region__c, ew.region);
        System.assertEquals(exceptionRtId.Id, ew.exceptionRTId);
    }
    
    
    @IsTest static void testgetRequestException(){
         Request__c reqExc = [SELECT Id, Name, Account__c FROM Request__c ];
        RecordType exceptionPOSRtId = [SELECT Id, Name from RecordType where sobjecttype ='Exceptions__c' and DeveloperName ='POS_Terminal' limit 1];
         RequestExceptionController.RequestExceptionWrapper ew =  RequestExceptionController.getRequestException(reqExc.Id);
        System.assertEquals(reqExc.Account__c, ew.accName);
        System.assertEquals(reqExc.Id, ew.requestName);
        System.assertEquals(exceptionPOSRtId.Id, ew.exceptionRTId);
    }
    
    
    
}