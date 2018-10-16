/**
 * Created by Yehor Dobrovolskyi on 09.10.2018.
 */

public without sharing class AccessTokenWebFlow {

    private OAuth__mdt webFlowCMT;

    public AccessTokenWebFlow() {
        this.webFlowCMT = [
                SELECT
                Client_Id__c,
                Client_Secret__c,
                RedirectUri__c
                FROM OAuth__mdt
                WHERE MasterLabel = 'Web flow'
        ][0];
    }

    public void getToken(String authToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=authorization_code'
                + '&code=' + authToken
                + '&client_id=' + webFlowCMT.Client_Id__c
                + '&client_secret=' + webFlowCMT.Client_Secret__c
                + '&redirect_uri=' + webFlowCMT.RedirectUri__c);
        System.debug(request.getBody());
        HttpResponse response = http.send(request);
        System.debug(response.getBody());

        Map<String, Object> parse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
        String accessToken = (String) parse.get('access_token');
        String refreshToken = (String) parse.get('refresh_token');

        refreshToken(refreshToken);

    }

    private void refreshToken(String refreshToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=refresh_token'
                + '&client_id=' + webFlowCMT.Client_Id__c
                + '&client_secret=' + webFlowCMT.Client_Secret__c
                + '&refresh_token=' + refreshToken);
        HttpResponse response = http.send(request);

        Map<String, Object> parse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
        String accessToken = (String) parse.get('access_token');

        access_token__c accessTokenSettings = access_token__c.getOrgDefaults();
        accessTokenSettings.Token__c = accessToken;
        update accessTokenSettings;
    }

}