package register.beans;

/** register 테이블 구조에 맞춘 Java Beans 생성 */
public class register {
	private String id;		// 아이디
	private String password;	// 비밀번호
	private String name;		// 이름 
	private String age;		// 나이 
	private String email;		// 이메일 
	
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
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAge() {
		return age;
	}
	
	public void setAge(String age) {
		this.age = age;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	@Override
	public String toString() {
		return "register [id=" + id + ", password=" + password + ", name=" + name + ", age=" + age + ", email=" + email
				+ "]";
	}
}
