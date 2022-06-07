<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 깨지지 않게
	
	//insertBoardForm에서 보낸값 받기
	String categoryName =request.getParameter("categoryName"); //insertBoardForm에서 categoryName 값 받기
	System.out.println(categoryName + " <--categoryName"); // categoryName확인
	
	String boardTitle = request.getParameter("boardTitle"); //insertBoardForm에서 boardTitle 값 받기
	System.out.println(boardTitle + " <--boardTitle"); // boardTitle 확인
	
	String boardContent = request.getParameter("boardContent"); //insertBoardForm에서 boardContent값 받기
	System.out.println(boardContent +" <--boardContent"); // boardContent 확인
	
	String boardPw = request.getParameter("boardPw"); //insertBoardForm에서 boardPw 값 받기
	System.out.println(boardPw + " <--boardPw"); // 비밀번호 확인
	
	// insertBoardFrom에서 받은값 변수로 저장
	Board board = new Board();
	board.setCategoryName(categoryName);//categoryName 
	board.setBoardTitle(boardTitle); //boardTitle
	board.setBoardContent(boardContent); // boardContent
	board.setBoardPw(boardPw); //boardPw
	
	
	BoardDao boardDao = new BoardDao(); // boardDao호출 
	
	boardDao.insertBoard(board); 
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>