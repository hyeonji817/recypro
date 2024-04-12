package orderlist1.beans;

public class orderlist1 {
	private Integer shopping_num;	// 주문번호 (외래키 설정 예정)
	private String shopping_bank;	// 은행명 
	private String return_reason;	// 반송사유 
	private String shopping_account;	// 계좌번호 
	private String shopping_owner;	// 예금주 
	
	public orderlist1(Integer shopping_num, String shopping_bank, String return_reason, String shopping_account,
			String shopping_owner) {
		super();
		this.shopping_num = shopping_num;
		this.shopping_bank = shopping_bank;
		this.return_reason = return_reason;
		this.shopping_account = shopping_account;
		this.shopping_owner = shopping_owner;
	}

	public Integer getShopping_num() {
		return shopping_num;
	}
	
	public void setShopping_num(Integer shopping_num) {
		this.shopping_num = shopping_num;
	}
	
	public String getShopping_bank() {
		return shopping_bank;
	}
	
	public void setShopping_bank(String shopping_bank) {
		this.shopping_bank = shopping_bank;
	}
	
	public String getReturn_reason() {
		return return_reason;
	}
	
	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
	}
	
	public String getShopping_account() {
		return shopping_account;
	}
	
	public void setShopping_account(String shopping_account) {
		this.shopping_account = shopping_account;
	}
	
	public String getShopping_owner() {
		return shopping_owner;
	}
	
	public void setShopping_owner(String shopping_owner) {
		this.shopping_owner = shopping_owner;
	}

	@Override
	public String toString() {
		return "orderlist1 [shopping_num=" + shopping_num + ", shopping_bank=" + shopping_bank + ", return_reason="
				+ return_reason + ", shopping_account=" + shopping_account + ", shopping_owner=" + shopping_owner + "]";
	}
}
