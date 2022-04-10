<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import ="java.io.*" %>
<% 
	// 1) 테이블 데이터 삭제 <- photoNo 필요
	// 2) upload폴더에 이미지 삭제 <-photoName

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	
	PhotoDao photoDao = new PhotoDao();
	
	String photoName = photoDao.selectPhotoName(photoNo);
	
	// 1)테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo,photoPw);
	
	// 2) 폴더 이미지 삭제
	if(delRow == 1) { //삭제 성공
		System.out.println("삭제성공");
		String path = application.getRealPath("upload"); //application(현재 프로젝트)안에 upload폴더의 실제 폴더경로를 
		File file = new File(path + "\\"+photoName); // 이미지 파일 불러오기. 
		file.delete(); //이미지삭제
	} else {
		System.out.println("삭제실패");
	}

	
	
%>
