/**
 * Created by Yehor Dobrovolskyi on 16.10.2018.
 */

public with sharing class RestBuilderAccessToken implements Token{

    private String body;
    private String endPoint;
    private String contentType;
    private String method;

    private RestBuilderAccessToken(Builder builder) {
        this.body = builder.body;
        this.endPoint = builder.endPoint;
        this.contentType = builder.contentType;
        this.method = builder.method;
    }

    public String getToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod(method);
        if (!String.isEmpty(contentType)) {
            request.setHeader('Content-Type', contentType);
        }
        request.setBody(body);
        System.debug(request.getBody());
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        Map<String, Object> parse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
        String accessToken = (String) parse.get('access_token');

        return accessToken;
    }


    public class Builder {
        private String body;
        private String redirectUri;
        private String endPoint;
        private String contentType;
        private String method;

        public Builder() {}

        public Builder setEndPoint(String endPoint) {
            this.endPoint = endPoint;
            return this;
        }

        public Builder setContentType(String contentType) {
            this.contentType = contentType;
            return this;
        }

        public Builder setMethod(String method) {
            this.method = method;
            return this;
        }

        public Builder setGrantType(String grantType) {
            this.body = 'grant_type=' + grantType;
            return this;
        }

        public Builder setCode(String code) {
            this.body += '&code=' + code;
            return this;
        }

        public Builder setClientId(String clientId) {
            this.body += '&client_id=' + clientId;
            return this;
        }

        public Builder setClientSecret(String clientSecret) {
            this.body += '&client_secret=' + clientSecret;
            return this;
        }

        public Builder setRedirectUri(String redirectUri) {
            this.body += '&redirect_uri=' + redirectUri;
            return this;
        }

        public Builder setUserName(String userName) {
            this.body += '&username=' + userName;
            return this;
        }

        public Builder setPassword(String password) {
            this.body += '&password=' + password;
            return this;
        }

        public Builder setRefreshToken(String refreshToken) {
            this.body += '&refresh_token=' + refreshToken;
            return this;
        }

        public RestBuilderAccessToken build() {
            return new RestBuilderAccessToken(this);
        }
    }


}