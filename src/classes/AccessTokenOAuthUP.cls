/**
 * Created by Yehor Dobrovolskyi on 08.10.2018.
 */

public with sharing class AccessTokenOAuthUP {


    private String endpoint = '';
    private String username = '';
    private String password = '';
    private String clientId = '';
    private String clientSecret = '';
    private String grantType = '';

    private String accessToken;

    private AccessTokenOAuthUP(Builder builder) {
        this.endpoint = builder.endpoint;
        this.username = builder.username;
        this.password = builder.password;
        this.clientId = builder.clientId;
        this.clientSecret = builder.clientSecret;
        this.grantType = builder.grantType;

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
        req.setBody('grant_type=' + grantType +
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
   public class Builder {
       private String endpoint = '';
       private String username = '';
       private String password = '';
       private String clientId = '';
       private String clientSecret = '';
       private String grantType = 'password';
       public Builder() {}
       public Builder endPoint(String endpoint) {
           this.endpoint = endpoint;
           return this;
       }
       public Builder username(String username) {
           this.username = username;
           return this;
       }
       public Builder password(String password) {
           this.password = password;
           return this;
       }
       public Builder clientId(String clientId) {
           this.clientId = clientId;
           return this;
       }
       public Builder clientSecret(String clientSecret) {
           this.clientSecret = clientSecret;
           return this;
       }
       public Builder grantType(String grantType){
           this.grantType = grantType;
           return this;
       }
       public AccessTokenOAuthUP build(){
           return new AccessTokenOAuthUP(this);
       }

   }
}