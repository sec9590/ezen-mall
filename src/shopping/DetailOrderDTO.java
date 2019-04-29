package shopping;

public class DetailOrderDTO {
	private String dNumber;
	private String dProductName;
	private String dQuantity;
	private String dUnitPrice;
	private String dPrice;
	
	public String getdNumber() {
		return dNumber;
	}
	public void setdNumber(String dNumber) {
		this.dNumber = dNumber;
	}
	public String getdProductName() {
		return dProductName;
	}
	public void setdProductName(String dProductName) {
		this.dProductName = dProductName;
	}
	public String getdQuantity() {
		return dQuantity;
	}
	public void setdQuantity(String dQuantity) {
		this.dQuantity = dQuantity;
	}
	public String getdUnitPrice() {
		return dUnitPrice;
	}
	public void setdUnitPrice(String dUnitPrice) {
		this.dUnitPrice = dUnitPrice;
	}
	public String getdPrice() {
		return dPrice;
	}
	public void setdPrice(String dPrice) {
		this.dPrice = dPrice;
	}
	@Override
	public String toString() {
		return "DetailOrderDTO [dNumber=" + dNumber + ", dProductName=" + dProductName + ", dQuantity=" + dQuantity
				+ ", dUnitPrice=" + dUnitPrice + ", dPrice=" + dPrice + "]";
	}
}
