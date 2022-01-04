<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:url var="newsDetail" value="/xem-chi-tiet"/>
<c:url var="commentAPI" value="/api/comment"/>
<c:url var="newAPI" value="/api/new/delete"/>
<c:url var="editNewURL" value="/quan-tri/bai-viet/chinh-sua" />
<c:url var="danhmucURL" value='/danh-muc?code=${model.categoryCode }&page=1&limit=10'/>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Trang chủ</title>

</head>

<body>
	<!-- Page Content -->
	<div class="container">
		<div class=border-bottom>
			<h1>${model.title}</h1>
			<div>
				${model.content}
				
				<security:authorize access="hasAnyRole('ADMIN','AUTHOR','EDITOR')">
					<p class="text-right">
						<a href="${editNewURL }?id=${model.id}">Chỉnh sửa bài viết</a>
						<security:authorize access="hasAnyRole('ADMIN','AUTHOR')">
						|<a href="#" onClick="deleteNews(${model.id})">Xóa</a>
						</security:authorize>
					</p>
				</security:authorize>
			</div>	
		</div>
			<section class="gradient-custom">
				<div class="container my-5 py-5">
					<div class="row d-flex justify-content-left">
						<div class="col-md-12 col-lg-10 col-xl-8">
							<h3 class="text-dark ps-2"> Ý kiến </h3>
							<div class="card">
							
								<!-- Comment -->
								<security:authorize access="isAuthenticated()">
									<form:form class="form-horizontal" role="form" id="formSubmit"
										method="POST" accept-charset="UTF-8" action="upload"
										modelAttribute="comment">
						
										<div class="form-group">
											<label for="content" class="col-sm-2 control-label"></label>
											<div class="m-2">
												<form:textarea path="content" class="col-xs-10 col-sm-12" rows="3"
													 placeholder="Ý kiến của bạn" id="content" />
											</div>
										</div>
										<sec:authentication var="user" property="principal" />
										<form:hidden path="userName" id="userName" value="${user.username}"/>
										<form:hidden path="newId" id="newId" value="${model.id }"/>
										<div class="clearfix form-actions text-right">
											<div class="pe-2">
												<button class="btn btn-info" type="button" id="btnAddComment">
													<i class="ace-icon fa fa-check bigger-110"></i> 
													Gửi
												</button>
												<button class="btn btn-outline-secondary" type="reset">
													Hủy bỏ
												</button>
											</div>
										</div>									
									</form:form>
								</security:authorize>
								<!-- ./Comment -->							
								
								<div class="card-body p-4">
									<!-- Comment list-->
									<!-- New Comment -->
									<div id="newComment">
									
									</div>
									<c:forEach var="comment" items="${comment.listResult}">
										<div class="row bg-light mb-2" id="commentId_${comment.id }">
											<div class="col">
												<div class="d-flex flex-start">												
													<div class="flex-grow-1 flex-shrink-1">
														<div
															class="d-flex justify-content-between align-items-center">
															<p class="mb-1 text-primary">
																${comment.userName }<span class="small text-secondary"> - ${comment.createdDate }</span>
															</p>															
														</div>
														<div>
															<p class="mb-0">${comment.content }</p>
															
															<security:authorize access="hasAnyRole('ADMIN')">
																<a href="#!" onClick="deleteComment(${comment.id });" class="small">Xóa</a>
															</security:authorize>
															
														</div>													
													</div>
												</div>	
											</div>
										</div>
									</c:forEach>
									<!-- ./Comment list -->
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- Cùng danh mục -->
		<h4 class="bg-light mt-5">Cùng danh mục</h4>
			<div class="row">
			<c:forEach var="item" items="${model.listResult}" begin="0" end="5">
				<div class="col-md-4 p-3">
					<div class="card h-100">
						<div class="card-body p-2">
							<c:if test="${not empty item.thumbnail}">
								<img style="float:left;width:150px;height:150px;" class="me-2" alt="hình ảnh" 
									src="<c:url value='${pageContext.request.contextPath}/image/${item.thumbnail}'/>">
							</c:if>
							<h4 class="card-title">${item.title}</h4>
							<p class="card-text">${item.shortDescription}</p>
						</div>
						<div class="ps-2">
							<a onClick="increasedViews(${item.id})" href="${newsDetail}?id=${item.id}" class="stretched-link"></a>
							<p class="card-text"><small class="text-muted">${item.createdDate}</small></p>
						</div>
					</div>
				</div>
			</c:forEach>

			</div>
	</div>
	<script type="text/javascript">
	$('#btnAddComment').click(function(e) {
		e.preventDefault();
		var data = {};
		var formData = $('#formSubmit').serializeArray();
		$.each(formData, function(i, v) {
			data["" + v.name + ""] = v.value;
		});	
		addComment(data);
	});
	function addComment(data) {
		$.ajax({
				url : '${commentAPI}/save',
				type : 'POST',
				contentType : 'application/json',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(result) {
					$('#content').val('');
					var comment = 		'<div class="row bg-light mb-2" id="commentId_' + result.id + '">'
										+	'<div class="col">'
										+ 		'<div class="d-flex flex-start">'												
										+ 			'<div class="flex-grow-1 flex-shrink-1">'
										+				'<div class="d-flex justify-content-between align-items-center">'
										+					'<p class="mb-1 text-primary">'
										+						result.userName + '<span class="small text-secondary"> - Vừa xong </span>'
										+					'</p>'															
										+				'</div>'
										+				'<div>'
										+					'<p class="mb-0">' + result.content + '</p>'				
										+					'<a href="#!" onClick="deleteComment(' + result.id + ');" class="small">Xóa</a>'
										+				'</div>'													
										+			'</div>'
										+		'</div>'	
										+	'</div>'
										+'</div>';
					var body = comment+$('#newComment').html();
					$('#newComment').html(body);
				},
				error : function(error) {
					alert("Lỗi hệ thống, vui lòng thử lại")
				}
			});
	};
	function deleteComment(id) {
		var data = [""+id+""];
        $.ajax({
            url: '${commentAPI}/delete',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data), 
            success: function (result){
            	$('#commentId_'+id).remove();
            },
            errror: function (error){
            	window.location.href = "${newURL}?page=1&limit=5&message=error_system";
            }
        });
    }
	function deleteNews(id) {
		swal({
		    title: "Xóa bài viết?",
		    text: "Bài viết sẽ bị xóa vĩnh viễn !",
		    type: "warning",
		    showCancelButton: true,
		    confirmButtonColor: '#008000',
		    confirmButtonText: 'Xác nhận !',
		    cancelButtonText: "Hủy bỏ !",
		    closeOnConfirm: false,
		    closeOnCancel: true
		 }).then(
		 function(isConfirm){
		   if (isConfirm.value){
			   var data = [""+id+""];			     
		        deleteNew(data);	     	
		    }
		 });
		};
	function deleteNew(data) {		
        $.ajax({
            url: '${newAPI}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data), 
            success: function (result){
            	window.location.href = "${danhmucURL}";
            },
            errror: function (error){
            	alert("Lỗi hệ thống");
            }
        });
    }
</script>
</body>
</html>