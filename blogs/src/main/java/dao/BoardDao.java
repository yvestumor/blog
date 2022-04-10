package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import vo.Board;
import vo.Category; 
import dao.CategoryDao;

public class BoardDao {
	public BoardDao() {}
	public  ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage ,String categoryName) throws Exception {
	ArrayList<Board> list = new ArrayList<Board>();
	// guestbook 10행 반환되도록 구현
	Class.forName("org.mariadb.jdbc.Driver");
	//데이터베이스 자원 가져옴
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	
	String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
	String dbuser = "root"; //사용자이름
	String dbpw = "java1234"; //비번
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	
	String sql = null;
	if(categoryName == null) {
	sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,beginRow); // 현재 페이지 위치
	stmt.setInt(2,rowPerPage); // 볼수있는 게시글 수
	} else {
	sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, categoryName);
	stmt.setInt(2,beginRow);
	stmt.setInt(3,rowPerPage);
	}
	rs = stmt.executeQuery();
	
	while(rs.next()) {
		Board b = new Board();
		b.setBoardNo(rs.getInt("boardNo"));
		b.setCategoryName(rs.getString("categoryName"));
		b.setBoardTitle(rs.getString("boardTitle"));
		b.setCreateDate(rs.getString("createDate"));
		list.add(b);
	}
	rs.close();
	stmt.close();
	conn.close();

	return list;

	}
	

	
	
	
public int selectBoardTotalRow() throws Exception{
	int total = 0;
	Class.forName("org.mariadb.jdbc.Driver");
	// 데이터베이스 자원 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
			
	String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
	String dbuser = "root"; //사용자이름
	String dbpw = "java1234"; // 비밀번호
	
	String sql = "SELECT COUNT(*) cnt FROM board" ;
	conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	if(rs.next()) {
		total = rs.getInt("cnt");
	}
	
	return total;
}
	public ArrayList<String> insertBoardCategory() throws Exception { //insertBoardForm
		ArrayList<String> list = new ArrayList<String>();
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "select category_name categoryName from category order by category_name asc"; //쿼리문 변수 만들기
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			list.add(rs.getString("CategoryName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
		
	}
	public void insertBoard(Board board) throws Exception { //insertBoardAction
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql ="INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) VALUES (?,?,?,?,NOW(),NOW())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql); //sql 구문 실행 쿼리저장된 변수대입
		stmt.setString(1,board.getCategoryName()); // ? 1번쨰 값 categoryName
		stmt.setString(2,board.getBoardTitle()); // ? 2번째 값 boardTitle
		stmt.setString(3,board.getBoardContent()); // ? 3번째 값 boardContent
		stmt.setString(4, board.getBoardPw()); // ? 4번째값 boardPw
		System.out.println(stmt + "<--stmt"); // 디버깅
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
		
	}
	public int deleteBoard(int boardNo, String boardPw) throws Exception { //deleteBoardAction
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		System.out.println(conn +"<--conn");
		
		String sql = "delete from board where board_no=? and board_pw=? "; 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
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
	public ArrayList<Board> selectBoardOne(int boardNo) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		String sql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate from board where board_no=?";
		stmt =conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
		 Board b = new Board();
			b.setBoardNo(rs.getInt("boardNo"));
			b.setCategoryName(rs.getString("categoryName"));
			b.setBoardTitle(rs.getString("boardTitle"));
			b.setBoardContent(rs.getString("boardContent"));
			b.setCreateDate(rs.getString("createDate"));
			b.setUpdateDate(rs.getString("updateDate"));
			list.add(b);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}

