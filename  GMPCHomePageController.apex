public class GMPCHomePageController {
    
    @AuraEnabled
    public static List<Global_Merchant_Pricing_Change__c> GMPCHomePageController(){
        return[select Id, Name, Merchant_Name__c, Requested_Pricing_Change_Effective_Date__c, Status__c, CreatedDate
                    from Global_Merchant_Pricing_Change__c
                    where Status__c != 'Draft' order by CreatedDate desc];
    }
    
    @AuraEnabled
    public static List<Global_Merchant_Pricing_Change_Comments__c>  getGmpcComments(Id reqId){
       return[select Id, Name, Comment__c, CreatedDate
                from Global_Merchant_Pricing_Change_Comments__c
                where Parent_Record_Number__c =:reqId
                order by CreatedDate desc];   
    }
    
    @AuraEnabled(cacheable = true)
    public static List<ContentVersion>  getGmpcAttachements(Id gmId){
        List<ContentDocument> lstCV = new List<ContentDocument>();
        Set<Id> setDLinkIds = new Set<Id>();
        for(ContentDocumentLink dlink : [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId =: gmId]){
            setDLinkIds.add(dlink.ContentDocumentId);
        }
        return [select Id, Title, PathOnClient, CreatedDate,ContentDocumentId FROM ContentVersion where  ContentDocumentId in : setDLinkIds order by CreatedDate desc];
       }
    
    @AuraEnabled
    public static Global_Merchant_Pricing_Change__c updateStatus(Id recordId){
        Global_Merchant_Pricing_Change__c gm = [Select Id, Status__c from Global_Merchant_Pricing_Change__c Where Id =: recordId];
        gm.Status__c = 'Pricing Change Completed';
        update gm;
        system.debug('gm'+gm);
        return gm;
    }
    
    @AuraEnabled
    public static List<Global_Merchant_Pricing_Change_Comments__c> getupdatedRecord(Id recordId){
        system.debug('Updated Comments recordId' +recordId);
        
        List<Global_Merchant_Pricing_Change_Comments__c> comLst = [select Id, Name, Comment__c, CreatedDate
                from Global_Merchant_Pricing_Change_Comments__c
                where Parent_Record_Number__c =:recordId
                order by CreatedDate desc];
            system.debug('comments List' + comLst);
 return comLst; 
    }
    
     @AuraEnabled
    public static List<ContentVersion>  getupdatedGmpcAttachements(Id gmId){
        List<ContentDocument> lstCV = new List<ContentDocument>();
        Set<Id> setDLinkIds = new Set<Id>();
        for(ContentDocumentLink dlink : [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId =: gmId]){
            setDLinkIds.add(dlink.ContentDocumentId);
        }
        
        List<ContentVersion> lst = [select Id, Title, PathOnClient, CreatedDate,ContentDocumentId FROM ContentVersion where  ContentDocumentId in : setDLinkIds order by CreatedDate desc];
        system.debug('lst:::'+lst);
        return lst;
       }

}