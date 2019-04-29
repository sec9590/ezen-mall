package shopping;

public class SoldProductDTO implements Comparable<SoldProductDTO>{
	private String sOrderId;
	private String sProductId;
	private String sQuantity;
	private String sProductName;
	private String sUnitPrice;
	
	public String getsOrderId() {
		return sOrderId;
	}
	public void setsOrderId(String sOrderId) {
		this.sOrderId = sOrderId;
	}
	public String getsProductId() {
		return sProductId;
	}
	public void setsProductId(String sProductId) {
		this.sProductId = sProductId;
	}
	public String getsQuantity() {
		return sQuantity;
	}
	public void setsQuantity(String sQuantity) {
		this.sQuantity = sQuantity;
	}
	public String getsProductName() {
		return sProductName;
	}
	public void setsProductName(String sProductName) {
		this.sProductName = sProductName;
	}
	public String getsUnitPrice() {
		return sUnitPrice;
	}
	public void setsUnitPrice(String sUnitPrice) {
		this.sUnitPrice = sUnitPrice;
	}
	@Override
	public String toString() {
		return "SoldProductDTO [sOrderId=" + sOrderId + ", sProductId=" + sProductId + ", sQuantity=" + sQuantity
				+ ", sProductName=" + sProductName + ", sUnitPrice=" + sUnitPrice + "]";
	}
	@Override
	public int compareTo(SoldProductDTO spDto) {
		int spId = Integer.parseInt(sProductId);
		int ospId = Integer.parseInt(spDto.getsProductId());
		if (spId < ospId)
			return -1;
		else if (spId > ospId)
			return 1;
		else
			return 0;
	}
}
