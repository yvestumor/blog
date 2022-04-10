<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import ="java.io.File" %>
<%@ page import= "vo.*" %>
<%@ page import="dao.*" %>
<%
	//insertPhotoAction.jsp
	/*
	form태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다.
	String writer = request.getParameter("writer");
	System.out.println(writer);
	request.getParameter() API 대신 다른 API를 사용해야하는 데 너무 복잡하다
	--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브러리) 를 사용
	
	*/
	
	request.setCharacterEncoding("utf-8");
	//DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	String path = application.getRealPath("upload"); //application 변수 : 톰켓을 가르키는 변수
	System.out.println(path + " <--사진 파일 주소");
	
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100,"utf-8", new DefaultFileRenamePolicy());
	//2^10 byte = 1 kbyte 1024 byte = 1kbte
	//2^10 kbyte = 1mbyte
	//100 mbyte = 1024*1024*100 byte = 104857600 byte
	
	String photoPw = multiReq.getParameter("photoPw");
	System.out.println(photoPw + " <--photoPw");
	
	String  writer = multiReq.getParameter("writer");
	System.out.println(writer + " <--writer");
	
	//<input type="file" name="photo"> 
	String photoOriginalName = multiReq.getOriginalFileName("photo");
	System.out.println(photoOriginalName +" <--photoOriginalName");
	
	String photoName = multiReq.getFilesystemName("photo"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	System.out.println(photoName + " <--photoName");
	
	String photoType = multiReq.getContentType("photo");
	System.out.println(photoType + " <--photoType");
	
	// 파일 업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		// db에 저장
		System.out.println("dbㄱㄱ");
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer);
		
		photoDao.insertPhoto(photo); // 메소드  구현
		response.sendRedirect(request.getContextPath() +"/photo/photoList.jsp");
		
	} else {
		// 업로드 취소
		System.out.println("이미지 파일만 업로드 해주세요");
		// 잘못 들어온 파일이므로 업로드된 파일 지우고 폼으로 이동
		File file = new File(path + "\\"+photoName); // 잘못된 파일 불러오기. /
		file.delete();
		response.sendRedirect(request.getContextPath() + "/photo/insertPhotoForm.jsp");
	}
	
%>