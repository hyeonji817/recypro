/** ������ ������ �ּ���ǥ : https://hsp0418.tistory.com/17 */
package user.beans;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/** Gmail Ŭ���� : SMTP�� �̿��� �̸��� ���� �޼��� ���� ���� Ŭ���� */

public class Gmail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return new PasswordAuthentication("email", "password");
	}
}