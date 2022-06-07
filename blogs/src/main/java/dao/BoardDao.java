package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import vo.Board;
import vo.Category; 
import dao.CategoryDao;

public class BoardDao {
	public BoardDao() {}
	public  ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage ,String categoryName) {
	ArrayList<Board> list = new ArrayList<Board>();
	//데이터베이스 자원 가져옴
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try {
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
	
	String sql = null;
	if(categoryName.equals("")) {
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	return list;

	}
	

	
	
	
public int selectBoardTotalRow(String categoryName) {
	int totalCount = 0;
	// 데이터베이스 자원 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = null;
	
	try {
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
	if (categoryName.equals("")) {
		sql = "SELECT COUNT(*) cnt FROM board" ;
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
	} else {
		sql = "SELECT COUNT(*) cnt FROM board WHERE category_name = ?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,categoryName);
	rs = stmt.executeQuery();
		}
	if(rs.next()) {
		totalCount = rs.getInt("cnt");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	return totalCount;
}
	
	public int insertBoard(Board board) { //insertBoardAction
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		String sql ="INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) VALUES (?,?,?,?,NOW(),NOW())";
		try {
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
		stmt = conn.prepareStatement(sql); //sql 구문 실행 쿼리저장된 변수대입
		stmt.setString(1,board.getCategoryName()); // ? 1번쨰 값 categoryName
		stmt.setString(2,board.getBoardTitle()); // ? 2번째 값 boardTitle
		stmt.setString(3,board.getBoardContent()); // ? 3번째 값 boardContent
		stmt.setString(4, board.getBoardPw()); // ? 4번째값 boardPw
		System.out.println(stmt + "<--stmt"); // 디버깅
		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	public int deleteBoard(int boardNo, String boardPw) { //deleteBoardAction
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		
		String sql = "DELTE FROM board "
				+ "        WHERE board_no=? "
				+ "          AND board_pw=? "; 
		try {
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	public Board selectBoardOne(int boardNo){
		Board b = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		
		String sql = "SELECT board_no boardNo"
				+ "         ,category_name categoryName"
				+ "         ,board_title boardTitle"
				+ "         ,board_content boardContent"
				+ "         ,create_date createDate"
				+ "         ,update_date updateDate "
				+ "     FROM board WHERE board_no=?";
		
		try {
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
		
		stmt =conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			b = new Board();
			b.setBoardNo(rs.getInt("boardNo"));
			b.setCategoryName(rs.getString("categoryName"));
			b.setBoardTitle(rs.getString("boardTitle"));
			b.setBoardContent(rs.getString("boardContent"));
			b.setCreateDate(rs.getString("createDate"));
			b.setUpdateDate(rs.getString("updateDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return b;
	}
	public int updateBoard(Board board) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql =  "UPDATE board SET "
				+ "           category_name = ?"
				+ "         , board_title = ?"
				+ "         , board_content = ?"
				+ "         , update_date = now() "
				+ "     WHERE board_no = ? "
				+ "       AND board_pw = ? ";
		try {
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, board.getCategoryName());
			stmt.setString(2, board.getBoardTitle());
			stmt.setString(3,board.getBoardContent());
			stmt.setInt(4, board.getBoardNo());
			stmt.setString(5, board.getBoardPw());
			row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("BoardDao.UpdateBoard 수정 성공");
			} else {
				System.out.println("BoardDao.UpdateBoard 수정 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return row;
	}
}

