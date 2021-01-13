/**
 * Created by nross5 on 10/9/18.
 */

public  class CaptchaLightningController {
    @AuraEnabled(cacheable = true)
    public static Captcha initializeCaptcha() {
        return new Captcha();
    }

    /* [RN] to replace attachments with Files */
    public static Map<String,String> getContentURL(List<ContentVersion> lstCV) {
        Set<Id> setCVIds = new Set<Id>();
        for(ContentVersion cv : lstCV){
            setCVIds.add(cv.id);
        }
        CaptchaAuthenticationHandler captcha = new CaptchaAuthenticationHandler();
        return captcha.getPublicDownloadUrl(setCVIds);
    }

    public static List<ContentVersion> getCaptcha() {
        CaptchaAuthenticationHandler captcha = new CaptchaAuthenticationHandler();
        captcha.getCaptchaList();
        system.debug('!!! captcha :' + captcha);
        return captcha.finalAttList;
    }

    public class Captcha {
        @AuraEnabled
        public List<ContentVersion> contentVersions {get;set;}
        @AuraEnabled
        public Map<String,String> contentURL {get;set;}
        public Captcha() {
            this.contentVersions = getCaptcha();
            this.contentURL = getContentURL(this.contentVersions);
        }
    }
}