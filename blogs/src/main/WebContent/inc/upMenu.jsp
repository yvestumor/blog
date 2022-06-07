<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로 사용되는 페이지 -->
<div>
		<a   class="btn btn-outline-warning" href="<%=request.getContextPath()%>/index.jsp">홈으로</a>
		<a   class="btn btn-outline-warning"href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
		<a   class="btn btn-outline-warning"href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a>
		<a   class="btn btn-outline-warning"href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>
</div>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>

</body>
</html>