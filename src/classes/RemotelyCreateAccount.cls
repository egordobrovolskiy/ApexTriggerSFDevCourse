/**
 * Created by Yehor Dobrovolskyi on 05.10.2018.
 */

public with sharing class RemotelyCreateAccount {
    private static final String END_POINT = 'https://cunning-bear-99wudk-dev-ed.my.salesforce.com/services/apexrest/Account/' ;

    public static String createAccount(String nameAccount) {
        String accessToken = AccessTokenOAuthUP.getInstance().getAccessToken();

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

        return response.getBody();
    }

    public static Map<String, Object> getAnyAccount() {
        String accessToken = AccessTokenOAuthUP.getInstance().getAccessToken();

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
            return results;
        } else {
            return null;
        }
    }
}