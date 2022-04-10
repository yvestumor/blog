package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import vo.Photo;

public class PhotoDao {
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		System.out.println(conn +"<--conn");
		/*
		  INSERT INTO photo(photo_name, photo_original_name, photo_type,photo_pw,writer,create_date,update_date
		  ) values(?,?,?,?,?,NOW(),NOW())
		 */
		String sql ="INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date,update_date)values (?,?,?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,photo.getPhotoName());
		stmt.setString(2,photo.getPhotoOriginalName());
		stmt.setString(3,photo.getPhotoType());
		stmt.setString(4,photo.getPhotoPw());
		stmt.setString(5,photo.getWriter());
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
		
	}
	//이미지 목록
	public ArrayList <Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Photo> list = new ArrayList<Photo>();
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
		String dbuser = "root"; //사용자이름
		String dbpw = "java1234"; // 비밀번호
		/*
		 * SELECT photo_no photoNo, photo_name photoName,writer, create_date createDate 
		 * FROM photo ORDER BY create_date DESC LIMIT ? ,?
		 */
		//쿼리 저장
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Photo p = new Photo();
			p.setPhotoNo(rs.getInt("photoNo"));
			p.setPhotoName(rs.getString("photoName"));
			list.add(p);
		}
		return list;
	}
	
	
	//이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println(conn + " <--conn");
		
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		System.out.println(stmt + " <--sql deletePhoto 쿼리");
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception{
		int total = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
		String dbuser = "root"; //사용자이름
		String dbpw = "java1234"; // 비밀번호
		
		String sql = "SELECT COUNT(*) cnt FROM photo";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		return total;
	}
	
	//이미지 하나 상세보기
	public ArrayList<Photo> selectPhotoOne(int photoNo) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
		String dbuser = "root"; //사용자이름
		String dbpw = "java1234"; // 비밀번호
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT photo_no photoNo,photo_name photoName, writer,create_date createDate,update_date updateDate from photo where photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			Photo p = new Photo();
			p.setPhotoNo(rs.getInt("photoNo"));
			p.setPhotoName(rs.getString("photoName"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			p.setUpdateDate(rs.getString("updateDate"));
			list.add(p);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// 이미지 이름을 변환 하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		String photoName = null;
Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT photo_name photoName FROM photo WHERE photo_no =?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, photoNo);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			photoName = rs.getString("photoName");
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return photoName;
	}
	
		
	

}
