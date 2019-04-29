package shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.TreeSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.DBManager;

public class OrderDAO {
	private static final Logger LOG = LoggerFactory.getLogger(OrderDAO.class);
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public boolean insertDetailOrders(TreeSet<SoldProductDTO> orderSet, String customerId) {
		LOG.trace("insertDetailOrders(): " + customerId);
		int sum = 0;
		for (SoldProductDTO spDto : orderSet) {		// o_price 값 구하기
			String quantity = spDto.getsQuantity();
			String unitPrice = spDto.getsUnitPrice();
			int itemSum = Integer.parseInt(quantity.replaceAll(",", ""))*Integer.parseInt(unitPrice.replaceAll(",", ""));
			sum += itemSum;
			LOG.trace("insertDetailOrders(): " + spDto.toString());
		}
		insertOrder(Integer.parseInt(customerId), sum);		// orders table에 insert
		int orderId = getOrderIdByCustomerId(customerId);	// o_id 구하기
		for (SoldProductDTO spDto : orderSet) {		// sold_products table에 insert
			int productId = Integer.parseInt(spDto.getsProductId());
			String quantity = spDto.getsQuantity();
			int qty = Integer.parseInt(quantity.replaceAll(",", ""));
			insertSoldProduct(orderId, productId, qty);
			LOG.trace("insertDetailOrders(): new orderId = " + orderId + ", productId = " + productId + ", quantity = " + qty);
		}
		return true;
	}
	
	public void insertSoldProduct(int orderId, int productId, int quantity) {
		conn = DBManager.getConnection();
		String sql = "insert into sold_products values(?, ?, ?);";
		try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orderId);
				pstmt.setInt(2, productId);
				pstmt.setInt(3, quantity);
				pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("insertSoldProduct(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void insertOrder(int customerId, int price) {
		conn = DBManager.getConnection();
		String sql = "insert into orders (o_customerId, o_price) values(?, ?);";
		try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, customerId);
				pstmt.setInt(2, price);
				pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("insertOrder(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public int sumDetailOrders(int orderId) {
		conn = DBManager.getConnection();
		String sql = "select p.p_name, s.s_quantity, p.p_unitPrice from sold_products as s " + 
					"inner join products as p on s.s_productId = p.p_id where s.s_orderId=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderId);
			rs = pstmt.executeQuery();
			int sum = 0;
			while(rs.next()) {
				String pName = rs.getString(1);
				int quantity = rs.getInt(2);
				int unitPrice = rs.getInt(3);
				sum += quantity * unitPrice;
			}
			return sum;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getDetailOrders(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
	
	public void updateOrders(int orderId, int price) {
		conn = DBManager.getConnection();
		String sql = "update orders set o_price=? where o_id=?;";
		try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, price);
				pstmt.setInt(2, orderId);
				pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("updateOrders(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<SoldProductDTO> getSoldProducts(String orderId) {
		ArrayList<SoldProductDTO> spList = new ArrayList<SoldProductDTO>();
		conn = DBManager.getConnection();
		String sql = "select * from sold_products where s_orderId=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(orderId));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SoldProductDTO spDto = new SoldProductDTO();
				spDto.setsOrderId(orderId);
				spDto.setsProductId(Integer.toString(rs.getInt(2)));
				spDto.setsQuantity(Integer.toString(rs.getInt(3)));
				LOG.trace(spDto.toString());
				spList.add(spDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getDetailOrders(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return spList;
	}
	
	public ArrayList<DetailOrderDTO> getDetailOrders(String orderId) {
		ArrayList<DetailOrderDTO> detailOrderList = new ArrayList<DetailOrderDTO>();
		conn = DBManager.getConnection();
		String sql = "select p.p_name, s.s_quantity, p.p_unitPrice from sold_products as s " + 
					"inner join products as p on s.s_productId = p.p_id where s.s_orderId=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(orderId));
			rs = pstmt.executeQuery();
			int count = 1;
			while(rs.next()) {
				DetailOrderDTO doDto = new DetailOrderDTO();
				doDto.setdNumber(Integer.toString(count));
				doDto.setdProductName(rs.getString(1));
				int quantity = rs.getInt(2);
				int unitPrice = rs.getInt(3);
				doDto.setdQuantity(String.format("%,d", quantity));
				doDto.setdUnitPrice(String.format("%,d", unitPrice));
				doDto.setdPrice(String.format("%,d", quantity * unitPrice));
				LOG.trace(doDto.toString());
				detailOrderList.add(doDto);
				count++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getDetailOrders(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return detailOrderList;
	}
	
	public OrderDTO getOneOrder(String orderId) {
		OrderDTO oDto = new OrderDTO();
		conn = DBManager.getConnection();
		String sql = "select o_customerId, date_format(o_date, '%Y-%m-%d %H:%i'), o_price from orders where o_id=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(orderId));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				oDto.setoId(orderId);
				oDto.setoCustomerId(Integer.toString(rs.getInt(1)));
				oDto.setoDate(rs.getString(2));
				oDto.setoPrice(String.format("%,d", rs.getInt(3)));
				LOG.trace(oDto.toString());
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOrdersByCustomer(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return oDto;
	}
	
	public int getOrderIdByCustomerId(String customerId) {
		int orderId = 0;
		conn = DBManager.getConnection();
		String sql = "select o_id from orders where o_customerId=? order by o_id desc limit 1;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(customerId));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				orderId = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOrdersByCustomer(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderId;
	}
	
	public ArrayList<OrderDTO> getOrdersByCustomer(String customerId) {
		ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
		conn = DBManager.getConnection();
		String sql = "select o_id, date_format(o_date, '%Y-%m-%d %H:%i'), o_price from orders where o_customerId=? order by o_id desc;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(customerId));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderDTO oDto = new OrderDTO();
				oDto.setoId(Integer.toString(rs.getInt(1)));
				oDto.setoCustomerId(customerId);
				oDto.setoDate(rs.getString(2));
				oDto.setoPrice(String.format("%,d", rs.getInt(3)));
				LOG.trace(oDto.toString());
				orderList.add(oDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOrdersByCustomer(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderList;
	}
	
	public ArrayList<OrderDTO> getOrdersByDate(String date) {
		ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
		conn = DBManager.getConnection();
		String sql = "select o_id, o_customerId, o_price from orders where date(o_date)=? order by o_id desc;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderDTO oDto = new OrderDTO();
				oDto.setoId(Integer.toString(rs.getInt(1)));
				oDto.setoCustomerId(rs.getString(2));
				oDto.setoPrice(String.format("%,d", rs.getInt(3)));
				LOG.trace(oDto.toString());
				orderList.add(oDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOrdersByDate(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderList;
	}
	
	public ArrayList<OrderDTO> getAllOrders() {
		ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
		conn = DBManager.getConnection();
		String sql = "select o_id, o_customerId, date_format(o_date, '%Y-%m-%d %H:%i'), o_price from orders order by o_id desc;";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderDTO oDto = new OrderDTO();
				oDto.setoId(Integer.toString(rs.getInt(1)));
				oDto.setoCustomerId(Integer.toString(rs.getInt(2)));
				oDto.setoDate(rs.getString(3));
				oDto.setoPrice(String.format("%,d", rs.getInt(4)));
				LOG.trace(oDto.toString());
				orderList.add(oDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getAllOrders(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderList;
	}
}
