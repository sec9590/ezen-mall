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
			<div class="col-md-offset-1 col-md-11"><h3>고객별 주문이력 조회</h3></div>
			<div class="col-md-12"><hr></div>
			<div class="col-md-1"></div>
			<div class="col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<c:set var="cDto" value="${requestScope.customerDto}"/>
						<div class="panel-title">고객명: ${cDto.cName}(${cDto.cId})</div>
					</div>
					<table class="table table-striped">
						<thead>
							<th class="col-md-2">주문번호</th>
							<th class="col-md-3">주문일자</th>
							<th class="col-md-2">금액</th>
						</thead>
						<c:set var="orderList" value="${requestScope.orderList}"/>
						<c:forEach var="oDto" items="${orderList}">
						<tr>
							<td><a href="../control/adminControl.jsp?action=detail&orderId=${oDto.oId}">${oDto.oId}</a></td>
							<td>${oDto.oDate}</td>
							<td>${oDto.oPrice}</td>
						</tr>
						</c:forEach>
						<tr align="center">
							<td colspan="3">
								<a class="btn btn-primary" href="#" onClick="history.back()" role="button">
									<i class="glyphicon glyphicon-chevron-left"></i>&nbsp;&nbsp;뒤로</a>
							</td>
						</tr>
					</table>
					<div class="panel-footer">
						구매한 상품내역을 조회하려면 주문번호를 클릭하세요.
					</div>
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