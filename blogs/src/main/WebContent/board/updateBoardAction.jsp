<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="vo.*" %>
<% 
	request.setCharacterEncoding("utf-8"); //한글이 깨지지 않게 인코딩
	
	//updateBoardForm에서 넘어온 값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // updateBoardForm에서 넘어온 boardNo값
	System.out.println(boardNo + "<--넘어온 BoardNo값(update)"); //디버깅
	
	String categoryName = request.getParameter("categoryName"); //updateBoardForm에서 넘어온 categoryName값
	System.out.println(categoryName + "<--넘어온categoryName값(update)");
			
	String boardTitle = request.getParameter("boardTitle"); //updateBoardForm에서 넘어온 boardTitle값
	System.out.println(boardTitle + "<--넘어온boardTitle값(update)");
	
	String boardContent = request.getParameter("boardContent"); //updateBoardForm에서 넘어온 boardContent값
	System.out.println(boardContent +"<--넘어온boardContent값(update)");
	
	String boardPw = request.getParameter("boardPw"); //updateBoardForm에서 넘어온 boardPw값
	System.out.println(boardPw +"<--넘어온boardPw(update)");
	
	//넘어온값 가공하기
	Board board = new Board();
	board.setBoardNo(boardNo); //boardNo -> board.boardNo
	board.setCategoryName(categoryName); //categoryName -> board.categoryName
	board.setBoardTitle(boardTitle); // boardTitle -> board.boardTitle
	board.setBoardContent(boardContent); //boardContent -> board.boardContent
	board.setBoardPw(boardPw); //boardPw -> board.boardPw
	
	//mariadb 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩");  // 디버깅
	
	//mariadb RDBMS 접속
	Connection conn = null; // conn 값 변수로 두고 받기
	String dburl = "jdbc:mariadb://localhost:3306/blog"; //주소
	String dbuser = "root"; // 사용자이름
	String dbpw = "java1234"; //비밀번호
	conn = DriverManager.getConnection(dburl, dbuser, dbpw); //주소,사용자이름,비밀번호 연결
	System.out.println(conn + " <-- conn"); //디버깅
	
	/*
	UPDATE board Set
	category_name =?,
	board_title = ?,
	board_content = ?,
	update_date = now()
	WHERE board_no =? AND board_pw =? 
*/
	//쿼리 저장
	String sql = "UPDATE board Set category_name =?, board_title = ?, board_content = ?, update_date = now() WHERE board_no =? AND board_pw =?";
	//sql변수에 쿼리문 저장
	PreparedStatement stmt = conn.prepareStatement(sql); //변수로 저장된 쿼리문 넣기
	stmt.setString(1,board.categoryName); //? 1번 categoryName
	stmt.setString(2,board.boardTitle); //? 2번 boardTitle
	stmt.setString(3,board.boardContent); //? 3번 boardContent
	stmt.setInt(4,board.boardNo); // ? 4번 boardNo
	stmt.setString(5,board.boardPw); // ? 5번 boardPw
	
	int row = stmt.executeUpdate();
	
	if(row == 0) {//수정실패할때
		System.out.println("수정실패"); //수정실패시 디버깅
		response.sendRedirect(request.getContextPath() +"/board/updateBoardForm.jsp?boardNo=" + board.boardNo); //다시 Form으로 돌아감
	} else if (row == 1) {//수정 성공할때
		System.out.println("수정성공"); //수정성공시 디버깅
		response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo=" + board.boardNo); //상세보기로 감
	} else { //수정성공도 실패도 아닐때?
		System.out.println("에러");// 디버깅
	}
	
	conn.close(); //connection 객체 반납
	
%>
