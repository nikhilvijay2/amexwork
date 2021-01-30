/**
 * Created by avemp on 2/13/2020.
 */

@IsTest
class CSUOrganizationSyncBatchTest {
	@TestSetup
	static void setup() {
		Account failureAccount = CSUTestDataFactory.createSingleAccount(Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner').getRecordTypeId());
		failureAccount.Synced_with_CSU__c = false;
		failureAccount.OrgID1__c = 100;
		insert failureAccount;
		Account successAccount = CSUTestDataFactory.createSingleAccount(Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner').getRecordTypeId());
		successAccount.Synced_with_CSU__c = false;
		successAccount.OrgID1__c = 10;
		insert successAccount;
	}

	@IsTest
	static void testOrgSyncForSuccess() {
		Test.setMock(HttpCalloutMock.class, CSUTestDataFactory.createCalloutMockResponse('CSUOrganizationGetAllResponse', 200, 'OK'));
		Test.startTest();
		CSUOrganizationSyncBatch job = new CSUOrganizationSyncBatch('GetOrganization', '');
		Database.executeBatch(job);
		Test.stopTest();
		List<Account> syncedAccount = [
				SELECT Id,
						Name,
						OrgID1__c,
						Synced_with_CSU__c
				FROM Account
				where OrgID1__c = 10
		];
		for(Account account : syncedAccount) {
			System.assertEquals(true, account.Synced_with_CSU__c);
		}
	}

	@IsTest
	static void testOrgSyncForFailure() {
		Test.setMock(HttpCalloutMock.class, CSUTestDataFactory.createCalloutMockResponse('CSUOrganizationGetAllFailureResponse', 200, 'OK'));
		Test.startTest();
		CSUOrganizationSyncBatch job = new CSUOrganizationSyncBatch('GetOrganization', '');
		Database.executeBatch(job);
		Test.stopTest();
		Account syncedAccount = [
				SELECT Id,
						Name,
						OrgID1__c,
						Synced_with_CSU__c
				FROM Account
				where OrgID1__c = 100
		];
		System.assertEquals(false, syncedAccount.Synced_with_CSU__c);
	}
}