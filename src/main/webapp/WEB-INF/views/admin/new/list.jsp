<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="newURL" value="/quan-tri/bai-viet/danh-sach" />
<c:url var="editNewURL" value="/quan-tri/bai-viet/chinh-sua" />
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Danh sách bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="${newURL }"
			id="formSubmit" method="get">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> 
							<a href="${webHomeURL}">Trang chủ</a></li>
						<li><a href="${adminHomeURL}">Quản trị</a></li>
						<li><a href="#">Quản lý bài viết</a></li>
						<li class="active">Danh sách bài viết</li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<c:if test="${not empty message}">
								<div class="alert alert-${alert}">${message}</div>
							</c:if>
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container">
										<div class="dt-buttons btn-overlap btn-group">											
											<a flag="info"
												class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm bài viết'
												href='${editNewURL}'> <span> <i
													class="fa fa-plus-circle bigger-110 purple"></i>
											</span>
											</a>
											<button id="btnDelete" type="button"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa bài viết'>
												<span> <i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>				
							<div class="row">						
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th width=50px class=text-center><input type="checkbox" id="checkAll" value=""></th>
													<th class="col-md-3">Tên bài viết</th>
													<th class="col-md-1">Hình đại diện</th>
													<th>Mô tả ngắn</th>
													<th class="col-md-1">Người viết</th>
													<th width="70">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr>
														<td width=50px class=text-center><input type="checkbox" id="checkbox_${item.id}"
															value="${item.id}"></td>
														<td class="col-md-3">${item.title}</td>
														<td class="col-md-1"><img class="thumbnail" width=100 src="<c:url value='${pageContext.request.contextPath}/image/${item.thumbnail}'/>"></td>
														<td>${item.shortDescription}</td>
														<td class="col-md-1">${item.createdBy}</td>
														<td><a class="btn btn-sm btn-primary btn-edit"
															data-toggle="tooltip" title="Cập nhật bài viết"
															href='${editNewURL}?id=${item.id}'>
															<i class="fa fa-pencil-square-o" aria-hidden="true"></i> 
															</a>
														</td>
													</tr>
												</c:forEach>

											</tbody>
										</table>
										<ul class="pagination" id="pagination"></ul>
										<input type="hidden" value="" id="page" name="page" /> 
										<input type="hidden" value="" id="limit" name="limit" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- /.main-content -->

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
						$('#limit').val(5);
						$('#page').val(page);
						$('#formSubmit').submit();
					}
				}
			});
		});
		
		$("#checkAll").click(function(e) {
			if(this.checked) {
		        // Iterate each checkbox
		        $(':checkbox').each(function() {
		            this.checked = true;                        
		        });
		    } else {
		        $(':checkbox').each(function() {
		            this.checked = false;                       
		        });
		    }		
		});
		
		$("#btnDelete").click(function(e) {
			e.preventDefault();
			swal({
			    title: "Xóa bài viết?",
			    text: "Các bài viết được chọn sẽ bị xóa vĩnh viễn !",
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
			        var ids = $('tbody input[type=checkbox]:checked').map(function () {
			            return $(this).val();
			        }).get();			     
			        deleteNew(ids);
			     	
			    }
			 });
			});
		function deleteNew(data) {
	        $.ajax({
	            url: '${newAPI}/delete',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(data), 
	            success: function (result){
	            	window.location.href = "${newURL}?page=1&limit=5&message=delete_success";
	            	/* swal("Xóa thành công !", "", "success"); */
	            },
	            errror: function (error){
	            	window.location.href = "${newURL}?page=1&limit=5&message=error_system";
	            }
	        });
	    }
	</script>
</body>

</html>