<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="shopping.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <jsp:useBean id="pDto" class="shopping.ProductDTO"/> --%>
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
			<div class="col-md-offset-1 col-md-11"><h3>제품 상세 조회</h3></div>
			<div class="col-md-12"><hr></div>
			<c:set var="pDto" value="${requestScope.pDto}"/>
			<div class="col-md-1"></div>
			<div class="col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="panel-title">${pDto.pName}</div>
					</div>
					<div class="panel-body">
					<form action="../control/shoppingControl.jsp?action=buy" class="form-horizontal" method="POST">
						<input type="hidden" name="pId" value="${pDto.pId}">
						<input type="hidden" name="pName" value="${pDto.pName}">
						<input type="hidden" name="pUnitPrice" value="${pDto.pUnitPrice}">
						<table class="table table-default">
							<tr>
								<td class="col-md-3" rowspan="3"><img src="../img/${pDto.pImgName}" alt="${pDto.pName}"></td>
								<td class="col-md-5">${pDto.pDescription}</td></tr>
							<tr><td>가격:&nbsp;&nbsp;&nbsp;${pDto.pUnitPrice}원</td></tr>
							<tr><td>
								주문 수량:&nbsp;&nbsp;&nbsp;<select name="quantity">
									<option value="0">&nbsp;&nbsp;0&nbsp;</option>
									<option value="1" selected>&nbsp;&nbsp;1&nbsp;</option>
									<option value="2">&nbsp;&nbsp;2&nbsp;</option>
									<option value="3">&nbsp;&nbsp;3&nbsp;</option>
									<option value="4">&nbsp;&nbsp;4&nbsp;</option>
									<option value="5">&nbsp;&nbsp;5&nbsp;</option>
								</select>
							</td></tr>
							<tr align="center">
								<td colspan="2">
									<input class="btn btn-primary" type="submit" value="주문">&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="btn btn-default" type="button" onClick="history.back()"><i class="glyphicon glyphicon-chevron-left"></i>&nbsp;&nbsp;뒤로</button>
								</td>
							</tr>
						</table>
					</form>
					</div>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>