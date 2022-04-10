<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int beginRow = 0;
	int rowPerPage = 10;

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 시작-->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<div class="container">
	<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<br>
	<h1 class="display-4">이미지 목록</h1>
	<a  type="button" class="btn btn-outline-danger text-danger" href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">사진 등록</a>
	<table class="table table-light table-secondary table-bordered">
		<tr>
			<%
				// 한행의 5개의 이미지 출력(tr안에 td가 5개)
				// 이미지가 3개  - tr 1 - td 5
				// 이미지가 5개  - tr 1 - td 5
				// 이미지가 10개 - tr 2 - td 10
				// 이미지가 9개  - tr 2 - td 10 
				
				// td의 갯수 5의 배수가 되도록
				// list.size()가 1~5 - td는 5개
				// list.size()가 6~10 - td는 10개
				System.out.println(list.size() + " <- list.size()");
			
				int endIdx = (((list.size()-1)/5)+1)*5; // 5의 배수가 되어야 한다.(한줄에 5개씩 출력하기로...)
				System.out.println(endIdx+" <-- 10");
				
			//	for(Photo p : list) { // size()만큼 반복되므로 5의배수가 아닐 수도 있다. 
				for(int i=0; i<endIdx; i++) { // 01234, 0123456789
					// tr을 닫고 새로운 tr 시작
					if(i!=0 && i%5==0) { // 5일때(0을 제외한 5의배수일때) 
			%>
						</tr><tr>
			<%			
					}
				
					if(i<list.size()) {
			%>
						<td>
							<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
								<img class="img-thumbnail" src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="100" height="100">
								<!--  상세보기에서는 원본이미지 크기로 -->
							</a>
						</td>
			<%
					} else {
			%>
						<td>&nbsp;</td>
			<%			
					}
				}
			%>
		</tr>
	</table>
	</div>
</body>
</html>
