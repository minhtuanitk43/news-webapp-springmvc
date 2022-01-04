<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3 class="alert-info">TIN MỚI</h3>
<c:forEach var="item" items="${listHotNews.listResult}">
	<div class="border-bottom mt-3 pb-0 position-relative">
		<c:if test="${not empty item.thumbnail}">
			<img style="float: left; width: 100px; height: 100px;" class="me-2"
				alt="hình ảnh"
				src="<c:url value='${pageContext.request.contextPath}/image/${item.thumbnail}'/>">
		</c:if>
		<h5 class="card-title">${item.title}</h5>
		<p class="card-text mb-0">${item.shortDescription}</p>
		<p class="card-text">
			<a onClick="increasedViews(${item.id})" class="stretched-link" href="${newsDetail}?id=${item.id}"></a> <small
				class="text-muted">${item.createdDate}</small>
		</p>
	</div>
</c:forEach>