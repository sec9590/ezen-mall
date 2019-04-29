<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.*, customer.*, shopping.*, java.util.*, java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="cDto" class="customer.CustomerDTO"/>
<jsp:useBean id="cDao" class="customer.CustomerDAO"/>
<jsp:useBean id="oDto" class="shopping.OrderDTO"/>
<jsp:useBean id="oDao" class="shopping.OrderDAO"/>
<jsp:useBean id="aDao" class="admin.AdminDAO"/>
<%
	ArrayList<CustomerDTO> customerList = null;
	ArrayList<DetailOrderDTO> detailOrderList = null;
	ArrayList<DailySalesDTO> dailySalesList = null;
	ArrayList<InventoryDTO> inventoryList = null;
	String customerId = null;
	int currentPage;
	String totalPrice = null;
	String date = null;
	SimpleDateFormat mySdf;
	Date today;
	
	String action = request.getParameter("action");	// 컨트롤러 요청 action 코드값
	switch(action) {
	case "listCustomer":			// 고객 목록 조회
		customerList = cDao.getAllCustomers();
		request.setAttribute("customerList", customerList);
		pageContext.forward("../admin/customerList.jsp");
		break;
	case "dailyByCustomer":		// 고객단위 일별 주문 내역
		customerId = request.getParameter("customerId");
		cDto = cDao.getOneCustomer(customerId);
		ArrayList<OrderDTO> orderList = oDao.getOrdersByCustomer(customerId);
		request.setAttribute("customerDto", cDto);
		request.setAttribute("orderList", orderList);
		pageContext.forward("../admin/showHistoryByCustomer.jsp");
		break;
	case "detail":				// 구매한 상품내역
		String orderId = request.getParameter("orderId");
		oDto = oDao.getOneOrder(orderId);
		detailOrderList = oDao.getDetailOrders(orderId);
		request.setAttribute("detailOrderList", detailOrderList);
		request.setAttribute("oDto", oDto);
		pageContext.forward("../admin/detailOrders.jsp");
		break;
	case "wholeSales":				// 전체 주문이력 - 일단위, 페이지 처리
		int totalPage = aDao.getTotalPage();
		String pageArray[] = new String[totalPage];
		for (int i=0; i<totalPage; i++)
			pageArray[i] = Integer.toString(i+1);
		currentPage = Integer.parseInt(request.getParameter("page"));
		request.setAttribute("currentPage", Integer.toString(currentPage));
		dailySalesList = aDao.getAllDailySales(currentPage);
		request.setAttribute("pageArray", pageArray);
		request.setAttribute("dailySalesList", dailySalesList);
		pageContext.forward("../admin/wholeSales.jsp");
		break;
	case "dailySales":		// 일단위 고객별 주문 내역
		date = request.getParameter("dateCustomer");
		if (date == null) {
			mySdf = new SimpleDateFormat("yyyy-MM-dd");
			today = new Date();
			date = mySdf.format(today);
		}
		dailySalesList = aDao.getDailySales(date);
		totalPrice = aDao.getDailyTotalPrice(dailySalesList);
		request.setAttribute("totalPrice", totalPrice + "원");
		request.setAttribute("dailySalesList", dailySalesList);
		pageContext.forward("../admin/dailySales.jsp");
		break;
	case "inventory":			// 판매된 상품 내역
		inventoryList = aDao.getInventory();
		totalPrice = aDao.getTotalPrice(inventoryList);
		request.setAttribute("dateInventory", "2018-10-01 ~ 현재");
		request.setAttribute("totalPrice", totalPrice + "원");
		request.setAttribute("inventoryList", inventoryList);
		pageContext.forward("../admin/inventory.jsp");
		break;
	case "dailyByProduct":		// 일단위 상품별 주문 내역
		date = request.getParameter("dateInventory");
		if (date == null) {
			mySdf = new SimpleDateFormat("yyyy-MM-dd");
			today = new Date();
			date = mySdf.format(today);
		}
		inventoryList = aDao.getInventoryByDate(date);
		totalPrice = aDao.getTotalPrice(inventoryList);
		request.setAttribute("dateInventory", date);
		request.setAttribute("totalPrice", totalPrice + "원");
		request.setAttribute("inventoryList", inventoryList);
		pageContext.forward("../admin/inventory.jsp");
		break;
	case "download":			// .csv 파일 다운로드 완료후 이동 제어
		request.setAttribute("message", "파일이 다운로드되었습니다.");
		request.setAttribute("url", "../control/adminControl.jsp?action=wholeSales&page=1");
		pageContext.forward("../admin/alertMsg.jsp");
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