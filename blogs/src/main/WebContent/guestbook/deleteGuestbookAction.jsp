<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지지않게 인코딩
	
	//deleteGuestbookForm에서 보낸 guestbookNo값 가져오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo + " < -- guestbookNo");
	
	//deleteGuestbookForm에서 입력한 비밀번호값 가져오기
	String guestbookPw = request.getParameter("guestbookPw");
	System.out.println(guestbookPw + " <-- guestbookPw");
	// 데이터값 가공하기
	Guestbook g = new Guestbook();
	g.setGuestbookNo(guestbookNo);
	g.setGuestbookPw(guestbookPw);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw); // deleteGuestbook 메소드 호출		
	
	if(row == 1) { //삭제 성공할때
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); //guestbookList로 이동
	} else if (row == 0) { //삭제 실패 할때
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo="+g.getGuestbookNo()); //deleteGuestbookForm으로이동
	} else { //알수없는 에러
		System.out.println("에러");
	}
	

%>
