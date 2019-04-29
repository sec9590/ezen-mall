<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cId = request.getParameter("cId");
	if (cId != null)
		out.println("<script>alert('고객님께서 사용하실 ID는 " + cId + " 입니다.');</script>");
%>
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
		<div class="row" style="margin-top: 90px">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="jumbotron">
					<p><h2>로그인</h2></p>
					<p><h5>이젠 쇼핑몰을 이용하려면 로그인을 해주세요.</h5></p>
				</div><br><br>
				<form action="../control/customerControl.jsp?action=login" class="form-horizontal" method="POST" onSubmit="return isValidLogin();">
					<div class="form-group">
						<label class="col-md-4 control-label">아이디</label>
						<div class="col-md-3">
						<% if (cId != null) { %>
							<input type="text" class="form-control" name="cId" id="cId" placeholder="<%=cId%>">
						<% } else { %>
							<input type="text" class="form-control" name="cId" id="cId">
						<% } %>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">패스워드</label>
						<div class="col-md-3">
							<input type="password" class="form-control" name="cPassword" id="c_password">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-offset-4 col-md-6">
							<input class="btn btn-primary" type="submit" value="로그인">&nbsp;
							<button class="btn btn-default" type="reset" type="button">취소</button>
						</div>
					</div>
				</form>
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