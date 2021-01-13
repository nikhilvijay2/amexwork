/**
 * Created by nross5 on 11/13/18.
 */

@IsTest
private class CaptchaLightningControllerTest {
	@isTest
	private static void validateCaptchaController() {
		Captcha__c cap = new Captcha__c(Name = 'ImageAttach');
		insert cap;

		List<Attachment> attachments = new List<Attachment>();
		CaptchaAuthenticationHandler cah = new CaptchaAuthenticationHandler();

		List<String> chars = new List<String>();
		chars.add('A');
		chars.add('B');
		chars.add('C');
		chars.add('D');
		chars.add('E');
		chars.add('F');
		chars.add('G');
		chars.add('H');
		chars.add('I');
		chars.add('J');
		chars.add('K');
		chars.add('L');
		chars.add('M');
		chars.add('N');
		chars.add('O');
		chars.add('P');
		chars.add('Q');
		chars.add('R');
		chars.add('S');
		chars.add('T');
		chars.add('U');
		chars.add('V');
		chars.add('W');
		chars.add('X');
		chars.add('Y');
		chars.add('Z');
		chars.add('X1a');
		chars.add('X1b');
		chars.add('X1c');
		chars.add('X1d');
		chars.add('X1e');
		chars.add('X1f');
		chars.add('X1g');
		chars.add('X1h');
		chars.add('X1i');
		chars.add('X1j');
		chars.add('X1k');
		chars.add('X1l');
		chars.add('X1m');
		chars.add('X1n');
		chars.add('X1o');
		chars.add('X1p');
		chars.add('X1q');
		chars.add('X1r');
		chars.add('X1s');
		chars.add('X1t');
		chars.add('X1u');
		chars.add('X1v');
		chars.add('X1w');
		chars.add('X1x');
		chars.add('X1y');
		chars.add('X1z');
		chars.add('X11');
		chars.add('X12');
		chars.add('X13');
		chars.add('X14');
		chars.add('X15');
		chars.add('X16');
		chars.add('X17');
		chars.add('X18');
		chars.add('X19');
		chars.add('X10');

		for(String str : chars) {
			Attachment att = new Attachment();
			att.Body = Blob.valueOf('');
			att.Name = str + '.jpg';
			att.ContentType = 'image/jpeg';
			att.ParentId = cap.Id;
			attachments.add(att);
		}
		insert attachments;

		CaptchaLightningController.Captcha captcha = CaptchaLightningController.initializeCaptcha();
		System.assertEquals((Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=').replace('my.salesforce','content.force'),
				captcha.contentURL, 'Captcha contentURL incorrect.');
		System.assertEquals(6, captcha.attachments.size(), 'Images incorrectly populated.');
	}
}