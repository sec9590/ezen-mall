package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * File : DBManager.java
 * Desc : �����ͺ��̽� ���� ó�� Ŭ����
 * @author Ȳ����(dinfree@dinfree.com)
 * 
 */
public class DBManager {
	private static final Logger LOG = LoggerFactory.getLogger(DBManager.class);
	// �����ͺ��̽� ���� ��ü ����
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	/**
	 * JNDI �� �̿��� Connection ��ü ����
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn;
		try {
			Context initContext = new InitialContext();
			DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/ezen");
			conn = ds.getConnection();
		}
		catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
		return conn;
	}
}