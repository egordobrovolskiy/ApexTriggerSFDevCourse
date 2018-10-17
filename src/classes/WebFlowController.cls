/**
 * Created by Yehor Dobrovolskyi on 09.10.2018.
 */

public without sharing class WebFlowController {

    private static String refreshToken = '';

    public void doCallout() {
        String code = ApexPages.currentPage().getParameters().get('code');
        if (!String.isEmpty(code)) {
            refreshToken = new RefreshToken().getToken(code);
        }
    }

    public String getRefreshToken() {
        return refreshToken;
    }

}