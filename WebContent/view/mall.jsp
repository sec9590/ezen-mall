<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="shopping.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- ==================================================================== -->
	<title>Ezen Shopping Mall</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="common/_top.jspf" %>

	<div class="container">
		<div class="row" style="margin-top: 70px">
			<div class="col-md-offset-1 col-md-11"><h3>${requestScope.mallTitle}</h3></div>
			<div class="col-md-12"><hr></div>
			<c:set var="productList" value="${requestScope.productList}"/>
			<%	int count = 0; %>
			<c:forEach var="pDto" items="${productList}">
			<%	if (count % 5 == 0) {	%>
				<div class="col-md-1"></div>
			<%	} %>
				<div class="col-md-2">
					<div class="thumbnail">
						<a href="../control/shoppingControl.jsp?action=item&item=${pDto.pId}">
								<img src="../img/${pDto.pImgName}" alt="${pDto.pName}"></a>
						<div class="caption" style="text-align: center;">
							<h4>${pDto.pName}</h4>
							<p>가격: ${pDto.pUnitPrice}원<p>
						</div>
					</div>
				</div>
			<%	if (count++ % 5 == 4) { %>
				<div class="col-md-1"></div>
				<div class="col-md-12"><hr></div>
			<%	} %>
			</c:forEach>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>