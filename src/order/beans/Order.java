package order.beans;

public class Order {
	private String shopping_userId;		// ����� ���̵� 
	private String shopping_productId;		// ��ǰ��
	private String shopping_name;		// ����
	private String shopping_date;		// �����
	private String shopping_country;	// ��۱���
	private String shopping_zipCode;	// �����ȣ
	private String shopping_addressName;	// �����
	private String shopping_num;		// �ֹ���ȣ
	
	public String getShopping_userId() {
		return shopping_userId;
	}
	
	public void setShopping_userId(String shopping_userId) {
		this.shopping_userId = shopping_userId;
	}
	
	public String getShopping_productId() {
		return shopping_productId;
	}
	
	public void setShopping_productId(String shopping_productId) {
		this.shopping_productId = shopping_productId;
	}
	
	public String getShopping_name() {
		return shopping_name;
	}
	
	public void setShopping_name(String shopping_name) {
		this.shopping_name = shopping_name;
	}
	
	public String getShopping_date() {
		return shopping_date;
	}
	
	public void setShopping_date(String shopping_date) {
		this.shopping_date = shopping_date;
	}
	
	public String getShopping_country() {
		return shopping_country;
	}
	
	public void setShopping_country(String shopping_country) {
		this.shopping_country = shopping_country;
	}
	
	public String getShopping_zipCode() {
		return shopping_zipCode;
	}
	
	public void setShopping_zipCode(String shopping_zipCode) {
		this.shopping_zipCode = shopping_zipCode;
	}
	
	public String getShopping_addressName() {
		return shopping_addressName;
	}
	
	public void setShopping_addressName(String shopping_addressName) {
		this.shopping_addressName = shopping_addressName;
	}
	
	public String getShopping_num() {
		return shopping_num;
	}
	
	public void setShopping_num(String shopping_num) {
		this.shopping_num = shopping_num;
	}

	@Override
	public String toString() {
		return "Order [shopping_userId=" + shopping_userId + ", shopping_productId=" + shopping_productId
				+ ", shopping_name=" + shopping_name + ", shopping_date=" + shopping_date + ", shopping_country="
				+ shopping_country + ", shopping_zipCode=" + shopping_zipCode + ", shopping_addressName="
				+ shopping_addressName + ", shopping_num=" + shopping_num + "]";
	}
}
