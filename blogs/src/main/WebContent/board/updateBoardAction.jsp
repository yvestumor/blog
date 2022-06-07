<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.BoardDao"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글이 깨지지 않게 인코딩
	
	//updateBoardForm에서 넘어온 값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // updateBoardForm에서 넘어온 boardNo값
	System.out.println(boardNo + "<--넘어온 BoardNo값(update)"); //디버깅
	
	String categoryName = request.getParameter("categoryName"); //updateBoardForm에서 넘어온 categoryName값
	System.out.println(categoryName + "<--넘어온categoryName값(update)");
			
	String boardTitle = request.getParameter("boardTitle"); //updateBoardForm에서 넘어온 boardTitle값
	System.out.println(boardTitle + "<--넘어온boardTitle값(update)");
	
	String boardContent = request.getParameter("boardContent"); //updateBoardForm에서 넘어온 boardContent값
	System.out.println(boardContent +"<--넘어온boardContent값(update)");
	
	String boardPw = request.getParameter("boardPw"); //updateBoardForm에서 넘어온 boardPw값
	System.out.println(boardPw +"<--넘어온boardPw(update)");
	
	//넘어온값 가공하기
	Board board = new Board();
	board.setBoardNo(boardNo); //boardNo -> board.boardNo
	board.setCategoryName(categoryName); //categoryName -> board.categoryName
	board.setBoardTitle(boardTitle); // boardTitle -> board.boardTitle
	board.setBoardContent(boardContent); //boardContent -> board.boardContent
	board.setBoardPw(boardPw); //boardPw -> board.boardPw
	
	BoardDao boardDao = new BoardDao();
	
	int row = boardDao.updateBoard(board);
	if (row == 1) {
		System.out.println("Board 수정 성공 ");
		response.sendRedirect(request.getContextPath() +"/board/boardOne.jsp?boardNo="+boardNo);
	} else {
		System.out.println("Board 수정 실패");
		response.sendRedirect(request.getContextPath() +"/board/updateBoardForm.jsp?boardNo="+boardNo);
	}
	
%>
