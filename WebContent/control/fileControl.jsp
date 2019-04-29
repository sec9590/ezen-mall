<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.*, customer.*, shopping.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<!-- Do not use this controller. Use Servlet controller -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="aDao" class="admin.AdminDAO"/>
<%
	OutputStream os = null;
	FileInputStream fis = null;
	BufferedOutputStream bos = null;
	BufferedInputStream bis = null;
	String client = request.getHeader("User-Agent");
	String sb = aDao.prepareDownload();
	int length;
	
	// 파일 다운로드 헤더 지정
	response.reset() ;
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Description", "JSP Generated Data");
	
	if(client.indexOf("MSIE") != -1) {		// Internet Explorer
		response.setHeader ("Content-Disposition", "attachment; filename=Whole Sales.csv");
	} else {			// IE 이외
		response.setHeader("Content-Disposition", "attachment; filename=\"Whole Sales.csv\"");
		response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
	} 
	File file = new File("D:/Workspace/Temp/Whole Sales.csv");
	response.setHeader ("Content-Length", "" + file.length());
	//Writer writer = response.getWriter();
	try {
		//out.clear();
		//out = pageContext.pushBody();
		fis = new FileInputStream(file);
		bis = new BufferedInputStream(fis);
		bos = new BufferedOutputStream(response.getOutputStream());
		byte[] bytes = new byte[1024];
		while ((length = bis.read(bytes)) != -1) {
			System.out.println("Length = " + length);
			bos.write(bytes, 0, length);
		}
		bos.flush();
		//bos.close();
		bis.close();
		fis.close();
	} catch (Exception e) {
		//e.printStackTrace();
		System.out.println(e.getMessage());
	}
	System.out.println("fileControl.jsp: After try");	
	//response.sendRedirect("../control/adminControl.jsp?action=download");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>