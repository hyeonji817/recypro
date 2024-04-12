package popular_product.beans;

import java.io.Serializable;

/**
 * 자바 빈(bean)을 이용한 정보 조회
 * 1. 자바 빈
 * 1) JAVA EE 프로그래밍 시, 여러 객체를 거치면서 만들어지는 데이터를 저장하거나 전달하는 데 사용되는 클래스 
 * 2) 자바의 DTO(Data Transfer Object, 데이터 전송 객체) 클래스, VO(Value Object, 값 객체) 클래스와 
 * 같은 개념 
 * 
 * 2. 자바 빈 특징 
 * 1) 속성의 접근 제한자는 private이다. 
 * 2) 각 속성 (attribute, property)은 각각의 setter/getter를 가진다. (public화하여 다 같이 쓸 수 있게 공유) 
 * 3) 인자 없는 생성자를 반드시 가지며, 다른 생성자도 추가할 수 있다.
 */

// popular_product라는 클래스 => 자바 빈의 객체가 되는 것
public class popular_product implements Serializable {
	// 생성자 오버로드 
	public popular_product(String productId, String pname, Integer unitprice) {
		super(); 
		this.productId = productId;
		this.pname = pname; 
		this.unitprice = unitprice;
	}
	
	private String productId;		// 인기상품 아이디 (상품제목)
	private String pname;			// 인기 상품명 
	private String product_num;		// 주문번호 
	private Integer unitprice;		// 인기상품 가격
	private String description;		// 인기상품 설명 
	private String manufacturer;	// 제조사 
	private String category;		// 분류 
	private long numberOfstock;		// 재고 수 
	private String condition;		// 상품 상태(신상품 or 중고품 or 재생품) 
	private String img_name;		// 인기 상품이미지 
	private int quantity; 			// 장바구니에 담은 개수 
	
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
		super();	// popular_product 메소드를 상속받음
	}
}