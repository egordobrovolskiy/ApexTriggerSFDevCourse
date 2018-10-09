/**
 * Created by Yehor Dobrovolskyi on 05.10.2018.
 */

public with sharing class RemotelyCreateAccount {
    private static final String END_POINT = 'https://cunning-bear-99wudk-dev-ed.my.salesforce.com/services/apexrest/Account/' ;

    static AccessTokenOAuthUP accessTokenOAuth = new AccessTokenOAuthUP.Builder()
            .endPoint('https://login.salesforce.com/services/oauth2/token')
            .username('egordobrovolskiy@cunning-bear-99wudk.com')
            .password('qwer1234')
            .clientId('3MVG9fTLmJ60pJ5I19dJ4NlkP682B_2R2_22C.cTaJS59djW42pG3icH2KB1bGakreFHZ.P2dpq_mH3NDrTce')
            .clientSecret('8841339545979335288')
            .grantType('password')
            .build();

    public static HttpResponse createAccount(String nameAccount) {

        String accessToken = accessTokenOAuth.getAccessToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(END_POINT + 'create');
        request.setMethod('POST');
        request.setBody('{"Name":"' + nameAccount + '"}');

        HttpResponse response = http.send(request);

        System.debug('Body response: ' + response.getBody());
        System.debug('Response status: ' + response.getStatus());
        System.debug('Response code : ' + response.getStatusCode());

        return response;
    }

    public static HttpResponse getAnyAccount() {
        String accessToken = accessTokenOAuth.getAccessToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(END_POINT);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('Response : ' + response);
        System.debug('Response body : ' + response.getBody());
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            for (String acc : results.keySet()) {
                System.debug(acc + ' = ' + results.get(acc));
            }
            return response;
        } else {
            return null;
        }
    }
}