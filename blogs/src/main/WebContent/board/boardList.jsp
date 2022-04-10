<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	

	// boardList페이지 실행하면 최근 10개의 목록을 보여주고 1page로 설정
	int currentPage = 1; // 현재 페이지 기본값

	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "  <-- currentPage");
	
	String categoryName = request.getParameter("categoryName");
	
	
	
	// 페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
	/*
		알고리즘
		SELECT .... LIMIT ?, 10
		
		currentPage	beginRow
		1			0
		2			10
		3			20
		4			30
		
		? <--- (currentPage - 1) * 10
	*/
	int rowPerPage = 10; // rowPerPage은 한 페이지에 내가 보고 싶은 글 수 (한 행에 10개씩 보고 싶다.)
	int beginRow = (currentPage - 1) * rowPerPage; // 현재 페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
	
	//String categoryName = request.getParameter("categoryName");	

	ArrayList<HashMap<String, Object>> categoryList = categoryDao.categoryList(categoryName);
	ArrayList<Board> list = boardDao.selectBoardListByPage(beginRow, rowPerPage, categoryName);
	/*
		SELECT category_name categoryName, COUNT(*) cnt
		FROM board
		GROUP BY category_name
	*/

	
	
	int totalRow = 0; // select count(*) from board; -> 전체 행의 개수
	totalRow = boardDao.selectBoardTotalRow();
	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- category별 게시글 링크 메뉴 -->
	<div class="container">
	<br>
	<h1 class="display-1 bg-danger">Blog</h1>
	<br>
		<div class = "row">
			<div class = "col-sm-2 bg-light">
				<ul class="list-group">
				<br>
					<li class="list-group-item">메뉴</li>
					<%
					for(HashMap<String, Object> m : categoryList) {
					%>
							<li>  	 <!-- request.getContextPath()는 프로젝트 제목 ex) blog를 가져온다 -->
								<a class="list-group-item list-group-item-action" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%><span class="badge badge-danger"><%=m.get("cnt")%></span></a>
							</li>
					<%		
						}
					%>
				</ul>
			</div>
	<!-- 게시글 리스트 -->
	<div class = "col-sm-8 bg-Secondary">
	<div class="container p-3 my-3 bg-success text-light">
	<h1 class="display-4">게시글 목록</h1>
	<p>글 개수 :<%=totalRow%></p>
	</div>
		<a  type="button" class="btn btn-outline-danger text-danger" href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글 입력</a>
		<br>
	<table class="table table-light table-secondary table-bordered">
		<thead class ="table table-success">
			<tr>
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
					<tr>
						<td><%=b.getCategoryName()%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
						<td><%=b.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
			
		</tbody>
	</table>
</div>
	</div>

	<div>
		
		<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지,다음을 누르면 11페이지 -->
		<% 
			if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서안됨.
		%>
		<a type="button" class="btn btn-outline-danger" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<% 		
			}
		%>
		
		<!-- 
		전체행  	마지막 페이지 ?
		10개	 	1
		11~20개 	2
		21~30개	3
		
		마지막 페이지  = 전체행 / rowPerPage
		 -->
		<% 
			if(currentPage < lastPage) {
		%>
			
			<a type="button" class="btn btn-outline-danger" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>
		<% 		
			}
		%>
				</div>
				<br>
			</div>
</body>
</html>