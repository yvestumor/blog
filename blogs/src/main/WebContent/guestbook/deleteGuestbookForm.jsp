<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); //삭제할 방명록 번호
 System.out.println(guestbookNo + "<-- guestbookNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<h1 class="display-1 bg-danger">Blog</h1>
<h1 class="display-4">방명록 삭제</h1>
<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
	<table class ="table-striped">
		<tr>
			<td class ="font-weight-bolder">삭제할 번호</td>
			<td>
			<input class="form-control" type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly ="readonly">
			</td>
		</tr>
		<tr>
			<td>비밀번호 입력</td>
			<td>
			<input class="form-control" placeholder="Enter password" type="password" name="guestbookPw" value="">
			</td>
		</tr>
	</table>
	<button  class="btn btn-outline-dark" type="submit">삭제</button> 
</form>
</body>
</html>