package review.beans;

public class Review {
	private int reviewId;	// �Խñ� ��ȣ
	private String reviewTitle;		// �Խñ� ����
	private String userId;	// �ۼ���
	private String reviewDate;	// �Խñ� �ۼ���
	private String reviewContent;	// �Խñ� ����
	private int reviewAvailable;	// �Խñ� Ȱ�� ����
	
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