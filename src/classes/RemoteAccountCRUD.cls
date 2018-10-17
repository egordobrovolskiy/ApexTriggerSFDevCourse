/**
 * Created by Yehor Dobrovolskyi on 16.10.2018.
 */

public with sharing class RemoteAccountCRUD {

    private static final String END_POINT = 'https://cunning-bear-99wudk-dev-ed.my.salesforce.com/services/apexrest/Account/';


    public static String createAccount(Account account) {
        String jsonAccount = JSON.serialize(account);
        System.debug(jsonAccount);
        String accessToken = TokenFabric.getToken();
        System.debug('Access Toke: ' + accessToken);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(END_POINT + 'create');
        request.setMethod('POST');
        request.setBody(jsonAccount);

        HttpResponse response = http.send(request);

        System.debug('Body response: ' + response.getBody());
        System.debug('Response status: ' + response.getStatus());
        System.debug('Response code : ' + response.getStatusCode());

        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            return null;
        }
    }


    public static HttpResponse getAnyAccount() {
        String accessToken = TokenFabric.getToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(END_POINT);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
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