<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지 (대시보드)</title>
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> <!-- 아이콘 추가 라이브러리 -->
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
            	<h1 class="h3 mb-0 text-black-800" style="top: 15%; margin-top: 5%; margin-left: 5%; font-weight: 700;">Dashboard</h1>
            </div>
			
			<!-- Begin Page Content -->
			<div class="container-fluid">
                    <!-- Content Row -->
                    <div class="row">

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
                    </section>
                    <!-- end of Card section -->
                    
                    <!-- 최근 구매금액 내역 -->
                    <div class="col-12">
                    	<!-- table 2 -->
                    	<h3 class="text-muted text-center mb-3">최근 구매금액 내역</h3>
                    	<table class="table text-center table-dark table-hover">
                    		<thead>
                    			<tr class="text-muted">
                    				<th>#</th>
                    				<th>이름</th>
                    				<th>금액</th>
                    				<th>날짜</th>
                    				<th>상태</th>
                    			</tr>
                    		</thead>
                    		<tbody>
                    			<tr>
                    				<th>1</th>
                    				<th>곽현지</th>
                    				<th>3,000</th>
                    				<th>2022/11/13</th>
                    				<th><span class="badge badge-success w-75 py-2">Approved</span></th>
                    				<!-- w-75 : width-75% -->
                    			</tr>
                    			<tr>
                    				<th>2</th>
                    				<th>조원우</th>
                    				<th>5,400</th>
                    				<th>2022/11/03</th>
                    				<th><span class="badge badge-danger w-75 py-2">Pending</span></th>
                    			</tr>
                    			<tr>
                    				<th>3</th>
                    				<th>곽현지</th>
                    				<th>29,800</th>
                    				<th>2022/11/03</th>
                    				<th><span class="badge badge-primary w-75 py-2">Waiting</span></th>
                    			</tr>
                    			<tr>
                    				<th>4</th>
                    				<th>김기현</th>
                    				<th>5,900</th>
                    				<th>2022/10/31</th>
                    				<th><span class="badge badge-success w-75 py-2">Approved</span></th>
                    			</tr>
                    			<tr>
                    				<th>5</th>
                    				<th>성문규</th>
                    				<th>5,900</th>
                    				<th>2022/10/31</th>
                    				<th><span class="badge badge-danger w-75 py-2">Pending</span></th>
                    			</tr>
                    		</tbody>
                    	</table>
                    	
                    	<!-- Pagination -->
                    	<nav>
                    		<ul class="pagination justify-content-center">
                    			<li class="page-item">
                    				<a href="#" class="page-link py-2 px-3"><span>Previous</span></a>
                    			</li>
                    			<li>
                    				<a href="#" class="page-link py-2 px-3"><span>1</span></a>
                    			</li>
                    			<li>
                    				<a href="#" class="page-link py-2 px-3"><span>2</span></a>
                    			</li>
                    			<li>
                    				<a href="#" class="page-link py-2 px-3"><span>3</span></a>
                    			</li>
                    			<li>
                    				<a href="#" class="page-link py-2 px-3"><span>Next</span></a>
                    			</li>
                    		</ul>
                    	</nav>
                    	<!-- 페이지네이션 끝 -->
                    </div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../admin/footer.jsp"%>