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
	<title>Ezen Shopping Mall Management</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="common/_top.jspf" %>

	<div class="container">
		<div class="row" style="margin-top: 70px">
			<div class="col-md-offset-1 col-md-11"><h3>고객목록 조회</h3></div>
			<div class="col-md-12"><hr></div>
			<div class="col-md-1"></div>
			<div class="col-md-8">
				<div class="panel panel-primary">
					<table class="table table-striped">
						<thead>
							<th class="col-md-2">고객ID</th>
							<th class="col-md-2">고객명</th>
							<th class="col-md-2">Email</th>
							<th class="col-md-2">연락처</th>
						</thead>
						<c:set var="customerList" value="${requestScope.customerList}"/>
						<c:forEach var="cDto" items="${customerList}">
						<tr>
							<td><a href="../control/adminControl.jsp?action=dailyByCustomer&customerId=${cDto.cId}">${cDto.cId}</a></td>
							<td>${cDto.cName}</td>
							<td>${cDto.cEmail}</td>
							<td>${cDto.cTel}</td>
						</tr>
						</c:forEach>
					</table>
					<div class="panel-footer">고객별 구매하신 상품내역을 조회하려면 고객ID를 클릭하세요.</div>
				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>