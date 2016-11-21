package com.bjpowernode.drp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * ��װ���ݿⳣ�ò���
 * @author ddh
 *
 */
public class DbUtil {
	
	/**
	 * ��̬����,ȡ��Connection
	 * @return
	 */
	public static Connection getConnection(){
		Connection conn = null;
		JdbcConfig jdbcConfig = XmlConfigReader.getInstall().getJdbcConfig();
		try {
			Class.forName(jdbcConfig.getDriverName());
			conn = DriverManager.getConnection(jdbcConfig.getUrl(), jdbcConfig.getUserName(), jdbcConfig.getPassword());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	
	/**
	 * ��̬�رշ���,�ر�Connection
	 * @param conn
	 */
	public static void close(Connection conn){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * ��̬�رշ���,�ر�Statement
	 * @param st
	 */
	public static void close(Statement st){
		if(st != null){
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(PreparedStatement pstmt){
		if(pstmt != null){
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * ��̬�رշ���,�ر�ResultSet
	 * @param rs
	 */
	public static void close(ResultSet rs){
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args){
		Connection conn = DbUtil.getConnection();
		String sql = "select name from t_client";
		Statement st = null;
		ResultSet rs = null;
		try {
			st  = conn.createStatement();
			//st.executeUpdate(sql);
			rs = st.executeQuery(sql);
			while(rs.next()){
				System.out.println(rs.getString("NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
}
