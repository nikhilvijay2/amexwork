trigger AccountDeletion on Account (before delete) {
    
    for(Account a : [Select Id, Name from Account Where Id IN (select AccountId From opportunity) AND ID IN: Trigger.old]){
        Trigger.oldMap.get(a.Id).addError('Account with related opportunity cant be deleted');
    }

}