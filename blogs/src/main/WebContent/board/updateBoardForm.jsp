<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="dao.*" %>
<% 
int boardNo = Integer.parseInt(request.getParameter("boardNo"));

// -----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
Connection conn = null;
String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
String dbuser = "root"; // DB 아이디
String dbpw = "java1234"; // DB 패스워드
conn = DriverManager.getConnection(dburl, dbuser, dbpw);
System.out.println("conn :" + conn + " / 드라이버 로딩 성공");

// ---------------------------------------------------------------------쿼리
// -쿼리 저장
String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?";
PreparedStatement stmt = conn.prepareStatement(boardOneSql);
stmt.setInt(1,boardNo); // 사용자가 선택해서 넘어온 ?값

// -쿼리를 실행 후 결과값(테이블 모양의 ResultSet타입)을 리턴
// -한 행의 데이터값을 가져오기에 ArrayList 대신 Board board 사용
ResultSet boardOneRs = stmt.executeQuery(); // ~boardOneRs boardSql 쿼리로 들고온 값 저장
System.out.println(boardOneRs + "<--boardOneRs"); // 디버깅

Board board = null;
if(boardOneRs.next()) { // -next()메소드 : 문자 혹은 문자열을 공백 기준으로 한 단어 또는 한 문자씩 입력받음, 다음 줄로 커서를 이동해서 읽을 값들이 존재하면 true, 존재하지 않으면 false 
	board = new Board(); // board값 담을 새로운 리스트 생성
	board.boardNo = boardOneRs.getInt("boardNo");
	board.categoryName = boardOneRs.getString("categoryName");
	board.boardTitle =  boardOneRs.getString("boardTitle");
	board.boardContent = boardOneRs.getString("boardContent");
	board.createDate =  boardOneRs.getString("createDate");
	board.updateDate =  boardOneRs.getString("updateDate");
}

// category 목록
// -단일값을 받았기에 ArrayList 사용
String categorySql = "SELECT category_name categoryName FROM category";
PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
ResultSet categoryRs = categoryStmt.executeQuery();
ArrayList<String> categoryList = new ArrayList<String>();
while(categoryRs.next()) { // categoryRs -> categoryList 
	categoryList.add(categoryRs.getString("categoryName"));
}
conn.close();
/*
	UDATE board SET
		category_name = ?,
		board_title = ?,
		board_content = ?,
		update_date = NOW()
	WHERE board_no = ? AND board_pw = ?
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<br>
<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
		<table class ="table-striped">
			<tr>
				<td class ="font-weight-bolder">boardNo</td>
				<td><input class="form-control" type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td class ="font-weight-bolder">categoryName</td>
				<td>
					<select class="custom-select"  name ="categoryName">
					<% 
						for (String s: categoryList) {
							if(s.equals(board.categoryName)) {
					%>
								<option selected="selected" value="<%=s%>"><%=s%></option>
					<% 
							} else {
					%>
								<option value="<%=s%>"><%=s%></option>
					<% 			
							}
						}
					%>
					</select>
				</td>
			</tr>
			<tr class="form-group">
				<td class="font-weight-bolder">boardTitle</td>
				<td><input class="form-control" type ="text" name="boardTitle" value="<%=board.boardTitle%>"></td>
			</tr>
			<tr>
				<td class="font-weight-bolder">boardContent</td>
				<td>
					<textarea class="form-control" rows="8" cols="100" name="boardContent"<%=board.boardContent%>></textarea>
				</td>
			</tr>
			<tr class="form-group">
				<td class= "font-weight-bolder">boardPw</td>
				<td><input class="form-control" placeholder="Enter password" type="password" name="boardPw" value=""></td>
			</tr>
		</table>
		<button  class="btn btn-outline-dark" type="submit">게시글 수정</button>
	</form>
	</div>
</body>
</html>