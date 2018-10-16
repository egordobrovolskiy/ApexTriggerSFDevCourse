/**
 * Created by Yehor Dobrovolskyi on 09.10.2018.
 */

public without sharing class WebFlowController {

    private static Boolean isCode = false;
    public void doCallout() {
        String code = ApexPages.currentPage().getParameters().get('code');
        if (!String.isEmpty(code)) {
           new AccessTokenWebFlow().getToken(code);
            isCode = true;
        }
    }

    public String getIsCode() {
        return String.valueOf(isCode);
    }

}