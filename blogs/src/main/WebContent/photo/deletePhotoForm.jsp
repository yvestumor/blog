<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<% 
	 int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	 System.out.println(photoNo + " < --photoNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePhotoForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">사진 삭제</h1>
<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
	<table>
		<tr>
			<td>삭제할 번호</td>
			<td>
			<input class="form-control" type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td class="text-danger">비밀번호 입력</td>
			<td>
			<input class="form-control" type="password" name="photoPw" value="">
			</td>
		</tr>
	</table>
	<button class="btn btn-outline-dark"  type="submit">삭제</button>
</form>
</div>
</body>
</html>