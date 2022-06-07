	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import ="dao.*" %>
<% 
	//클릭한 보드 번호 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // category선택한 보드 번호 받기
	System.out.println(boardNo + " <-- boardNo"); //디버깅
	
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	board = boardDao.selectBoardOne(boardNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
	<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">상세보기</h1>
	<table class="table table-bordered">
				<tr class="table-info">
					<th>boardNo</th>
					<td><%=board.getBoardNo()%></td>
				</tr>
				<tr class="table-warning">
					<th>categoryName</th>
					<td><%=board.getCategoryName()%></td>
				</tr>
				<tr class="table-warning">
					<th>boardTitle</th>
					<td><%=board.getBoardTitle()%></td>
				</tr>
				<tr class="table-warning">
					<th>boardContent</th>
					<td><%=board.getBoardContent()%></td>
				</tr>
				<tr  class="table-warning">
					<th>createDate</th>
					<td><%=board.getCreateDate()%></td>
				</tr>
				<tr  class="table-warning">
					<th>updateDate</th>
					<td><%=board.getUpdateDate()%></td>
				</tr>
	</table>
	<!--request.getContextPath() -> 프로잭트 path만 가져온다  -->
	<a type="button" class="btn btn-outline-dark" href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>">게시글 삭제</a>
	<a type="button" class="btn btn-outline-dark" href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>">게시글 수정</a>
	<a type="button" class="btn btn-outline-dark" href="<%=request.getContextPath()%>/board/boardList.jsp">카테고리 메뉴로 돌아가기</a>
</div>
</body>
</html>