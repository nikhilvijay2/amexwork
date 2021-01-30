/**
 * Created by renuka.n01 on 9/1/2020.
 */

public with sharing class NPAZCallout {
    static final String BLAZE_ENDPOINT = System.label.BlazeEndpoint;
    
    public static Map<String, String> generateReqHeader(String routingPath) {
		Map<String, String> reqHeaderMap = new Map<String, String>();
		reqHeaderMap.put('RoutingPath', routingPath);
		return reqHeaderMap;
	}

    public static HttpResponse makeCallout(String method, Map<String,String> reqHeaders, String payload) {
        System.debug('NPAZ Payload:' + payload);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BLAZE_ENDPOINT);
        req.setMethod(method);
        req.setClientCertificateName('GNS_Web_connection');
        createRequestHeaders(req, reqHeaders);
        req.setHeader('Content-Type', 'application/json');
        if('POST'.equalsIgnoreCase(req.getMethod()) || 'PUT'.equalsIgnoreCase(req.getMethod())) {
            req.setBody(payload);
        }
        req = ApigeeUtility.generateHeaders(req, 'Blaze');
        system.debug('!!! req : '+ req);
        HttpResponse res = new Http().send(req);
        system.debug('!!! res : '+ res);
        return res;
    }
    public static void createRequestHeaders(HttpRequest req, Map<String,String> reqHeaders){
        for(String key: reqHeaders.keySet()){
            req.setHeader(key,reqHeaders.get(key));
        }
    }
    public static HttpResponse AccountSyncUpCallout(NPAZModel.AccountRequestData accRequest){
        String payload = JSON.serialize(accRequest);
        Callout__mdt mdt = CalloutServices.fetchCallout('NPAZOrg');
        system.debug('!!! mdt :'+ mdt);
        Map<String, String> headers = NPAZCallout.generateReqHeader(mdt.Routing_Path__c);
        system.debug('!!! headers :'+ headers);
        HttpResponse response = makeCallout('POST', headers, payload);
        system.debug('!!! response :'+ response);
        return response;
    }
    /*public static NPAZModel.AccountResponseData captureAccountSyncResponse(HttpResponse response, Id accountId, String operationType) {
        NPAZModel.AccountResponseData accountRes = (NPAZModel.AccountResponseData)JSON.deserialize(response.getBody(), NPAZModel.AccountResponseData.class);
        system.debug('!!! accountRes : '+ accountRes);
        if('A'.Equals(operationType)){
            Account oAccount = new Account(Id = accountId, GNSwebID__c = String.valueOf(accountRes.orgId));
            update oAccount;
        }
        return accountRes;
    }*/
    public static HttpResponse contactSyncUpCallout(NPAZModel.ContactCreateData bean) {
		String serializedBean = JSON.serialize(bean);
        Map<String, Object> beanMap = (Map<String, Object>)JSON.deserializeUntyped(serializedBean);
        String payload = JSON.serialize(beanMap);
        Callout__mdt mdt = CalloutServices.fetchCallout('NPAZUser');
        system.debug('!!! mdt :'+ mdt);
        Map<String, String> headers = NPAZCallout.generateReqHeader(mdt.Routing_Path__c);
        system.debug('!!! headers :'+ headers);
        HttpResponse res = makeCallout('POST', headers,payload);
        system.debug('res' +res.getStatusCode() + res.getBody());
        return res;
	}
    
}