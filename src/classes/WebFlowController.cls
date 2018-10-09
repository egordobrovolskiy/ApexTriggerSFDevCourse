/**
 * Created by Yehor Dobrovolskyi on 09.10.2018.
 */

public class WebFlowController {

    public String getCode() {

        String code = ApexPages.currentPage().getParameters().get('code');

        if (!String.isEmpty(code)) {

            AccessTokenWebFlow.getInstance().getToken(code);

            return 'Code send : ' + code;
        } else {
            return 'Try again';
        }


    }

}