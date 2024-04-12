package login.beans;

/** login 테이블 구조에 맞춘 Java Beans 생성 */
public class login {
	private String id;
	private String password;
	
	public login(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "login [id=" + id + ", password=" + password + "]";
	}
}
