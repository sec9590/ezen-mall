package shopping;

public class ProductDTO {
	private String pId;
	private String pName;
	private String pUnitPrice;
	private String pImgName;
	private String pDescription;
	
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpUnitPrice() {
		return pUnitPrice;
	}
	public void setpUnitPrice(String pUnitPrice) {
		this.pUnitPrice = pUnitPrice;
	}
	public String getpImgName() {
		return pImgName;
	}
	public void setpImgName(String pImgName) {
		this.pImgName = pImgName;
	}
	public String getpDescription() {
		return pDescription;
	}
	public void setpDescription(String pDescription) {
		this.pDescription = pDescription;
	}
	@Override
	public String toString() {
		return "ProductDTO [pId=" + pId + ", pName=" + pName + ", pUnitPrice=" + pUnitPrice + ", pImgName=" + pImgName
				+ ", pDescription=" + pDescription + "]";
	}
}
