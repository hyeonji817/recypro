package consult.beans;

public class Consult {
	private int consult_num;		// 문의글 번호 
	private String consult_title;		// 문의글 제목 
	private String consult_date;		// 문의글 날짜 
	private String consult_content;		// 문의글 내용 
	private int consult_available;		// 문의글 활성 여부 
	
	public int getConsult_num() {
		return consult_num;
	}
	
	public void setConsult_num(int consult_num) {
		this.consult_num = consult_num;
	}
	
	public String getConsult_title() {
		return consult_title;
	}
	
	public void setConsult_title(String consult_title) {
		this.consult_title = consult_title;
	}
	
	public String getConsult_date() {
		return consult_date;
	}
	
	public void setConsult_date(String consult_date) {
		this.consult_date = consult_date;
	}
	
	public String getConsult_content() {
		return consult_content;
	}
	
	public void setConsult_content(String consult_content) {
		this.consult_content = consult_content;
	}
	
	public int getConsult_available() {
		return consult_available;
	}
	
	public void setConsult_available(int consult_available) {
		this.consult_available = consult_available;
	}

	@Override
	public String toString() {
		return "Consult [consult_num=" + consult_num + ", consult_title=" + consult_title + ", consult_date="
				+ consult_date + ", consult_content=" + consult_content + ", consult_available=" + consult_available
				+ "]";
	}
}
