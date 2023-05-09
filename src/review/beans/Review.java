package review.beans;

public class Review {
	private int reviewId;	// 게시글 번호
	private String reviewTitle;		// 게시글 제목
	private String userId;	// 작성자
	private String reviewDate;	// 게시글 작성일
	private String reviewContent;	// 게시글 내용
	private int reviewAvailable;	// 게시글 활성 여부
	
	public int getReviewId() {
		return reviewId;
	}
	
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	
	public String getReviewTitle() {
		return reviewTitle;
	}
	
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReviewDate() {
		return reviewDate;
	}
	
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	public String getReviewContent() {
		return reviewContent;
	}
	
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	
	public int getReviewAvailable() {
		return reviewAvailable;
	}
	
	public void setReviewAvailable(int reviewAvailable) {
		this.reviewAvailable = reviewAvailable;
	}

	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", reviewTitle=" + reviewTitle + ", userId=" + userId + ", reviewDate="
				+ reviewDate + ", reviewContent=" + reviewContent + ", reviewAvailable=" + reviewAvailable + "]";
	}
}
