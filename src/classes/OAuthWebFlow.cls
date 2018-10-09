/**
 * Created by dobro on 07.10.2018.007.
 */

public with sharing class OAuthWebFlow {
    private static final String END_POINT = 'https://cunning-bear-99wudk-dev-ed.my.salesforce.com/services/apexrest/Account/' ;

    private static Integer numberOfAttempts = 0;


    public static String createAccount(String nameAccount) {
        String accessToken = AccessTokenWebFlow.getInstance().getAccessToken();


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

        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            if (numberOfAttempts < 2) {
                AccessTokenWebFlow.getInstance().refreshToken();
                numberOfAttempts++;
                return createAccount(nameAccount);
            } else {
                return null;
            }
        }
    }

    public static Map<String, Object> getAnyAccount() {
        String accessToken = AccessTokenWebFlow.getInstance().getAccessToken();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(END_POINT);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            for (String acc : results.keySet()) {
                System.debug(acc + ' = ' + results.get(acc));
            }
            return results;
        } else {
            if (numberOfAttempts < 2) {
                AccessTokenWebFlow.getInstance().refreshToken();
                numberOfAttempts++;
                return getAnyAccount();
            } else {
                return null;
            }
        }
    }
}