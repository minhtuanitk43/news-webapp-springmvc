<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="newsDetail" value="/xem-chi-tiet"/>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>${model.categoryName }</title>

</head>

<body>
	<!-- Page Content -->
	<div class="container py-3">
		<div class=row>
			<div class="col-8">
				<form action="<c:url value='/danh-muc'/>"
				id="formSubmit" method="get">
					<div class="row">
					<c:forEach var="item" items="${model.listResult}">

							<div class="border-bottom h-100 ps-0  pt-2 pb-2 pe-3">
								<div class="card-body p-0 position-relative">
									<c:if test="${not empty item.thumbnail}">
										<img style="float:left;width:30%;height:100%;" class="me-2" alt="hình ảnh" 
											src="<c:url value='${pageContext.request.contextPath}/image/${item.thumbnail}'/>">
									</c:if>
									<h4 class="card-title">${item.title}</h4>
									<p class="card-text pb-0">${item.shortDescription}</p>
									<a onClick="increasedViews(${item.id})" href="${newsDetail}?id=${item.id}" class="stretched-link"></a>
									<small class="text-muted float-right">${item.createdDate}</small>
								</div>

									
							</div>

					</c:forEach>
						<div class="mt-2 p-0">
							<ul class="pagination" id="pagination"></ul>
							<input type="hidden" value="${model.categoryCode}" id="code" name="code" />
							<input type="hidden" value="" id="page" name="page" /> 
							<input type="hidden" value="" id="limit" name="limit" />
						</div>			
					</div>
						
					<!-- pagination -->
								
				</form>
			</div>
			<div class="col-4 border-left">
				<%@include file="/WEB-INF/views/web/hotnews.jsp" %>
			</div>
		</div>
	</div>
<script>
		var currentPage = ${model.page};
		var totalPage = ${model.totalPage};
		$(function() {
			window.pagObj = $('#pagination').twbsPagination({
				totalPages : totalPage,
				visiblePages : 5,
				startPage : currentPage,
				onPageClick : function(event, page) {
					if (currentPage != page) {
						$('#code').val();
						$('#limit').val(10);
						$('#page').val(page);					
						$('#formSubmit').submit();
					}
				}
			});
		});
</script>
</body>
</html>