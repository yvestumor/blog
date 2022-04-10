<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoForm.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<br>
<h1 class="display-1 bg-danger">Blog</h1>
	<h1 class="display-4">이미지 등록</h1>
	<!-- 
	1)form태그안에 값을 넘기는 기본값은 문자열이다
	2) 파일을 넘길 수 없다. 기본값(application/x-www-form-urlencoded)을 변경해야한다 
	3) 기본값을 multipart/form-dataㄹ 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다.
	4) 같은 폼안에 모든 값이 바이너리로 넘어간다. 글자를 넘겨받는 request.getParameter();를사용할 수없다.
	5) 복잡한다 코드를 통해서만 바이너리에 내용을 넘겨 받을 수 있다.
	6) 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현.
	
	-->
	<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td class="text-danger">이미지파일</td>
				<td><input  class="form-control-file border" type="file" name="photo"></td>
			</tr>
			<tr>
				<td class="text-danger">비밀번호</td>
				<td><input class="form-control" type ="password" name="photoPw"></td>
			</tr>
			<tr>
				<td class="text-danger">글쓴이</td>
				<td><input  class="form-control" type="text" name="writer"></td>
			</tr>
		</table>
		<button class="btn btn-outline-dark" type="submit">이미지 등록</button>
	</form>
	</div>
</body>
</html>