package admin;

public class DailySalesDTO {
	private String dDate;
	private String dCustomerId;
	private String dCustomerName;
	private String dOrderId;
	private String dPrice;
	
	public String getdDate() {
		return dDate;
	}
	public void setdDate(String dDate) {
		this.dDate = dDate;
	}
	public String getdCustomerId() {
		return dCustomerId;
	}
	public void setdCustomerId(String dCustomerId) {
		this.dCustomerId = dCustomerId;
	}
	public String getdCustomerName() {
		return dCustomerName;
	}
	public void setdCustomerName(String dCustomerName) {
		this.dCustomerName = dCustomerName;
	}
	public String getdOrderId() {
		return dOrderId;
	}
	public void setdOrderId(String dOrderId) {
		this.dOrderId = dOrderId;
	}
	public String getdPrice() {
		return dPrice;
	}
	public void setdPrice(String dPrice) {
		this.dPrice = dPrice;
	}
	@Override
	public String toString() {
		return "DailySalesDTO [dDate=" + dDate + ", dCustomerId=" + dCustomerId + ", dCustomerName=" + dCustomerName
				+ ", dOrderId=" + dOrderId + ", dPrice=" + dPrice + "]";
	}
}
