<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); //삭제할 게시글 번호 받기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">글삭제</h1>
	<form method="post" action ="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
		<table>
			<tr>
				<td class="text-danger">삭제할 번호</td>
				<td>
				<input  class="form-control" type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly"> <!-- 번호 바꿀수없게 readonly -->
				</td>
			</tr>
			<tr>
				<td class="text-danger">비밀번호 입력</td>
				<td>
				<input class="form-control" placeholder="Enter password" type="password" name="boardPw">
				</td>
			</tr>
		</table>
		<button  class="btn btn-outline-dark" type="submit">삭제</button> 
	</form>
	</div>
</body>
</html>