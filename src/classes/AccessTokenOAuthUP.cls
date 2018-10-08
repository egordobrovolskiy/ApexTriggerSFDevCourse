/**
 * Created by Yehor Dobrovolskyi on 08.10.2018.
 */

public with sharing class AccessTokenOAuthUP {

    private static AccessTokenOAuthUP instance;

    private String endpoint = 'https://login.salesforce.com/services/oauth2/token';
    private String username = 'egordobrovolskiy@cunning-bear-99wudk.com';
    private String password = 'qwer1234';
    private String clientId = '3MVG9fTLmJ60pJ5I19dJ4NlkP682B_2R2_22C.cTaJS59djW42pG3icH2KB1bGakreFHZ.P2dpq_mH3NDrTce';
    private String clientSecret = '8841339545979335288';

    private String accessToken;

    private AccessTokenOAuthUP() {}

    public static AccessTokenOAuthUP getInstance() {
        if (instance == null) {
            instance = new AccessTokenOAuthUP();
        }
        return instance;
    }

    public String getAccessToken() {
        if (String.isEmpty(accessToken)) {
            getSessionId();
        }
        return accessToken;
    }

    private void getSessionId() {
        Httprequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody('grant_type=password' +
                '&client_id=' + clientId +
                '&client_secret=' + clientSecret +
                '&username=' + username +
                '&password=' + password
        );
        req.setEndpoint(endpoint);
        Http http = new Http();
        HttpResponse res = http.send(req);
        system.debug('body:' + res.getBody());
        parseJson(res);

    }
    private void parseJson(HttpResponse res) {
        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                String fieldName = parser.getText();
                parser.nextToken();
                System.debug('fieldName = ' + fieldName);
                if (fieldName == 'access_token') {
                    accessToken = parser.getText();
                }
            }
        }
    }
}