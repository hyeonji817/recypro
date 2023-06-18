package end_coupon.beans;

public class EndCoupon {
	private int coupon_num;
	private String coupon_title;
	private String coupon_period;
	private String coupon_start;
	private String coupon_end;
	private String coupon_expend;
	
	public int getCoupon_num() {
		return coupon_num;
	}
	
	public void setCoupon_num(int coupon_num) {
		this.coupon_num = coupon_num;
	}
	
	public String getCoupon_title() {
		return coupon_title;
	}
	
	public void setCoupon_title(String coupon_title) {
		this.coupon_title = coupon_title;
	}
	
	public String getCoupon_period() {
		return coupon_period;
	}
	
	public void setCoupon_period(String coupon_period) {
		this.coupon_period = coupon_period;
	}
	
	public String getCoupon_start() {
		return coupon_start;
	}
	
	public void setCoupon_start(String coupon_start) {
		this.coupon_start = coupon_start;
	}
	
	public String getCoupon_end() {
		return coupon_end;
	}
	
	public void setCoupon_end(String coupon_end) {
		this.coupon_end = coupon_end;
	}
	
	public String getCoupon_expend() {
		return coupon_expend;
	}
	
	public void setCoupon_expend(String coupon_expend) {
		this.coupon_expend = coupon_expend;
	}

	@Override
	public String toString() {
		return "EndCoupon [coupon_num=" + coupon_num + ", coupon_title=" + coupon_title + ", coupon_period="
				+ coupon_period + ", coupon_start=" + coupon_start + ", coupon_end=" + coupon_end + ", coupon_expend="
				+ coupon_expend + "]";
	}
}
