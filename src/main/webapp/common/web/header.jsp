<%@page import ="com.laptrinhjavaweb.util.SecurityUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<c:url var="embed" value="/tien-ich" />
<div class="fixed-top bg-white">
    
        <div class="container bg-white">
        	<div class="row">
        		<div class="col-3 align-self-center">
        			<img width="100" src="<c:url value='/imgs/logonews.PNG'/>" alt="">
            		<h3 style="color:#c9503b" class="d-inline align-middle">News 247</h3>
            		<a class=stretched-link href="${webHomeURL }"></a>
        		</div>
        		<div class="col-2 align-self-center">
        			<span id="clo_vn_time"></span>
        		</div>
        		<div class="col-4 align-self-center">
        			<form class="d-flex" action="<c:url value='/tim-kiem'/>">
				          <input class="form-control me-2" type="search" placeholder="Tìm kiếm" aria-label="Search" name=key>
				          <input type="hidden" value="1" name="page">
				          <input type="hidden" value="10" name="limit">
				          <button class="btn btn-outline-secondary" type="submit"><i class="fas fa-search"></i></button>
				    </form>
        		</div>
        		<div class="col-3 align-self-center text-right">
        			
	        			<security:authorize access="isAnonymous()">
	                   		<p class="d-inline">
	                   			<a class="d-inline text-secondary nav-link" href="<c:url value='/dang-nhap'/>">Đăng nhập</a>
	                   		</p>
							<p class="d-inline">
	                   			<a class="d-inline text-secondary nav-link" href="<c:url value='/thoat'/>">Đăng ký</a>
	                   		</p>	
						</security:authorize>
	                   
	                   <security:authorize access="isAuthenticated()">
							<span class="d-inline">
								<a class="d-inline text-secondary nav-link" href="#">Xin chào, <%=SecurityUtils.getPrincipal().getFullName()%> </a>
							</span>
							<span class="d-inline">
								<a class="d-inline text-secondary nav-link" href="<c:url value='/thoat'/>">Thoát</a>
							</span>	
						</security:authorize>  
					
        		</div>
        	</div>
         </div>
   <div>      
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <div class="container ps-2">
	    <a class="nav-link text-dark fw-bold ps-0" href="${webHomeURL }">Trang chủ</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNavDropdown">
	      <ul class="navbar-nav">
	        <li class="nav-item dropdown">
	        	<a class="nav-link dropdown-toggle text-dark fw-bold" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Tiện ích
	          </a>
	          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
	            <li><a class="dropdown-item" href="${embed }?embed=lich-cat-dien">Lịch cắt điện</a></li>
	            <li><a class="dropdown-item" href="${embed }?embed=ket-qua-xo-so">Kết quả xổ số</a></li>
	            <li><a class="dropdown-item" href="${embed }?embed=lich-phat-song">Lịch phát sóng</a></li>
	          </ul>
	        </li>
	        <!-- Render CategoryName to Menu -->
	        <c:forEach var="item" items="${listCategory}">
	        	<li class="nav-item">
		          <a class="nav-link text-dark fw-bold" href="<c:url value='/danh-muc?code=${item.code }&page=1&limit=10'/>">${item.name }</a>
		        </li>
	        </c:forEach>
			<li class="nav-item">
		          <a class="nav-link text-dark fw-bold" href="${embed }?embed=thoi-tiet">Thời tiết</a>
		        </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle text-dark fw-bold" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Thông tin thị trường
	          </a>
	          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
	            <li><a class="dropdown-item" href="${embed }?embed=ty-gia-ngoai-te">Tỷ giá ngoại tệ</a></li>
	            <li><a class="dropdown-item" href="${embed }?embed=ty-gia-vang">Tỷ giá vàng</a></li>
	            <li><a class="dropdown-item" href="${embed }?embed=gia-xang-dau">Giá xăng dầu</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>

	
	</div> 

</div>

