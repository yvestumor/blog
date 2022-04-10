<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%@ page import ="java.util.*"%>
<%@ page import ="dao.*" %>
<% 
 int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println(photoNo + " <-- 선택한사진 번호");

	PhotoDao photoDao = new PhotoDao();
	ArrayList <Photo> list = photoDao.selectPhotoOne(photoNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">사진 상세보기</h1>
	<br>
	<table class="table table-bordered">
		<% 
			for(Photo p : list) {
		%>
		<img class="mx-auto d-block" src="<%=request.getContextPath()%>/upload/<%=p.getPhotoName()%>">
		<tr class="table-info">
			<th>photoNo</th>
			<td><%=p.getPhotoNo()%></td>
		</tr>
		<tr>
			<th>photoName</th>
			<td><%=p.getPhotoName()%></td>
		</tr>
		<tr>
			<th>writer</th>
			<td><%=p.getWriter()%></td>
		</tr>
		<tr>
			<th>createDate</th>
			<td><%=p.getCreateDate()%></td>
		</tr>
		<tr>
			<th>updateDate</th>
			<td><%=p.getUpdateDate()%></td>
		</tr>
		<% 		
			}
		%>
	</table>
	<a type="button"   class="btn btn-outline-dark" href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photoNo%>">사진삭제</a>
	<a type="button"   class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/photo/updatePhotoForm.jsp?photoNo=<%=photoNo%>">사진수정</a>
	</div>
</body>
</html>