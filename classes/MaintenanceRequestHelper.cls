public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> caseList) {
        
        for(Case cas : caseList){
            if(cas.status == 'Closed'){
                Case ca = new Case();
                ca.Vehicle__c = cas.Vehicle__c;
                ca.Equipment__c = cas.Equipment__c;
                ca.Status = 'Routine Maintenance';
                ca.Subject = 'Maintenance is Required';
                ca.Date_Reported__c = cas.ClosedDate.Date();
                
                List<Work_Part__c> wps = [Select Id, Equipment__c , Maintenance_Request__c  from Work_Part__c];
            } 
        }
        
        
        
    }        
    
}