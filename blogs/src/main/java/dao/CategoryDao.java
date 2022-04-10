package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.*;
import java.util.*;
import dao.*;

public class CategoryDao {
	public ArrayList<HashMap<String, Object>> categoryList(String categoryName) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		System.out.println(conn +"<--conn");	
		
		String sql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		
		
		while(rs.next()) { 
			HashMap<String, Object> map = new HashMap<String, Object>(); 
			map.put("cnt", rs.getString("cnt"));
			map.put("categoryName", rs.getString("categoryName"));
			list.add(map); // 리스트에 저장
		}
		 
		rs.close();
		stmt.close();
		conn.close();
			
		return list;
	}
	
	public ArrayList<String> categoryselectOne() throws Exception {
		ArrayList<String> list = new ArrayList <String>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		String sql = "SELECT category_name categoryName from category";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			list.add(rs.getString("categoryName"));
		}
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	}
	public ArrayList<String> selectCategory(String categoryName) throws Exception {
		ArrayList<String> list = new ArrayList<String>(); 
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT category_name categoryName FROM board GROUP BY category_name ORDER BY category_name asc";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		while(rs.next()) {
			list.add(rs.getString("categoryName")); // list에 카테고리 이름 저장
		}
		
		return list;
	}
		
	}

