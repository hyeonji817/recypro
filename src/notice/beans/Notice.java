package notice.beans;

public class Notice {
	private int notice_num;		// ������ ��ȣ 
	private String notice_title;		// ������ ����
	private String userId;		// �ۼ��� 
	private String notice_date;		// ������ �ۼ��� 
	private String notice_content;		// ������ �󼼳��� 
	private int notice_available;		// ������ Ȱ�� ����
	
	public int getNotice_num() {
		return notice_num;
	}
	
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	
	public String getNotice_title() {
		return notice_title;
	}
	
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getNotice_date() {
		return notice_date;
	}
	
	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}
	
	public String getNotice_content() {
		return notice_content;
	}
	
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	
	public int getNotice_available() {
		return notice_available;
	}
	
	public void setNotice_available(int notice_available) {
		this.notice_available = notice_available;
	}

	@Override
	public String toString() {
		return "Notice [notice_num=" + notice_num + ", notice_title=" + notice_title + ", userId=" + userId
				+ ", notice_date=" + notice_date + ", notice_content=" + notice_content + ", notice_available="
				+ notice_available + "]";
	}
}
