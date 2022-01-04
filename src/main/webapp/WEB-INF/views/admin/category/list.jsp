<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="categoryAPI" value="/api/category" />	
<c:url var="categoryURL" value="/quan-tri/the-loai/danh-sach?page=1&limit=2" />
<c:url var="editCategoryURL" value="/quan-tri/the-loai/chinh-sua" />

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Danh sách thể loại</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value='/quan-tri/the-loai/danh-sach'/>"
			id="formSubmit" method="get">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> 
							<a href="${webHomeURL}">Trang chủ</a></li>
						<li><a href="${adminHomeURL}">Quản trị</a></li>
						<li><a href="#">Thể loại</a></li>
						<li class="active">Danh sách thể loại</li>
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
												data-toggle="tooltip" title='Thêm thể loại'
												href='${editCategoryURL}'> <span> <i
													class="fa fa-plus-circle bigger-110 purple"></i>
											</span>
											</a>
											<button id="btnDelete" type="button"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa thể loại'>
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
													<th>Tên thể loại</th>
													<th>Code</th>
													<th>Từ khóa tìm kiếm</th>
													<th>Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr>
														<td width=50px class=text-center><input type="checkbox" id="checkbox_${item.id}"
															value="${item.id}"></td>
														<td>${item.name}</td>
														<td>${item.code}</td>
														<td>${item.keyWords}</td>
														<td><a class="btn btn-sm btn-primary btn-edit"
															data-toggle="tooltip" title="Cập nhật thể loại"
															href='${editCategoryURL}?id=${item.id}'>
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
						$('#limit').val(2);
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
			    title: "Xóa thể loại?",
			    text: "Các thể loại được chọn sẽ bị xóa vĩnh viễn !",
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
			        deleteCategory(ids);	
			    }
			 });
			});
		function deleteCategory(data) {
	        $.ajax({
	            url: '${categoryAPI}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(data), 
	            success: function (result){
	            	window.location.href = "${categoryURL}&message=delete_success"; 
	            },
	            errror: function (error){
	            	window.location.href = "${categoryURL}&message=error_system";
	            }
	        });
	    }
	</script>
</body>

</html>