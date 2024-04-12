/** ������ �� ������ ��ó��ǥ : https://coding23.tistory.com/37?category=962529 */
/** ������ �� ������ ��ó��ǥ2 : https://kjh95.tistory.com/260 */

package product.beans;
/**
 * �ڹ� ��(bean)�� �̿��� ���� ��ȸ 
 * 1. �ڹ� �� 
 * 1) JAVA EE ���α׷��� ��, ���� ��ü�� ��ġ�鼭 ��������� �����͸� �����ϰų� �����ϴ� �� ���Ǵ� Ŭ���� 
 * 2) �ڹ��� DTO(Data Transfer Object, ������ ���� ��ü) Ŭ����, VO(Value Object, �� ��ü) Ŭ������
 * ���� ���� 
 * 
 *  2. �ڹ� �� Ư¡ 
 *  1) �Ӽ��� ���� �����ڴ� private�̴�.
 *  2) �� �Ӽ� (attribute, property)�� ������ setter/getter�� ������. (publicȭ�Ͽ� �� ���� �� �� �ְ� ����)
 *  3) ���� ���� �����ڸ� �ݵ�� ������, �ٸ� �����ڵ� �߰��� �� �ִ�. 
 */

import java.io.Serializable;

// Product��� Ŭ���� => �ڹٺ��� ��ü�� �Ǵ� ��.
public class Product implements Serializable {
	// ������ �����ε� 
	public Product(String productId, String pname, Integer unitprice) {
		super();
		this.productId = productId;
		this.pname = pname;
		this.unitprice = unitprice;
	}
	
	private String productId;	// ��ǰ ���̵�
	private String pname;	// ��ǰ��
	private String product_num;	// �ֹ���ȣ
	private Integer unitprice;	// ��ǰ����
	private String description;	// ��ǰ����
	private String manufacturer;	// ������ 
	private String category;	// �з� 
	private long numberOfstock;	// ��� ��
	private String condition;	// �Ż�ǰ or �߰�ǰ or ���ǰ 
	private String filename;	// ��ǰ�̹���
	private int quantity;		// ��ٱ��Ͽ� ���� ���� 
	private String popular;		// �α��ǰ 

	// getter, setter
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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getPopular() {
		return popular;
	}

	public void setPopular(String popular) {
		this.popular = popular;
	}

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", pname=" + pname + ", product_num=" + product_num + ", unitprice="
				+ unitprice + ", description=" + description + ", manufacturer=" + manufacturer + ", category="
				+ category + ", numberOfstock=" + numberOfstock + ", condition=" + condition + ", filename=" + filename
				+ ", quantity=" + quantity + "]";
	}

	public Product() {
		super();	// Product �޼ҵ带 ��ӹ���
	}

}