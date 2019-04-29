package customer;

public class CustomerDTO {
	private String cId;
	private String cName;
	private String cPassword;
	private String cEmail;
	private String cTel;
	
	public CustomerDTO() { }
	public CustomerDTO(String cId, String cName, String cPassword, String cEmail, String cTel) {
		super();
		this.cId = cId;
		this.cName = cName;
		this.cPassword = cPassword;
		this.cEmail = cEmail;
		this.cTel = cTel;
	}

	public String getcId() {
		return cId;
	}
	public void setcId(String cId) {
		this.cId = cId;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getcPassword() {
		return cPassword;
	}
	public void setcPassword(String cPassword) {
		this.cPassword = cPassword;
	}
	public String getcEmail() {
		return cEmail;
	}
	public void setcEmail(String cEmail) {
		this.cEmail = cEmail;
	}
	public String getcTel() {
		return cTel;
	}
	public void setcTel(String cTel) {
		this.cTel = cTel;
	}
	@Override
	public String toString() {
		return "CustomerDTO [cId=" + cId + ", cName=" + cName + ", cPassword=" + cPassword + ", cEmail=" + cEmail
				+ ", cTel=" + cTel + "]";
	}
}
