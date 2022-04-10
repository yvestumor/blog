<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<% 
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); //입력한 값 받아오기
	System.out.println(guestbookNo + " <-- 수정guestbookNo");
	
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao. selectGuestbookOne(guestbookNo); // selectGuestbookOne 메소드 호출
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">방명록 수정</h1>
<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
	<table class ="table-striped">
		<tr>
			<td  class ="font-weight-bolder">guestbookNo</td>
			<td><input class="form-control" type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td class ="font-weight-bolder">guestbookContent</td>
			<td><textarea class="form-control" name="guestbookContent" rows="2" cols="60" ></textarea></td>
		</tr>
		<tr>
			<td>guestbookPw</td>
			<td><input type="password"  placeholder="Enter password" name="guestbookPw"></td>
		</tr>
	</table>
	<button  class="btn btn-outline-dark" type="submit">방명록 수정</button>
</form>
</div>
</body>
</html>