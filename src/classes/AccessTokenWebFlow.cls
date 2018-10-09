/**
 * Created by Yehor Dobrovolskyi on 09.10.2018.
 */

public with sharing class AccessTokenWebFlow {
    private static AccessTokenWebFlow instance;

    private  String accessToken;
    private  String refreshToken;

    private WebFlou__mdt webFlouCMT;

   private AccessTokenWebFlow() {
       this.webFlouCMT = [SELECT
               Client_Secret__c,
               Client_Id__c,
               RedirectUri__c
       FROM WebFlou__mdt
       WHERE Label = 'WebFlouToken'];
   }

    public static AccessTokenWebFlow getInstance() {
        if (instance == null) {
            instance = new AccessTokenWebFlow();
        }
        return instance;
    }

    public String getAccessToken(){
        return accessToken;
    }

    public void getToken(String authToken) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=authorization_code'
                + '&code=' + authToken
                + '&client_id=' + webFlouCMT.Client_Id__c
                + '&client_secret=' + webFlouCMT.Client_Secret__c
                + '&redirect_uri=' + webFlouCMT.RedirectUri__c);
        System.debug(request.getBody());
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        parseJson(response);

        refreshToken();

        System.debug(OAuthWebFlow.createAccount('Create from Web Site Refresh3'));

    }

    public void refreshToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=refresh_token'
                + '&client_id=' + webFlouCMT.Client_Id__c
                + '&client_secret=' + webFlouCMT.Client_Secret__c
                + '&refresh_token=' + refreshToken);
        HttpResponse response = http.send(request);
        parseJson(response);
        web_flou_token__c wft = web_flou_token__c.getOrgDefaults();
        wft.access_token__c = accessToken;
//        update wft;
    }

    private void parseJson(HttpResponse response) {
        Map<String, Object> parse =(Map<String, Object>) Json.deserializeUntyped(response.getBody());
        accessToken = (String) parse.get('access_token');
        refreshToken = (String) parse.get('refresh_token');
    }
}