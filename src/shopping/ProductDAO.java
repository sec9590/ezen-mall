package shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.DBManager;

public class ProductDAO {
	private static final Logger LOG = LoggerFactory.getLogger(ProductDAO.class);
	public static final int ARDUINO = 30001;
	public static final int SENSOR = 30011;
	public static final int ACTUATOR = 30021;
	public static final int PARTS = 30031;
	public static final int OSHW = 30041;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public ProductDTO getOneProduct(int pId) {
		ProductDTO pDto = new ProductDTO();
		conn = DBManager.getConnection();
		String sql = "select * from products where p_id = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pDto.setpId(Integer.toString(rs.getInt(1)));
				pDto.setpName(rs.getString(2));
				pDto.setpUnitPrice(String.format("%,d", rs.getInt(3)));
				pDto.setpImgName(rs.getString(4));
				pDto.setpDescription(rs.getString(5));
				LOG.trace(pDto.toString());
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getOneProduct(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pDto;
	}
	
	public ArrayList<ProductDTO> getProducts(int category) {
		ArrayList<ProductDTO> productList = new ArrayList<ProductDTO>();
		conn = DBManager.getConnection();
		String sql = "select * from products where p_id >= ? limit 10;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO pDto = new ProductDTO();
				pDto.setpId(Integer.toString(rs.getInt(1)));
				pDto.setpName(rs.getString(2));
				pDto.setpUnitPrice(String.format("%,d", rs.getInt(3)));
				pDto.setpImgName(rs.getString(4));
				pDto.setpDescription(rs.getString(5));
				LOG.trace(pDto.toString());
				productList.add(pDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getProducts(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productList;
	}
	
	public ArrayList<ProductDTO> getAllProducts() {
		ArrayList<ProductDTO> productList = new ArrayList<ProductDTO>();
		conn = DBManager.getConnection();
		String sql = "select * from products;";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO pDto = new ProductDTO();
				pDto.setpId(Integer.toString(rs.getInt(1)));
				pDto.setpName(rs.getString(2));
				pDto.setpUnitPrice(String.format("%,d", rs.getInt(3)));
				pDto.setpImgName(rs.getString(4));
				pDto.setpDescription(rs.getString(5));
				LOG.trace(pDto.toString());
				productList.add(pDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.info("getAllProducts(): Error Code : {}", e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productList;
	}
}
