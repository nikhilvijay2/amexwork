/**
 * Created by srain6 on 2/19/20.
 */

public with sharing class CSUSyncServiceDefault implements CSUSyncService {
	public Action_Logs__c generateActionLogs(String actionName) {
		return new Action_Logs__c(Name = actionName, OwnerId = UserInfo.getUserId(),
				Origin__c = actionName, Status__c = 'SUCCESS',
				RecordTypeId = Schema.SObjectType.Action_Logs__c.getRecordTypeInfosByDeveloperName().get('Action_Logs').getRecordTypeId());
	}

	public Attachment generateActionLogAttachment(Action_Logs__c actionLog, Map<String, List<String>> errorMap) {
		List<String> rows = new List<String>();
		for(String key : errorMap.keySet()) {
			List<String> errorList = errorMap.get(key);
			rows.add(key + ',' + String.join(errorList, ','));
		}
		return new Attachment(Name = actionLog.Name + '.csv', Body = Blob.valueOf(String.join(rows, '\n')),
				ContentType = 'application/vnd.ms-excel', ParentId = actionLog.Id);
	}

	public List<String> generateDatabaseErrorAsStringList(List<Database.Error> errorList) {
		List<String> errors = new List<String>();
		for(Database.Error error : errorList) {
			errors.add(String.join(error.getFields(), ';') + ',' + error.getMessage());
		}
		return errors;
	}
}