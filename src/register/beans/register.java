package register.beans;

/** register ���̺� ������ ���� Java Beans ���� */
public class register {
	private String id;		// ���̵�
	private String password;	// ��й�ȣ
	private String name;		// �̸� 
	private String age;		// ���� 
	private String email;		// �̸��� 
	
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
