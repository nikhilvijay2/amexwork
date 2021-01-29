public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountList() {
        return [SELECT Id, Name,
                Phone
        FROM Contact];
    }
}