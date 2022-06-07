<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="dao.*" %>
<% 
int boardNo = Integer.parseInt(request.getParameter("boardNo"));

// -----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
BoardDao boardDao = new BoardDao(); // BoardDao 호출 
Board board = new Board();
board = boardDao.selectBoardOne(boardNo); // 수정할board호출 

CategoryDao categoryDao = new CategoryDao();
 ArrayList<String> categoryList = categoryDao.selectBoardCategory();

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
							if(s.equals(board.getCategoryName())) {
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
				<td><input class="form-control" type ="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<td class="font-weight-bolder">boardContent</td>
				<td>
					<textarea class="form-control" rows="8" cols="100" name="boardContent"><%=board.getBoardContent()%></textarea>
				</td>
			</tr>
			<tr class="form-group">
				<td class= "font-weight-bolder">boardPw</td>
				<td><input class="form-control" placeholder="Enter password" type="password" name="boardPw" ></td>
			</tr>
		</table>
		<button  class="btn btn-outline-dark" type="submit">게시글 수정</button>
	</form>
	</div>
</body>
</html>