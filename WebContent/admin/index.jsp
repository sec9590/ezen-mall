<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
		<div class="row" style="margin-top: 90px">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="jumbotron">
					<p><h2>이젠 쇼핑몰</h2></p>
					<p><h5>관리자 페이지입니다.</h5></p>
				</div>
			</div>
			<div class="col-md-1"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
			
					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="../img/ArduinoUno.jpg" alt="아두이노 우노">
							<!-- <div class="carousel-caption">우노</div> -->
						</div>
						<div class="item">
							<img src="../img/ArduinoDue.jpg" alt="아두이노 듀에">
							<!-- <div class="carousel-caption">듀에</div> -->
						</div>
						<div class="item">
							<img src="../img/ArduinoMega2560.jpg" alt="아두이노 메가2560">
							<!-- <div class="carousel-caption">트레</div> -->
						</div>
					</div>
			
					<!-- Controls -->
					<a class="left carousel-control" href="#myCarousel"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<div class="col-md-1"></div>
		</div>
	</div>

	<%@ include file="common/_bottom.jspf" %>
	<!-- ==================================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>