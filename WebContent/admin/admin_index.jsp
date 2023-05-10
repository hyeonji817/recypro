<!-- 참고한 페이지 주소좌표 : https://citylock77.tistory.com/106?category=924797 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###");
	String cartId = session.getId();
	String id = request.getParameter("id");
	PrintWriter script = response.getWriter();	
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지</title>
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>	<!-- 아이콘 추가 라이브러리 -->
<style>
	/** cards */
	.card-common {
		box-shadow: 1px 2px 5px #999;
		transition: all .4s;
	}
	
	.card-common:hover {
		box-shadow: 2px 3px 15px #999;
		transform: translate(-1px);
	}
</style>
</head>
<body>
	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-cloumn">
			<%@ include file="../admin/sidebar.jsp" %>
			<!-- Main Content -->
			<div id="content">

			<!-- Page Heading -->
    		<div class="d-sm-flex align-items-center justify-content-between mb-4">
        		<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 5%; font-weight: 700;">Admin</h1>
    		</div>

				
	<!-- Card section -->
	<section>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-9 ml-auto">
					<div class="row pt-5 mt-3 mb-5">
						<div class="col-sm-6 p-2">
							<div class="card card-common">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<i class="fas fa-shopping-cart fa-3x text-warning"></i>
										<div class="text-right text-secondary">
											<h5>Sales</h5>
											<h3>$135,000</h3>
										</div>
									</div>
								</div>
								<div class="card-footer text-secondary">
									<i class="fas fa-sync mr-3"></i>
									<span>Updated Now</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 p-2">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<i class="fas fa-money-bill-alt fa-3x text-success"></i>
										<div class="text-right text-secondary">
											<h5>Expenses</h5>
											<h3>$151,680</h3>
										</div>
									</div>
								</div>
								<div class="card-footer text-secondary">
									<i class="fas fa-sync mr-3"></i>
									<span>Updated Now</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 p-2">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<i class="fas fa-users fa-3x text-info"></i>
										<div class="text-right text-secondary">
											<h5>Users</h5>
											<h3>$15,000</h3>
										</div>
									</div>
								</div>
								<div class="card-footer text-secondary">
									<i class="fas fa-sync mr-3"></i>
									<span>Updated Now</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 p-2">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<i class="fas fa-chart-line fa-3x text-info"></i>
										<div class="text-right text-secondary">
											<h5>Visitors</h5>
											<h3>$45,000</h3>
										</div>
									</div>
								</div>
								<div class="card-footer text-secondary">
									<i class="fas fa-sync mr-3"></i>
									<span>Updated Now</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 각 현황 끝 -->
		
		<!-- 막대 진행바 만들기 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xl-10 col-lg-9 col-md-8 ml-auto" style="margin: 0 auto; left: 22%;">
					<div class="row mb-4">
						<!-- 막대 진행바 (progress bar) -->
						<div class="col-xl-6 col-12">
							<div class="bg-dark text-white p-4 rounded">
								<h4 class="mb-4">웹 브라우저 진행상태</h4>
								<!-- progress item -->
								<h6 class="mb-3">구글 크롬</h6>
								<div class="progress mb-4" style="height: 20px">
									<div class="progress-bar progress-bar-striped font-weight-bold bg-danger" style="width: 91%">91%</div>
								</div>
								
								<!-- progress item2 -->
								<h6 class="mb-3">모질라 파이어폭스</h6>
								<div class="progress mb-4" style="height: 20px">
									<div class="progress-bar progress-bar-striped font-weight-bold bg-success" style="width: 84%">84%</div>
								</div>
								
								<!-- progress item3 -->
								<h6 class="mb-3">iOS 사파리</h6>
								<div class="progress mb-4" style="height: 20px">
									<div class="progress-bar progress-bar-striped font-weight-bold bg-primary" style="width: 76%">76%</div>
								</div>
								
								<!-- progress item4 -->
								<h6 class="mb-3">모질라 파이어폭스</h6>
								<div class="progress mb-4" style="height: 20px">
									<div class="progress-bar progress-bar-striped font-weight-bold bg-warning" style="width: 34%">34%</div>
								</div>
							</div>
						</div>
						<div class="col-xl-6 col-12"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 막대 진행바 끝 -->
	</section>
	
			</div>
		</div>
	</div>
</body>
</html>