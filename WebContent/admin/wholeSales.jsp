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
</head>
<body>
	<%@ include file="common/_top.jspf" %>

	<div class="container">
		<div class="row" style="margin-top: 70px">
			<div class="col-md-offset-1 col-md-8"><h3>전체 주문이력 조회</h3></div>
			<div class="col-md-2" align="right">
				<a href="../control/fileController"><button class="btn btn-primary" type="button">
					<i class="glyphicon glyphicon-save"></i>&nbsp;&nbsp;.CSV</button></a>
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-12"><hr></div>
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="panel panel-primary">
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
						<tr align="center">
							<td colspan="5">
							<c:set var="pageArray" value="${requestScope.pageArray}"/>
								<nav>
								  <ul class="pagination">
								    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
										<c:forEach var="page" items="${pageArray}">
											<c:choose>
												<c:when test="${currentPage == page}">
													<li class="active"><a href="#">${page}<span class="sr-only">(current)</span></a></li>
												</c:when>
												<c:otherwise>
													<li><a href="../control/adminControl.jsp?action=wholeSales&page=${page}">${page}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
								    <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
								  </ul>
								</nav>
							</td>
						</tr>
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
</body>
</html>