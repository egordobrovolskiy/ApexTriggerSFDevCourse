/**
 * Created by Yehor Dobrovolskyi on 08.10.2018.
 */

public with sharing class AccessTokenOAuthWebFlow {

    private static AccessTokenOAuthWebFlow instance;

    private String authToken = 'aPrxYkXCmZcIH2y1_jK0v_KgPZ_RYw7xuEcXt8jxZCMnNUDjrvos.edrX3JezlEbO.AOSrNVhQ==';
    private String client_id = '3MVG9fTLmJ60pJ5I19dJ4NlkP67SDTMsZdbhit0RUKEgIH7NYeFdJCv9yVEs1NU_evf6hKibOQA==';
    private String client_secret = '9006521462906902298';
    private String redirect_uri = 'https://web-flow-oauth-developer-edition.eu16.force.com/webflow';

    private String accessToken;
    private String refreshToken;

    private AccessTokenOAuthWebFlow() {
    }

    public static AccessTokenOAuthWebFlow getInstance() {
        if (instance == null) {
            instance = new AccessTokenOAuthWebFlow();
        }
        return instance;
    }

    public String getAccessToken() {
        if (String.isEmpty(accessToken)) {
            getToken();
        }
        return accessToken;
    }

    private void getToken() {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=authorization_code'
                + '&code=' + authToken
                + '&client_id=' + client_id
                + '&client_secret=' + client_secret
                + '&redirect_uri=' + redirect_uri);
        System.debug(request.getBody());
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        parseJson(response);

    }

    public void refreshToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody('grant_type=refresh_token'
                + '&client_id=' + client_id
                + '&client_secret=' + client_secret
                + '&refresh_token=' + refreshToken);
        HttpResponse response = http.send(request);
        parseJson(response);
    }

    private void parseJson(HttpResponse response) {
        JSONParser parser = JSON.createParser(response.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                String fieldName = parser.getText();
                parser.nextToken();
                System.debug('fieldName = ' + fieldName);
                if (fieldName == 'access_token') {
                    accessToken = parser.getText();
                }
                if (fieldName == 'refresh_token') {
                    refreshToken = parser.getText();
                }
            }
        }
    }
}