/**
 * Created by dobro on 07.10.2018.007.
 */

public with sharing class OAuthWebFlow {
    private static final String END_POINT = web_flou_token__c.getOrgDefaults().end_point__c;

    private static Integer numberOfAttempts = 0;


    public static String createAccount(String nameAccount) {
        String accessToken = web_flou_token__c.getOrgDefaults().access_token__c;

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
            return null;
        }
    }


    public static HttpResponse getAnyAccount() {
        String accessToken = web_flou_token__c.getOrgDefaults().access_token__c;

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