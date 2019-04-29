package admin;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import shopping.OrderDAO;
import shopping.OrderDTO;
import shopping.ProductDAO;
import shopping.ProductDTO;
import shopping.SoldProductDTO;
import util.DBManager;

public class AdminDAO {
	private static final Logger LOG = LoggerFactory.getLogger(AdminDAO.class);
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<InventoryDTO> iList = null;
	
	public String prepareDownload() {
		ArrayList<DailySalesDTO> dsList = getAllDailySales(0);
		StringBuffer sb = new StringBuffer();
		
		try {
			FileWriter fw = new FileWriter("D:/Workspace/Temp/Whole Sales.csv");
			String head = "주문일자,고객ID,고객명,주문번호,금액\n";
			sb.append(head);
			fw.write(head);
			for (DailySalesDTO dsDto : dsList) {
				String line = dsDto.getdDate() + "," + dsDto.getdCustomerId() + "," + dsDto.getdCustomerName() + ","
						+ dsDto.getdOrderId() + "," + dsDto.getdPrice().replaceAll(",", "") + "\n";
				sb.append(line);
				fw.write(line);
			}
			fw.flush();
			fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	public String getTotalPrice(ArrayList<InventoryDTO> piList) {
		int sum = 0;
		for (InventoryDTO iDto : piList) {
			sum += Integer.parseInt(iDto.getPrice().replaceAll(",", ""));
		}
		return String.format("%,d", sum);
	}
	
	public ArrayList<InventoryDTO> getInventoryByDate(String date) {
		initInventory();
		OrderDAO oDao = new OrderDAO();
		ArrayList<OrderDTO> oList = oDao.getOrdersByDate(date);
		for(OrderDTO oDto : oList) {
			LOG.trace("getInventoryByDate(): " + oDto.toString());
			ArrayList<SoldProductDTO> spList = oDao.getSoldProducts(oDto.getoId());
			for (SoldProductDTO spDto : spList) {
				updateInventory(spDto.getsProductId(), Integer.parseInt(spDto.getsQuantity()));
			}
		}
		return iList;
	}
	
	public ArrayList<InventoryDTO> getInventory() {
		initInventory();
		OrderDAO oDao = new OrderDAO();
		ArrayList<OrderDTO> oList = oDao.getAllOrders();
		for(OrderDTO oDto : oList) {
			ArrayList<SoldProductDTO> spList = oDao.getSoldProducts(oDto.getoId());
			for (SoldProductDTO spDto : spList) {
				updateInventory(spDto.getsProductId(), Integer.parseInt(spDto.getsQuantity()));
			}
		}
		return iList;
	}
	
	private void initInventory() {
		iList = new ArrayList<InventoryDTO>();
		ProductDAO pDao = new ProductDAO();
		ArrayList<ProductDTO> pList = pDao.getAllProducts();
		for(ProductDTO pDto : pList) {
			InventoryDTO iDto = new InventoryDTO();
			iDto.setProductId(pDto.getpId());
			iDto.setProductName(pDto.getpName());
			iDto.setUnitPrice(pDto.getpUnitPrice());
			iDto.setQuantity("0");
			iDto.setPrice("0");
			iList.add(iDto);
		}
	}
	
	private void updateInventory(String productId, int quantity) {
		for (InventoryDTO iDto : iList) {
			if (iDto.getProductId().equals(productId)) {
				int qty = Integer.parseInt(iDto.getQuantity());
				int unitPrice = Integer.parseInt(iDto.getUnitPrice().replaceAll(",", ""));
				int price = Integer.parseInt(iDto.getPrice().replaceAll(",", ""));
				iDto.setQuantity(String.format("%,d", qty + quantity));
				iDto.setPrice(String.format("%,d", price + unitPrice*quantity));
				break;
			}
		}
	}
	
	public int getTotalPage() {
		int totalPage = 0;
		conn = DBManager.getConnection();
		String sql = "select count(*) from orders;";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				totalPage = (rs.getInt(1) - 1) / 10 + 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getTotalPage(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return totalPage;
	}
	
	public ArrayList<DailySalesDTO> getAllDailySales(int page) {
		ArrayList<DailySalesDTO> dsList = new ArrayList<DailySalesDTO>();
		conn = DBManager.getConnection();
		String sql;
		int offset = 0;
		if (page == 0) {	// page가 0이면 모든 데이터를 보냄
			sql = "select date(o.o_date), o.o_customerId, c.c_name, o.o_id, o.o_price from orders as o " + 
					"inner join customers as c on o.o_customerId = c.c_id order by date(o.o_date) desc;";
		} else {			// page가 0이 아니면 해당 페이지 데이터만 보냄
			sql = "select date(o.o_date), o.o_customerId, c.c_name, o.o_id, o.o_price from orders as o " + 
					"inner join customers as c on o.o_customerId = c.c_id order by date(o.o_date) desc limit ?, 10;";
			offset = (page - 1) * 10;
		}
		try {
			pstmt = conn.prepareStatement(sql);
			if (page != 0)
				pstmt.setInt(1, offset);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DailySalesDTO drDto = new DailySalesDTO();
				drDto.setdDate(rs.getString(1));
				drDto.setdCustomerId(Integer.toString(rs.getInt(2)));
				drDto.setdCustomerName(rs.getString(3));
				drDto.setdOrderId(Integer.toString(rs.getInt(4)));
				drDto.setdPrice(String.format("%,d", rs.getInt(5)));
				LOG.trace(drDto.toString());
				dsList.add(drDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getAllDailySales(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dsList;
	}
	
	public String getDailyTotalPrice(ArrayList<DailySalesDTO> dsList) {
		int sum = 0;
		
		for (DailySalesDTO dsDto : dsList) {
			sum += Integer.parseInt(dsDto.getdPrice().replaceAll(",", ""));
		}
		return String.format("%,d", sum);
	}
	
	public ArrayList<DailySalesDTO> getDailySales(String date) {
		ArrayList<DailySalesDTO> dsList = new ArrayList<DailySalesDTO>();
		conn = DBManager.getConnection();
		String sql = "select date(o.o_date), o.o_customerId, c.c_name, o.o_id, o.o_price from orders as o " + 
				"inner join customers as c on o.o_customerId = c.c_id where date(o_date)=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DailySalesDTO drDto = new DailySalesDTO();
				drDto.setdDate(rs.getString(1));
				drDto.setdCustomerId(Integer.toString(rs.getInt(2)));
				drDto.setdCustomerName(rs.getString(3));
				drDto.setdOrderId(Integer.toString(rs.getInt(4)));
				drDto.setdPrice(String.format("%,d", rs.getInt(5)));
				LOG.trace(drDto.toString());
				dsList.add(drDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getDailySales(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dsList;
	}
}
