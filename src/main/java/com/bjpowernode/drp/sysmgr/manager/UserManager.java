package com.bjpowernode.drp.sysmgr.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bjpowernode.drp.sysmgr.domain.User;
import com.bjpowernode.drp.util.DbUtil;
import com.bjpowernode.drp.util.PageModel;
/**
 * 采用单例模式管理用户
 * @author ddh
 *
 */
public class UserManager {

	private static UserManager instance = new UserManager();
	
	private UserManager(){}
	
	public static UserManager getInstance(){
		return instance;
	}
	
	/**
	 * 添加用户
	 * @param user
	 */
	public void addUser(User user){
		String sql = "insert into t_user (user_id, user_name, password, contact_tel, email, create_date)" + 
					"values (?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DbUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getContactTel());
			pstmt.setString(5, user.getEmail());
			pstmt.setTimestamp(6, new Timestamp(new Date().getTime()));
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.close(pstmt);
			DbUtil.close(conn);
		}	
	}
	
	/**
	 * 通过用户的ID查询返回用户对象
	 * @param userId
	 * @return
	 */
	public User findUserById(String userId){
		String sql = "select user_id, user_name, password, contact_tel, email, create_date from t_user where user_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		conn = DbUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()){
				user = new User();
				user.setUserId(rs.getString("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setContactTel(rs.getString("contact_tel"));
				user.setEmail(rs.getString("email"));
				user.setCreateDate(rs.getTimestamp("create_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DbUtil.close(rs);
			DbUtil.close(pstmt);
			DbUtil.close(conn);
		}
		
		return user;
	}
	
	/**
	 * 分页查询
	 * @param pageNo 第几页
	 * @param pageSize 每页多少条数据
	 * @return pageModel
	 */
	public PageModel<User> findUserList(int pageNo, int pageSize){
		StringBuffer sbSql = new StringBuffer();	
		sbSql.append("select user_id, user_name, password, contact_tel, email, create_date ")
			.append("from ")
			.append("( ")
			.append("select rownum rn, user_id, user_name, password, contact_tel, email, create_date ")
			.append("from ")
			.append("( ")
			.append("select user_id, user_name, password, contact_tel, email, create_date from t_user where user_id <> 'root' order by user_id ")
			.append(")  where rownum <= ? ")
			.append(")  where rn > ? ");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel<User> pageModel = null;
		try {
			conn = DbUtil.getConnection();
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo - 1) * pageSize);
			rs = pstmt.executeQuery();
			List<User> userList = new ArrayList<User>();
			while(rs.next()){
				User user = new User();
				user.setUserId(rs.getString("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setContactTel(rs.getString("contact_tel"));
				user.setEmail(rs.getString("email"));
				user.setCreateDate(rs.getTimestamp("create_date"));
				userList.add(user);
			}
			pageModel = new PageModel<User>();
			pageModel.setList(userList);
			pageModel.setTotalRecords(getTotalRecords(conn));
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DbUtil.close(rs);
			DbUtil.close(pstmt);
			DbUtil.close(conn);
		}
		
		return pageModel;
	}
	
	private int getTotalRecords(Connection conn) throws SQLException {
		String sql = "select count(*) from t_user where user_id <> 'root'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		}finally{
			DbUtil.close(rs);
			DbUtil.close(pstmt);
		}
		return count;
	}
	
	/**
	 * 修改用户
	 * @param user
	 */
	public void modifyUser(User user){
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("update t_user ")
			 .append("set    user_name   = ?, ")
			 .append("password    = ?, ")
			 .append("contact_tel = ?, ")
			 .append("email       = ? ") 
			 .append("where  user_id     = ? ");
		Connection conn = null;
		PreparedStatement pstmt = null;
		conn = DbUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getContactTel());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getUserId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.close(pstmt);
			DbUtil.close(conn);
			
		}
		
	}
	
	/**
	 * 根据用户代码删除
	 * @param userId
	 */
	public boolean delUser(String userId){
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("delete from t_user where user_id = ?");
		Connection conn = null;
		PreparedStatement pstmt = null;
		conn = DbUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setString(1, userId);
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DbUtil.close(pstmt);
			DbUtil.close(conn);
		}
		
	}
}
