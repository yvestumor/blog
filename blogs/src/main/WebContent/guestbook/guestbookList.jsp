<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
   int currentPage = 1;
   if(request.getParameter("currentPage") != null) {
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
   }
   int rowPerPage = 5;
   int beginRow = (currentPage-1)*rowPerPage;
   GuestbookDao guestbookDao = new GuestbookDao();
   ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
   
   int lastPage = 0;
   int totalCount = guestbookDao.selectGuestbookTotalRow();
   /*
   lastPage = totalCount / rowPerPage;
   if(totalCount % rowPerPage != 0) {
      lastPage++;
   }
   */
   lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); //Math.ceil 올림
   // 4.0 / 2.0 = 2.0 -> 2.0
   // 5.0 / 2.0 = 2.5 -> 3.0
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 매뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다 -->
	<!-- 메인 메뉴 끝 -->
<% 
   for(Guestbook g : list) {
%>
      <table class="table table-bordered">
         <tr class="table-info">
            <td><%=g.getWriter()%></td>
            <td><%=g.getCreateDate()%></td>
         </tr>
         <tr class="table-warning">
            <td colspan="2"><%=g.getGuestbookContent()%></td>
         </tr>
      </table>
      <div>
      	<a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">수정</a>
      	<a  class="btn btn-outline-primary" href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">삭제</a>
      </div>
<%   
   }
   
   if(currentPage > 1) {
%>
      <a   class="btn btn-outline-danger" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%      
   }
   
   if(currentPage < lastPage) {
%>
      <a   class="btn btn-outline-danger" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
   }
%>
   <!--  방명록 입력 -->
   <form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
   		 <table class ="table-striped">
         <tr>
            <td  class ="font-weight-bolder">글쓴이</td>
            <td  class ="font-weight-bolder"><input class="form-control" type ="text" name="writer"></td>
            <td class ="font-weight-bolder">비밀번호</td>
            <td><input class="form-control" placeholder="Enter password" type="password" name="guestbookPw"></td>
         </tr>
         <tr>
            <td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
         </tr>
      </table>
      <button  class="btn btn-outline-dark"  type="submit">등록</button>
   </form>
</body>
</html>







