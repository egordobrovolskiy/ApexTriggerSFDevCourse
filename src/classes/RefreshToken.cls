/**
 * Created by Yehor Dobrovolskyi on 17.10.2018.
 */

public with sharing class RefreshToken {

    public String getToken(String code) {
        OAuth2__c oAuth = OAuth2__c.getValues('Web Flow');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(oAuth.End_Point__c);
        request.setMethod('POST');
        request.setBody('grant_type=authorization_code'
                + '&code=' + code
                + '&client_id=' + oAuth.Client_Id__c
                + '&client_secret=' + oAuth.Client_Secret__c
                + '&redirect_uri=' + oAuth.RedirectUri__c);
        System.debug(request.getBody());
        HttpResponse response = http.send(request);
        System.debug(response.getBody());

        Map<String, Object> parse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
        String refreshToken = (String) parse.get('refresh_token');
        return refreshToken;
    }
}