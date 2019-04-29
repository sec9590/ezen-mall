<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="admin.*, shopping.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="oDto" class="shopping.OrderDTO"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- ==================================================================== -->
	<title>Ezen Shopping Mall Management</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/jquery-ui.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="common/_top.jspf" %>

	<div class="container">
		<div class="row" style="margin-top: 70px">
			<div class="col-md-offset-1 col-md-6"><h3>일단위 고객별 주문 내역 조회</h3></div>
			<div class="col-md-5">
				<form action="../control/adminControl.jsp?action=dailySales" class="form-horizontal" method="post">
					<div class="form-group">
						<label class="control-label">날짜:&nbsp;&nbsp;</label>
						<input type="text" name="dateCustomer" id="datepicker1">&nbsp;&nbsp;
						<input class="btn btn-primary btn-sm" type="submit" value="검색">
					</div>
				</form>
			</div>
			<div class="col-md-12"><hr></div>
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="panel panel-primary">
					<div class="panel-heading">
												총 주문액: ${requestScope.totalPrice} 
					</div>
					<table class="table table-striped table-condensed">
						<thead>
							<th class="col-md-2" style="text-align:center;">주문일자</th>
							<th class="col-md-2" style="text-align:center;">고객ID</th>
							<th class="col-md-2" style="text-align:center;">고객명</th>
							<th class="col-md-2" style="text-align:center;">주문번호</th>
							<th class="col-md-2" style="text-align:center;">금액</th>
						</thead>
						<tbody>
						<c:set var="dsList" value="${requestScope.dailySalesList}"/>
						<c:forEach var="dsDto" items="${dsList}">
						<tr>
							<td align="center">${dsDto.dDate}</td>
							<td align="center">${dsDto.dCustomerId}</td>
							<td align="center">${dsDto.dCustomerName}</td>
							<td align="center">${dsDto.dOrderId}</td>
							<td align="center">${dsDto.dPrice}</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery-ui.min.js"></script>
	<script>
	    $.datepicker.setDefaults({
	        dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년'
	    });
	    $(function() {
	        $("#datepicker1").datepicker();
	    });
	</script>
</body>
</html>