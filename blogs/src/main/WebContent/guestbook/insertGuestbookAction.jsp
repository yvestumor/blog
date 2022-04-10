<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 깨지지않게 인코딩


	
	//값 받아오기
	String guestbookContent = request.getParameter("guestbookContent"); // 방명록 내용
	System.out.println(guestbookContent + "<-guestbookContent");
	
	String writer = request.getParameter("writer"); // 작성자
	System.out.println(writer + "<-writer");
	
	String guestbookPw = request.getParameter("guestbookPw"); //비번
	System.out.println(writer + "<-guestbookPw");
	
	
	//요청값 가공해서 변수 만들기
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookContent = guestbookContent;
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook); // insertGuestbook 메소드 호출		
	
	
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // guestbookList로 돌아감
	
%>