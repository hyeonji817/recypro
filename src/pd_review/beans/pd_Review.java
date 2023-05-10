package pd_review.beans;

public class pd_Review {
	private int pd_reviewId;	// 게시글 번호
	private String pd_userid; 	// 작성자
	private String pd_reviewStar;	// 별점 
	private String pd_productId;	// 상품명, 뭔진 모르겠지만 아마 사용자명(아이디명)으로 추정됨
	private String pd_reviewDate; 	// 게시글 작성일
	private String pd_reviewTitle;	// 게시글 제목
	private String pd_reviewContent;	// 게시글 내용
	private int pd_reviewAvailable;		// 게시글 활성 여부
	
	public int getPd_reviewId() {
		return pd_reviewId;
	}
	
	public void setPd_reviewId(int pd_reviewId) {
		this.pd_reviewId = pd_reviewId;
	}
	
	public String getPd_userid() {
		return pd_userid;
	}
	
	public void setPd_userid(String pd_userid) {
		this.pd_userid = pd_userid;
	}

	public String getPd_reviewStar() {
		return pd_reviewStar;
	}

	public void setPd_reviewStar(String pd_reviewStar) {
		this.pd_reviewStar = pd_reviewStar;
	}

	public String getPd_productId() {
		return pd_productId;
	}

	public void setPd_productId(String pd_productId) {
		this.pd_productId = pd_productId;
	}

	public String getPd_reviewDate() {
		return pd_reviewDate;
	}
	
	public void setPd_reviewDate(String pd_reviewDate) {
		this.pd_reviewDate = pd_reviewDate;
	}
	
	public String getPd_reviewTitle() {
		return pd_reviewTitle;
	}
	
	public void setPd_reviewTitle(String pd_reviewTitle) {
		this.pd_reviewTitle = pd_reviewTitle;
	}
	
	public String getPd_reviewContent() {
		return pd_reviewContent;
	}
	
	public void setPd_reviewContent(String pd_reviewContent) {
		this.pd_reviewContent = pd_reviewContent;
	}
	
	public int getPd_reviewAvailable() {
		return pd_reviewAvailable;
	}
	
	public void setPd_reviewAvailable(int pd_reviewAvailable) {
		this.pd_reviewAvailable = pd_reviewAvailable;
	}

	@Override
	public String toString() {
		return "pd_Review [pd_reviewId=" + pd_reviewId + ", pd_userid=" + pd_userid + ", pd_reviewStar=" + pd_reviewStar
				+ ", pd_productId=" + pd_productId + ", pd_reviewDate=" + pd_reviewDate + ", pd_reviewTitle="
				+ pd_reviewTitle + ", pd_reviewContent=" + pd_reviewContent + ", pd_reviewAvailable="
				+ pd_reviewAvailable + "]";
	}
}
