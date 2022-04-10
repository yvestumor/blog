<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<% 
	//deleteBoardForm에서 보낸 boardNo값 가져오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + " <-boardNo"); // 받은번호값 확인
	
	//deleteboardForm에서 입력한 비밀번호 받기
	String boardPw = request.getParameter("boardPw");
	System.out.println(boardPw + " <-boardPw"); // 받은 password값 확인
	
	//Form에서 넘겨진 값을 가공하기
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardPw = boardPw;
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.deleteBoard(boardNo, boardPw);
	
	
	if(row == 0) { //삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath() +"/board/deleteBoardForm.jsp?boardNo="+board.boardNo);
	} else if(row == 1) { //삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	} else { //실패도 성공도 아닐떄?
		System.out.println("알수없는 에러");
	}

	
%>
