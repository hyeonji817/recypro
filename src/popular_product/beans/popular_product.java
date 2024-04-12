package popular_product.beans;

import java.io.Serializable;

/**
 * �ڹ� ��(bean)�� �̿��� ���� ��ȸ
 * 1. �ڹ� ��
 * 1) JAVA EE ���α׷��� ��, ���� ��ü�� ��ġ�鼭 ��������� �����͸� �����ϰų� �����ϴ� �� ���Ǵ� Ŭ���� 
 * 2) �ڹ��� DTO(Data Transfer Object, ������ ���� ��ü) Ŭ����, VO(Value Object, �� ��ü) Ŭ������ 
 * ���� ���� 
 * 
 * 2. �ڹ� �� Ư¡ 
 * 1) �Ӽ��� ���� �����ڴ� private�̴�. 
 * 2) �� �Ӽ� (attribute, property)�� ������ setter/getter�� ������. (publicȭ�Ͽ� �� ���� �� �� �ְ� ����) 
 * 3) ���� ���� �����ڸ� �ݵ�� ������, �ٸ� �����ڵ� �߰��� �� �ִ�.
 */

// popular_product��� Ŭ���� => �ڹ� ���� ��ü�� �Ǵ� ��
public class popular_product implements Serializable {
	// ������ �����ε� 
	public popular_product(String productId, String pname, Integer unitprice) {
		super(); 
		this.productId = productId;
		this.pname = pname; 
		this.unitprice = unitprice;
	}
	
	private String productId;		// �α��ǰ ���̵� (��ǰ����)
	private String pname;			// �α� ��ǰ�� 
	private String product_num;		// �ֹ���ȣ 
	private Integer unitprice;		// �α��ǰ ����
	private String description;		// �α��ǰ ���� 
	private String manufacturer;	// ������ 
	private String category;		// �з� 
	private long numberOfstock;		// ��� �� 
	private String condition;		// ��ǰ ����(�Ż�ǰ or �߰�ǰ or ���ǰ) 
	private String img_name;		// �α� ��ǰ�̹��� 
	private int quantity; 			// ��ٱ��Ͽ� ���� ���� 
	
	public String getProductId() {
		return productId;
	}
	
	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	public String getPname() {
		return pname;
	}
	
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	public String getProduct_num() {
		return product_num;
	}
	
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	
	public Integer getUnitprice() {
		return unitprice;
	}
	
	public void setUnitprice(Integer unitprice) {
		this.unitprice = unitprice;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getManufacturer() {
		return manufacturer;
	}
	
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public long getNumberOfstock() {
		return numberOfstock;
	}
	
	public void setNumberOfstock(long numberOfstock) {
		this.numberOfstock = numberOfstock;
	}
	
	public String getCondition() {
		return condition;
	}
	
	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	public String getImg_name() {
		return img_name;
	}
	
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "popular_product [productId=" + productId + ", pname=" + pname + ", product_num=" + product_num
				+ ", unitprice=" + unitprice + ", description=" + description + ", manufacturer=" + manufacturer
				+ ", category=" + category + ", numberOfstock=" + numberOfstock + ", condition=" + condition
				+ ", img_name=" + img_name + ", quantity=" + quantity + "]";
	}
	
	public popular_product() {
		super();	// popular_product �޼ҵ带 ��ӹ���
	}
}