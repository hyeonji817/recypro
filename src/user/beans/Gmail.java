/** 참고한 페이지 주소좌표 : https://hsp0418.tistory.com/17 */
package user.beans;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/** Gmail 클래스 : SMTP를 이용해 이메일 인증 메세지 전송 관련 클래스 */

public class Gmail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return new PasswordAuthentication("email", "password");
	}
}