/**
 * Created by ndingari on 2/12/20.
 */

global class CSUOrganizationSyncBatch implements Database.Batchable <SObject>, Database.Stateful, Database.AllowsCallouts {

	private final String CLASS_NAME = 'CSUOrganizationSyncBatch';
	private final Map<String, List<String>> errorMap = new Map<String, List<String>>();
	private final Callout__mdt getOrganizationMdt;
	private final CSUOrganizationService organizationService;
	private final CSUSyncService syncService;
	private final String filter;

	public CSUOrganizationSyncBatch(String calloutName, String filter) {
		this.filter = filter;
		this.organizationService = new CSUOrganizationService();
		this.syncService = (CSUSyncService)Injector.instantiate('CSUSyncServiceDefault');
		this.getOrganizationMdt = CalloutServices.fetchCallout(calloutName);
	}

	global Database.QueryLocator start(Database.BatchableContext batch) {
		organizationService.getAllCSUOrganizations();
		String conditions = ' OrgID1__c != NULL and Synced_with_CSU__c = false ' + filter;
		SObjectDomain sObjectDomain = (SObjectDomain)Injector.instantiate('SObjectDomainDefault');
		return Database.getQueryLocator(sObjectDomain.createSOQL(getOrganizationMdt.sObject__c, getOrganizationMdt.Query_Fields__c, conditions));
	}

	global void execute(Database.BatchableContext batch, List<Account> scope) {
		List<Account> accList = organizationService.csuAccountMapping(scope);
		if(!accList.isEmpty()) {
			List<Database.SaveResult> resultList = Database.update(accList, false);
			Integer index = 0;
			for(Database.SaveResult res : resultList) {
				if(!res.isSuccess()) {
					errorMap.put(accList[index].Id + ','+accList[index].orgid1__c + ','+accList[index].name, syncService.generateDatabaseErrorAsStringList(res.getErrors()));
				}
				index++;
			}
		}
	}

	global void finish(Database.BatchableContext bc) {
		try {
			if(!errorMap.isEmpty()) {
				Action_Logs__c actionLog = syncService.generateActionLogs(this.CLASS_NAME);
				actionLog.Status__c = 'FAILURE';
				insert actionLog;
				insert syncService.generateActionLogAttachment(actionLog, errorMap);
			}
		} catch(Exception e) {
			System.debug('Exception:' + e.getStackTraceString());
			TelemetryHandler.handleException(e, this.CLASS_NAME);
		}
	}
}