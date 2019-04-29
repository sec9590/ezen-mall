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
			<div class="col-md-offset-1 col-md-11"><h3>장바구니 조회</h3></div>
			<div class="col-md-12"><hr></div>
			<div class="col-md-1"></div>
			<div class="col-md-9">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="panel-title">${sessionCustomerName} 님이 이번에 주문할 내용입니다.</div>
					</div>
					<div class="panel-body">
						총 금액:&nbsp;&nbsp;&nbsp;${requestScope.sum}원
					</div>
					<table class="table table-striped">
						<thead>
							<th class="col-md-1" style="text-align:center;">번호</th>
							<th class="col-md-3">상품명</th>
							<th class="col-md-1">수량</th>
							<th class="col-md-2">단가</th>
							<th class="col-md-2">금액</th>
						</thead>
						<tbody>
						<c:set var="detailOrderList" value="${requestScope.detailOrderList}"/>
						<c:forEach var="doDto" items="${detailOrderList}">
						<tr>
							<td style="text-align:center;">${doDto.dNumber}</td>
							<td>${doDto.dProductName}</td>
							<td>${doDto.dQuantity}</td>
							<td>${doDto.dUnitPrice}</td>
							<td>${doDto.dPrice}</td>
						</tr>
						</c:forEach>
						<tr align="center">
							<td colspan="5">
								<button class="btn btn-primary" type="button" onClick="location.href='../control/shoppingControl.jsp?action=final'">&nbsp;확정&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn btn-default" type="button" onClick="history.back()"><i class="glyphicon glyphicon-chevron-left"></i>&nbsp;&nbsp;뒤로</button>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>