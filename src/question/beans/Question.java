package question.beans;

public class Question {
	private int question_num;		// ������ ��ȣ 
	private String question_title;		// ������ ���� 
	private String question_response;		// ������ �亯 
	private int question_available;		// ������ Ȱ�� ����
	
	public int getQuestion_num() {
		return question_num;
	}
	
	public void setQuestion_num(int question_num) {
		this.question_num = question_num;
	}
	
	public String getQuestion_title() {
		return question_title;
	}
	
	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
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
		return "Question [question_num=" + question_num + ", question_title=" + question_title + ", question_response="
				+ question_response + ", question_available=" + question_available + "]";
	}
}
