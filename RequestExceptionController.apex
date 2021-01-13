public class RequestExceptionController {
    static String template = '';
    static String template1 = '';
    
    @AuraEnabled
    public static ExceptionWrapper getProcessException(Id sObjectId){ 
        
        String sObjName = sObjectId.getSObjectType().getDescribe().getName(); 
        Processes__c process = [SELECT Id, Name, Region__c,RecordtypeId, Account_Name__c, Primary_Contact__c FROM Processes__c where Id = :sObjectId LIMIT 1];
        if(sObjName == 'Processes__c'){
            system.debug('pro');
            
           if(process.RecordtypeId == System.Label.Record_type_id_for_POS){
                 //template = System.Label.Record_Type_Id_Exception_POS;
               template = '01238000000UUaxAAG';
                                         }
            else if(process.RecordtypeId == System.Label.Record_type_id_for_Connectivity){
                //template = System.Label.Record_Type_Id_Exception_Connectivity;
                template = '01238000000UUawAAG';
                system.debug('temp' +template);
            }
            else if( process.RecordtypeId == System.Label.Record_Type_Id_For_Authorisation){
                //template = System.Label.Record_Type_Id_Exception_Auth;
                template = '01238000000UUavAAG';
                system.debug('temp' +template);
            }
            else if( process.RecordtypeId == system.Label.Record_Type_Id_For_Submission){
                //template = system.Label.Record_Type_Id_Exception_Submission;
                template = '01238000000UUayAAG';
                
            }
           
        } 
        system.debug('template:::value'+template );
        ExceptionWrapper ew = new ExceptionWrapper(process.Account_Name__c, process.Id, process.Region__c, template );
        
        return ew;
        
        
    }
    
    
    @AuraEnabled
    public static ExceptionWrapper.RequestExceptionWrapper getRequestException(Id requestId){
        String sObjReqName = requestId.getSObjectType().getDescribe().getName();
        Request__c request = [Select Id, Name, Account__c From Request__c Where Id =:requestId LIMIT 1];
        system.debug('sObjName'+sObjReqName);
        if( sObjReqName == 'Request__c'){
            system.debug(sObjReqName);
           
            if(request.Name != NULL){
                system.debug('name'+request.Name);
                //template1 = System.Label.Record_Type_Id_Exception_POS;
                template1 = '01238000000UUaxAAG';
            }
       }
        ExceptionWrapper.RequestExceptionWrapper rew = new ExceptionWrapper.RequestExceptionWrapper(request.Account__c,request.Id, template1);
        system.debug('re'+ rew);
            return rew;
        
        
    }
}