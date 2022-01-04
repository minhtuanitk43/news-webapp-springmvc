<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="newsDetail" value="/xem-chi-tiet"/>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Trang chủ</title>

</head>

<body>
	<%-- <%@ include file="menu.jsp"%> --%>

	<!-- Page Content -->
	<div class="container">
		<!-- Heading Row -->
		<div class="row align-items-center my-3 ">
			<div>
				<div class="row"> 
					<h3 class="alert-info p-0 ms-3">TÌNH HÌNH DỊCH CẢ NƯỚC</h3>
					<div class="col-5">
						<div class="col text-center alert alert-danger py-2 mt-3">
						<h5 class="text-dark">Số ca nhiễm</h5>
						<h4 id=infected class="text-danger">700000</h4>
						<h6>
							Hôm nay:<strong id=infectedToday>+123</strong>
						</h6>
					</div>
					<div class="col text-center alert alert-success py-2 mt-4">
						<h5 class="text-dark">Khỏi</h5>
						<h4 id=recovered class="text-success">700000</h4>
						<h6>
							Hôm nay:<strong id=recoveredToday>+123</strong>
						</h6>
					</div>
					<div class="col text-center alert alert-secondary py-2 mt-4">
						<h5 class="text-dark">Tử vong</h5>
						<h4 id=died class="text-black">700000</h4>
						<h6>
							Hôm nay:<strong id=diedToday>+123</strong>
						</h6>
					</div>
					</div>
					<div class=col-7>
						<table class="table border scroll my-3">
							<thead>
								<tr>
									<th class="col-4">Tình/Thành phố</th>
									<th class="col-3 text-center">Tổng ca nhiễm</th>
									<th class="col-3 text-center">Hôm nay</th>
									<th class="col-2 text-center">Tử vong</th>
								</tr>
							</thead>
							<tbody id="tbodyCovid">

							</tbody>
						</table>
					</div>
				</div>
				<!-- News -->
				<div class="row border-top pt-3">
					<!-- col-4 Tin mới -->
					<div class="col-4 border-right">
						
						<%@include file="/WEB-INF/views/web/hotnews.jsp" %>
						
						<h3 class="bg-light text-dark">Tỷ giá ngoại tệ</h3>
						<div>
							<iframe style="border: none; width: 100%; height: 500px"
									src="https://tygiado.com/nhung-ngoai-te/"></iframe>
						</div>
						<hr>
						<h3 class="bg-light text-dark mt-1">Giá vàng trong nước</h3>
						<div>
							<iframe frameborder="0" width="100%" height="500px" 
									src="https://webtygia.com/api/vang?bgheader=b53e3e&colorheader=ffffff&padding=5&fontsize=13&undefined"></iframe>
						</div>
						<hr>
						<h3 class="bg-light text-dark mt-1">Giá xăng</h3>
						<div>
							<iframe frameborder="0" width="100%" height="500px" 
									src="https://webtygia.com/api/xang-dau?bgheader=3727b0&colorheader=ffffff&padding=5&fontsize=13&undefined"></iframe>
						</div>
					</div>
					
					<!-- Danh mục tin -->
					<div class="col-8">
						<!-- Render listModel -->
						<c:forEach var="model" items="${listModel}">
						
							<div class="row border-top py-2">
								<h3 class="bg-light text-dark">${model.categoryName}</h3>
									<div class="ps-4 py-2 border-bottom position-relative">
										<c:if test="${not empty model.listResult[0].thumbnail}">
										  	<img style="float:left;width:30%;height:100%;" class="me-2" alt="hình ảnh" src="<c:url value='${pageContext.request.contextPath}/image/${model.listResult[0].thumbnail}'/>">
										</c:if>
										<h5 class="card-title">${model.listResult[0].title}</h5>
										<p class="card-text">${model.listResult[0].shortDescription}</p>
										<a onClick="increasedViews(${model.listResult[0].id})" class="stretched-link" href="${newsDetail}?id=${model.listResult[0].id}"></a>
										<p class="card-text"><small class="text-muted">${model.listResult[0].createdDate}</small></p>
									</div>
								<div class="row my-2 ps-4">
									<c:forEach var="item" items="${model.listResult}" begin="1" end="4" >						  
									  <div class="col-6 my-2 p-2">
										  <div class="border-right border-top p-2">
										  	<c:if test="${not empty item.thumbnail}">
										  		<img style="float:left;width:35%;height:100%;" class="me-2" alt="hình ảnh" src="<c:url value='${pageContext.request.contextPath}/image/${item.thumbnail}'/>">
										  	</c:if>
										    <h5 class="card-title">${item.title}</h5>
										    <p class="card-text">${item.shortDescription}</p>
										    <a onClick="increasedViews(${item.id})" class="stretched-link" href="${newsDetail}?id=${item.id}"></a>
										    <p class="card-text"><small class="text-muted">${item.createdDate}</small></p>
										  </div>
									  </div>
								  	</c:forEach>
								</div>
								
							</div>
							
						</c:forEach>
					</div>
					<!-- /.Danh mục tin -->	
				</div>
			</div>
		</div>
		<!-- /.row -->
		</div>
		<!-- /.container -->

		<script>
			$(document).ready(function() {
				$.ajax({
					//https://apify.com/dtrungtin/covid-vi
					url : 'https://api.apify.com/v2/key-value-stores/EaCBL1JNntjR3EakU/records/LATEST?',
					type : 'GET',
					dataType : 'json',
					success : function(data,textStatus, xhr) {
								viewData(data);
								buildTable(data);
								},
					error : function(xhr, textStatus,
								errorThrown) {
								console
								.log('Error in Database');
								}
							});
					});
			function buildTable(data) {
				$.each(data, function(index, value) {
					if (index == "locations") {
						var tbody = '';
						$.each(data[index], function(i, v) {
							var tr = '<tr><td class="col-4 text-left">'
									+ v.name
									+ '</td><td class="col-3 text-center">'
									+ addCommas(v.cases)
									+ '</td><td class="col-3 text-center text-danger">'
									+ '+' + addCommas(v.casesToday)
									+ '</td><td class="col-2 text-center">'
									+ addCommas(v.death) + '</td></tr>';
							tbody += tr;
						});
					}
					$('#tbodyCovid').html(tbody);
				});
			}
			function viewData(data) {
				$('#infected').html(addCommas(data.infected));
				$('#infectedToday').html(" +" + addCommas(data.infectedToday));
				$('#recovered').html(addCommas(data.recovered));
				$('#recoveredToday').html(" +" + addCommas(data.recoveredToday));
				$('#died').html(addCommas(data.died));
				$('#diedToday').html(" +" + addCommas(data.diedToday));
			}
			function addCommas(nStr) {
				nStr += '';
				x = nStr.split('.');
				x1 = x[0];
				x2 = x.length > 1 ? '.' + x[1] : '';
				var rgx = /(\d+)(\d{3})/;
				while (rgx.test(x1)) {
					x1 = x1.replace(rgx, '$1' + ',' + '$2');
				}
				return x1 + x2;
			}
			
		</script>
</body>

</html>