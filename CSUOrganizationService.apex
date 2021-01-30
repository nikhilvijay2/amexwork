/**
 * Created by ndingari on 2/13/20.
 */

public with sharing class CSUOrganizationService {
	public Map<String, OrganizationServiceModel.Organization> csuOrganizationMap;

	public CSUOrganizationService() {
		csuOrganizationMap = new Map<String, OrganizationServiceModel.Organization>();
	}

	public Map<String, OrganizationServiceModel.Organization> getAllCSUOrganizations() {
		HttpResponse httpResponse = new CSUServiceDefault().getCSUOrganizations();
		List<OrganizationServiceModel.Organization> response =
				(List<OrganizationServiceModel.Organization>)System.JSON.deserialize(httpResponse.getBody(), List<OrganizationServiceModel.Organization>.class);
		if(httpResponse.getStatusCode()/100 == 2) {
			for(OrganizationServiceModel.Organization org : response) {
				this.csuOrganizationMap.put(org.organization_identifier, org);
			}
		}
		return this.csuOrganizationMap;
	}

	public List<Account> csuAccountMapping(List<Account> accounts) {
		List<Account> accList = new List<Account>();
		if(!csuOrganizationMap.isEmpty()) {
			OrganizationServiceModel.Organization orgResponse;
			for(Account acc : accounts) {
				if(csuOrganizationMap.containsKey(String.valueOf(acc.OrgID1__c.intValue()))) {
					orgResponse = this.csuOrganizationMap.get(String.valueOf(acc.OrgID1__c.intValue()));
					acc.Name = orgResponse.organization_name.organization_legal_name;
					acc.CodeName__c = orgResponse.organization_name.organization_doing_business_as_name;
					acc.Dispute_Setup_Type__c = orgResponse.dispute_setup_type_text;
					acc.Effective_Date__c = Date.valueOf(orgResponse.effective_date);
					acc.Deal_Construct__c = orgResponse.deal_construct_code;
					acc.PAN_Minimum_Length__c = orgResponse.pan_minimum_length_number;
					acc.PAN_Maximum_Length__c = orgResponse.pan_maximum_length_number;
					acc.Synced_with_CSU__c = true;
					acc.CSU_status__c='Approved';
					accList.add(acc);
				}
			}
		}
		return accList;
	}

	public void removeMatchedOrgs(List<Account> accounts) {
		for(Account acc : accounts) {
			String accId = String.valueOf(acc.OrgID1__c.intValue());
			if(this.csuOrganizationMap.containsKey(accId)) {
				this.csuOrganizationMap.remove(accId);
			}
		}
	}

}