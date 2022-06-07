<%@page import="javax.sound.sampled.AudioFormat.Encoding"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.CategoryDao" %>
<%@ page import="vo.*" %>
<% 
	request.setCharacterEncoding("utf-8");

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<String> list = categoryDao. selectCategory();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<br>
<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">글입력</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
		<table class ="table-striped">
			<tr>
				<td class ="font-weight-bolder">categoryName</td>
				<td>
					<select class="custom-select" name="categoryName">
						<% 
							for(String s : list) { //카테고리 선택
						%>		
								<option value="<%=s%>"><%=s%></option>	
						<% 		
							}
						%>
					</select>
				</td>
			</tr>
			<tr class="form-group">
				<td class ="font-weight-bolder">boardTitle</td> <!-- board제목 -->
				<td>
				<input class="form-control" name="boardTitle" type="text">
				</td>
			</tr>
			<tr class="form-group">
				<td class ="font-weight-bolder">boardContent</td> <!-- board 글 -->
				<td>
				<textarea class="form-control" name="boardContent" rows="10" cols="100"></textarea>
				</td>
			</tr>
			<tr class="form-group">
				<td class ="font-weight-bolder">boardPw</td> <!-- board비밀번호 -->
				<td>
					<input  class="form-control" placeholder="Enter password" name="boardPw" type="password">
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<button  class="btn btn-outline-dark" type="submit">입력</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>