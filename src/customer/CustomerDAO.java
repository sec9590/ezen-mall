package customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.DBManager;

public class CustomerDAO {
	private static final Logger LOG = LoggerFactory.getLogger(CustomerDAO.class);
	public static final int ID_PASSWORD_MATCH = 1;
	public static final int ID_DOES_NOT_EXIST = 2;
	public static final int PASSWORD_IS_WRONG = 3;
	public static final int DATABASE_ERROR = -1;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public int verifyIdPassword(int id, String password) {
		return ID_PASSWORD_MATCH;
	}
	
	public String getLastId() {
		String cId = null;
		conn = DBManager.getConnection();
		String sql = "select c_id from customers order by c_id desc limit 1;";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cId = Integer.toString(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getLastId(): Error Code : {}", e.getErrorCode());
			return null;
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cId;
	}
	
	public void addCustomer(CustomerDTO cDto) {
		LOG.trace("addCustomer(): " + cDto.toString());
		BCrypt bc = new BCrypt();
		conn = DBManager.getConnection();
		String sql = "insert into customers(c_name, c_password, c_email, c_tel) values(?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cDto.getcName());
			pstmt.setString(2, bc.hashpw(cDto.getcPassword(), bc.gensalt(10)));
			pstmt.setString(3, cDto.getcEmail());
			pstmt.setString(4, cDto.getcTel());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("addCustomer() Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public CustomerDTO getOneCustomer(String cId) {
		CustomerDTO cDto = new CustomerDTO();
		conn = DBManager.getConnection();
		String sql = "select * from customers where c_id=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(cId));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cDto.setcId(cId);
				cDto.setcName(rs.getString(2));
				cDto.setcPassword(rs.getString(3));
				cDto.setcEmail(rs.getString(4));
				cDto.setcTel(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOneCustomer(): Error Code : {}", e.getErrorCode());
			return null;
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cDto;
	}
	
	public ArrayList<CustomerDTO> getAllCustomers() {
		ArrayList<CustomerDTO> cList = new ArrayList<CustomerDTO>();
		conn = DBManager.getConnection();
		String sql = "select * from customers;";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CustomerDTO cDto = new CustomerDTO();
				cDto.setcId(Integer.toString(rs.getInt(1)));
				cDto.setcName(rs.getString(2));
				cDto.setcPassword(rs.getString(3));
				cDto.setcEmail(rs.getString(4));
				cDto.setcTel(rs.getString(5));
				cList.add(cDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getAllCustomers(): Error Code : {}", e.getErrorCode());
			return null;
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cList;
	}
}
