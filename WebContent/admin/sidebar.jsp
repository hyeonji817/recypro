<!-- 배경 참고 페이지 : https://jamesyleather.tistory.com/400 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SideBar</title>
<!-- Custom fonts for this template-->
<link href="css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> <!-- 아이콘 추가 라이브러리 -->
<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body>
	<!-- Sidebar -->
	<ul
		class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
		id="accordionSidebar">

		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center" href="../admin/admin_index.jsp">
			<div class="sidebar-brand-text mx-3">리싸이프로 Admin</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li class="nav-item active"><a class="nav-link" href="../admin/dashboard.jsp"><span>Dashboard</span></a>
		</li>

		<!-- Divider -->
		<hr class="sidebar-divider">

		<!-- Heading -->
		<div class="sidebar-heading">Product</div>

		<!-- Nav Item - Pages Collapse Menu -->
		<!-- Product 상품 관련 페이지 -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="../03_shop/addProduct.jsp" data-toggle="collapse" data-target="#collapseTwo"
			aria-expanded="true" aria-controls="collapseTwo"> <span>Product</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">product</h6>
						<a class="collapse-item" href="admin_product_list">Product List</a> 
						<a class="collapse-item" href="admin_enroll_product">Enroll Product</a>
					</div>
				</div>
		</li>

		<!-- Nav Item - Utilities Collapse Menu -->
		<!-- Order 주문 관련 조회 페이지 -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="../admin/orderList.jsp" data-toggle="collapse" data-target="#collapseUtilities"
			aria-expanded="true" aria-controls="collapseUtilities"><span>Order</span>
			</a>
			<div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">Order</h6>
					<a class="collapse-item" href="admin_order_list">Order Status</a> 
				</div>
			</div>
		</li>
		
		<!-- 쿠폰 관련 조회 페이지 -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="../admin/admin_coupon.jsp" data-toggle="collapse" data-target="#collapseUtilities"
			aria-expanded="true" aria-controls="collapseUtilities"><span>Coupon</span>
			</a>
			<div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">Coupon</h6>
					<a class="collapse-item" href="admin_coupon_list">Coupon Status</a> 
				</div>
			</div>
		</li>

		<!-- Divider -->
		<hr class="sidebar-divider">

		<!-- Heading -->
		<div class="sidebar-heading">Board</div>
		
		<!-- 공지사항 관련 조회 페이지 -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="admin_notice.jsp" data-toggle="collapse" data-target="#collapseMember"
			aria-expanded="true" aria-controls="collapsePages"> <span>Notice</span>
			</a>
			<div id="collapseMember" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">Notice</h6>
					<a class="collapse-item" href="../admin/member.jsp">Notice List</a>
					<div class="collapse-divider"></div>
				</div>
			</div>
		</li>
		
		<!-- 가입했던 사용자 관련 조회 페이지 -->
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="../admin/member.jsp" data-toggle="collapse" data-target="#collapseMember"
			aria-expanded="true" aria-controls="collapsePages"> <span>Member</span>
			</a>
			<div id="collapseMember" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">Member</h6>
					<a class="collapse-item" href="../admin/member.jsp">Member List</a>
					<div class="collapse-divider"></div>
				</div>
			</div>
		</li>

		<!-- Divider -->
		<hr class="sidebar-divider d-none d-md-block">
		
		<!-- Nav Item - Exit -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="../01_main/login_admin.jsp" data-toggle="collapse" data-target="#collapseMember"
			aria-expanded="true" aria-controls="collapsePages"> <span>Exit</span>
			</a>
		</li>

	</ul>
	<!-- End of Sidebar -->
	</body>
	</html>