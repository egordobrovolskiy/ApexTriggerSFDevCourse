/**
 * Created by Yehor Dobrovolskyi on 16.10.2018.
 */

public with sharing class TokenFabric {

   public static String getToken() {
      String accessToken;

       OAuth2__c oAuth = [
               SELECT
                       Name,
                       Client_Id__c,
                       Client_Secret__c,
                       End_Point__c,
                       RedirectUri__c,
                       Username__c,
                       Password__c
               FROM OAuth2__c
               WHERE isPrimary__c = true
       ][0];
       switch on oAuth.Name {
           when 'Web Flow' {
               System.debug('Web Flow');
               String refreshToken = [SELECT token__c FROM Refresh_Token__mdt][0].token__c;
               System.debug(refreshToken);
               Token token = new RestBuilderAccessToken.Builder()
                       .setEndPoint(oAuth.End_Point__c)
                       .setMethod('POST')
                       .setGrantType('refresh_token')
                       .setClientId(oAuth.Client_Id__c)
                       .setClientSecret(oAuth.Client_Secret__c)
                       .setRefreshToken(refreshToken)
                       .build();
               accessToken = token.getToken();
           }
           when 'Username Password' {
               System.debug('Username Password');
               Token token = new RestBuilderAccessToken.Builder()
                       .setEndPoint(oAuth.End_Point__c)
                       .setMethod('POST')
                       .setContentType('application/x-www-form-urlencoded')
                       .setGrantType('password')
                       .setClientId(oAuth.Client_Id__c)
                       .setClientSecret(oAuth.Client_Secret__c)
                       .setUserName(oAuth.Username__c)
                       .setPassword(oAuth.Password__c)
                       .build();
               accessToken = token.getToken();
           }
       }

       return accessToken;
   }
}