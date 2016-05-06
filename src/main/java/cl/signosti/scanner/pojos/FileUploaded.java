package cl.signosti.scanner.pojos;

public class FileUploaded {
	private Integer readyState;   // 4: request finished and response is ready
	private String responseText;
	
	public FileUploaded(Integer readyState, String responseText){
		this.readyState = readyState;
		this.responseText = responseText;
	}
	
	public Integer getReadyState() {
		return readyState;
	}
	public void setReadyState(Integer readyState) {
		this.readyState = readyState;
	}
	public String getResponseText() {
		return responseText;
	}
	public void setResponseText(String responseText) {
		this.responseText = responseText;
	}
	
}
