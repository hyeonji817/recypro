package question.beans;

public class question {
	private int question_num;		// 질문글 번호 
	private String quetion_title;		// 질문글 제목 
	private String question_response;		// 질문글 답변 
	private int question_available;		// 질문글 활성 여부
	
	public int getQuestion_num() {
		return question_num;
	}
	
	public void setQuestion_num(int question_num) {
		this.question_num = question_num;
	}
	
	public String getQuetion_title() {
		return quetion_title;
	}
	
	public void setQuetion_title(String quetion_title) {
		this.quetion_title = quetion_title;
	}
	
	public String getQuestion_response() {
		return question_response;
	}
	
	public void setQuestion_response(String question_response) {
		this.question_response = question_response;
	}

	public int getQuestion_available() {
		return question_available;
	}

	public void setQuestion_available(int question_available) {
		this.question_available = question_available;
	}

	@Override
	public String toString() {
		return "question [question_num=" + question_num + ", quetion_title=" + quetion_title + ", question_response="
				+ question_response + ", question_available=" + question_available + "]";
	}
}
