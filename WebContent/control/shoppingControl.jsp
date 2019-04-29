<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shopping.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="oDto" class="shopping.OrderDTO"/>
<jsp:useBean id="oDao" class="shopping.OrderDAO"/>
<jsp:useBean id="doDto" class="shopping.DetailOrderDTO"/>
<jsp:useBean id="pDto" class="shopping.ProductDTO"/>
<jsp:useBean id="pDao" class="shopping.ProductDAO"/>
<%
	ArrayList<ProductDTO> productList = null;
	ArrayList<DetailOrderDTO> detailOrderList = null;
	TreeSet<SoldProductDTO> orderSet = null;
	int pId = 0;
	int categoryNum = 0;
	String quantity;
	String unitPrice;
	
	String customerId = (String)session.getAttribute("sessionCustomerId");
	String action = request.getParameter("action");	// 컨트롤러 요청 action 코드값
	switch(action) {
	case "view":		// 카테고리별 상품몰 보여주기
		String mallTitle = null;
		categoryNum = Integer.parseInt(request.getParameter("category"));
		switch (categoryNum) {
		case ProductDAO.ARDUINO:
			mallTitle = "아두이노 시리즈";
			break;
		case ProductDAO.SENSOR:
			mallTitle = "다양한 센서";
			break;
		case ProductDAO.ACTUATOR:
			mallTitle = "강력한 액츄에이터";
			break;
		case ProductDAO.PARTS:
			mallTitle = "가성비 최고의 전자 부품";
			break;
		case ProductDAO.OSHW:
			mallTitle = "다양한 오픈 소스 하드웨어";
			break;
		}
		productList = pDao.getProducts(categoryNum);
		request.setAttribute("mallTitle", mallTitle);
		request.setAttribute("productList", productList);
		pageContext.forward("../view/mallModal.jsp");
		break;
	case "item":		// 개별 상품 상세 조회
		pId = Integer.parseInt(request.getParameter("item"));
		pDto = pDao.getOneProduct(pId);
		request.setAttribute("pDto", pDto);
		pageContext.forward("../view/itemView.jsp");
		break;
	case "buy":			// 개별 상품 주문수량 입력
		String productId = request.getParameter("pId");
		String productName = request.getParameter("pName");
		quantity = request.getParameter("quantity");
		unitPrice = request.getParameter("pUnitPrice");
		//System.out.println("productId = " + productId + ", quantity = " + quantity);
		if (customerId == null) {
			response.sendRedirect("../view/loginForm.jsp");
			return;
		}
		categoryNum = (Integer.parseInt(productId) - 1) / 10 * 10 + 1;
		if (quantity.equals("0")) {
			request.setAttribute("message", "갯수를 먼저 입력하세요.");
			request.setAttribute("url", "../control/shoppingControl.jsp?action=view&category=" + categoryNum);
			pageContext.forward("../view/alertMsg.jsp");
			return;
		}
		orderSet = (TreeSet<SoldProductDTO>)session.getAttribute("sessionOrderSet");
		if (orderSet == null) {
			orderSet = new TreeSet<SoldProductDTO>();
		}
		SoldProductDTO spDto = new SoldProductDTO();
		spDto.setsProductId(productId);
		spDto.setsProductName(productName);
		spDto.setsQuantity(quantity);
		spDto.setsUnitPrice(unitPrice);
		orderSet.add(spDto);
		session.setAttribute("sessionOrderSet", orderSet);
		response.sendRedirect("../control/shoppingControl.jsp?action=view&category=" + categoryNum);
		break;
	case "history":		// 주문이력 조회
		if (customerId == null) {
			response.sendRedirect("../view/loginForm.jsp");
			return;
		}
		ArrayList<OrderDTO> orderList = oDao.getOrdersByCustomer(customerId);
		request.setAttribute("orderList", orderList);
		pageContext.forward("../view/showHistory.jsp");
		break;
	case "detail":		// 주문 상세 내역 조회
		String orderId = request.getParameter("orderId");
		oDto = oDao.getOneOrder(orderId);
		detailOrderList = oDao.getDetailOrders(orderId);
		request.setAttribute("detailOrderList", detailOrderList);
		request.setAttribute("oDto", oDto);
		pageContext.forward("../view/detailOrders.jsp");
		break;
	case "cartView":	// 장바구니 보여주기
		if (customerId == null) {
			request.setAttribute("message", "먼저 로그인부터 하세요.");
			request.setAttribute("url", "../view/loginForm.jsp");
			pageContext.forward("../view/alertMsg.jsp");
			return;
		}
		orderSet = (TreeSet<SoldProductDTO>)session.getAttribute("sessionOrderSet");
		if (orderSet == null) {
			request.setAttribute("message", "먼저 상품을 고르세요.");
			request.setAttribute("url", "../control/shoppingControl.jsp?action=view&category=30001");
			pageContext.forward("../view/alertMsg.jsp");
			return;
		}
		detailOrderList = new ArrayList<DetailOrderDTO>();
		int count = 1;
		int sum = 0;
		for (SoldProductDTO soldProduct : orderSet) {
			doDto = new DetailOrderDTO();
			doDto.setdNumber(Integer.toString(count++));
			doDto.setdProductName(soldProduct.getsProductName());
			quantity = soldProduct.getsQuantity();
			doDto.setdQuantity(quantity);
			unitPrice = soldProduct.getsUnitPrice();
			doDto.setdUnitPrice(unitPrice);
			int itemSum = Integer.parseInt(quantity.replaceAll(",", ""))*Integer.parseInt(unitPrice.replaceAll(",", ""));
			sum += itemSum;
			doDto.setdPrice(String.format("%,d", itemSum));
			//System.out.println(doDto.toString());
			detailOrderList.add(doDto);
		}
		request.setAttribute("sum", String.format("%,d", sum));
		request.setAttribute("detailOrderList", detailOrderList);
		pageContext.forward("../view/cartView.jsp");
		break;
	case "final":			// 주문 확정하기(DB에 쓰기)
		orderSet = (TreeSet<SoldProductDTO>)session.getAttribute("sessionOrderSet");
		String message;
		if (oDao.insertDetailOrders(orderSet, customerId)) {
			message = "주문에 성공했습니다. 이용해 주셔서 감사합니다.";
			session.removeAttribute("sessionOrderSet");
		} else {
			message = "주문도중에 에러가 발생했습니다. 조금후에 이용해 주세요.";
		}
		request.setAttribute("message", message);
		request.setAttribute("url", "../control/shoppingControl.jsp?action=view&category=30001");
		pageContext.forward("../view/alertMsg.jsp");
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