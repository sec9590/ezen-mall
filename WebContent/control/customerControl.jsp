<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="cDto" class="customer.CustomerDTO"/>
<jsp:setProperty name="cDto" property="*"/>
<jsp:useBean id="cDao" class="customer.CustomerDAO"/>
<%
	String action = request.getParameter("action");	// 컨트롤러 요청 action 코드값
	String cId;
	switch(action) {
	case "register":			// 회원 가입
		cDao.addCustomer(cDto);
		cId = cDao.getLastId();
		cDto.setcId(cId);
		response.sendRedirect("../view/loginForm.jsp?cId=" + cId);
		break;
	case "login":
		cId = cDto.getcId();
 		if (cDao.verifyIdPassword(Integer.parseInt(cId), cDto.getcPassword()) == cDao.ID_PASSWORD_MATCH) {
			session.setAttribute("sessionCustomerId", cId);
			cDto = cDao.getOneCustomer(cId);
			session.setAttribute("sessionCustomerName", cDto.getcName());
		}
		response.sendRedirect("../control/shoppingControl.jsp?action=view&category=30001");
		break;
	case "logout":
		session.removeAttribute("sessionCustomerId");
		session.removeAttribute("sessionCustomerName");
		session.removeAttribute("sessionOrderSet");
		response.sendRedirect("../view/index.jsp");
		break;
	default:
	}
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