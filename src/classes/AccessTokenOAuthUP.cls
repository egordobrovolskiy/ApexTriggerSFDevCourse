/**
 * Created by Yehor Dobrovolskyi on 08.10.2018.
 */

public with sharing class AccessTokenOAuthUP {

    private OAuth__mdt usernamePasswordCMT;
    
    public AccessTokenOAuthUP() {
        this.usernamePasswordCMT = [
                SELECT
                        Client_Id__c,
                        Client_Secret__c,
                        Username__c,
                        Password__c
                FROM OAuth__mdt
                WHERE MasterLabel = 'Username Password'
        ][0];
    }


    public void getToken() {
        Http http = new Http();
        Httprequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('grant_type=password'
                + '&client_id=' + usernamePasswordCMT.Client_Id__c
                + '&client_secret=' + usernamePasswordCMT.Client_Secret__c
                + '&username=' + usernamePasswordCMT.Username__c
                + '&password=' + usernamePasswordCMT.Password__c
        );
        HttpResponse response = http.send(request);
        system.debug('body:' + response.getBody());

        Map<String, Object> parse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
        String accessToken = (String) parse.get('access_token');

        access_token__c accessTokenSettings = access_token__c.getOrgDefaults();
        accessTokenSettings.Token__c = accessToken;
        update accessTokenSettings;
    }

}