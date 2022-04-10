<%@page import="org.apache.tomcat.util.http.fileupload.RequestContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<% 
	request.setCharacterEncoding("utf-8"); //한글이 꺠지지 않게 인코딩
	
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); //guestbookNo값 받아오기
	System.out.println(guestbookNo + " <-- guestbookNo");
	
	String guestbookContent = request.getParameter("guestbookContent"); //guestbookContent값 받아오기
	System.out.println(guestbookContent + " <--guestbookContent");
	
	String guestbookPw = request.getParameter("guestbookPw"); //guestbookPw 값 받아오기
	System.out.println(guestbookPw + " <--guestbookPw");
	
	//데이터값 가공하기
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookNo = guestbookNo;
	guestbook.guestbookContent = guestbookContent;
	guestbook.guestbookPw = guestbookPw;
	
	GuestbookDao guestbookDao = new GuestbookDao(); 
	int row = guestbookDao.updateGuestbook(guestbook); //updateGuestbook메소드 호출
	
	if(row == 1) { //수정성공했을때
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else if (row == 0) { //수정실패할때
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestNo="+guestbook.guestbookNo);
	} else {// 알수없는 에러
		System.out.println("에러");
	}
	
%>
