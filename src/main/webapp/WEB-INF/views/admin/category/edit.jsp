 <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="categoryURL" value="/quan-tri/the-loai/danh-sach?page=1&limit=2" />
<c:url var="categoryAPI" value="/api/category" />
<c:url var="editURL" value="/quan-tri/the-loai/chinh-sua" />

<html>
<head>
<title>Chỉnh sửa bài viết</title>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<script type="text/javascript">
					try {
						ace.settings.check('breadcrumbs', 'fixed')
					} catch (e) {
					}
				</script>

				<ul class="breadcrumb">
					<li><i class="ace-icon fa fa-home home-icon"></i> 
						<a href="${webHomeURL}">Trang chủ</a></li>
					<li><a href="${adminHomeURL}">Quản trị</a></li>
					<li><a href="#">Quản lý bài viết</a></li>
					<li><a href="#">Thể loại</a></li>
					<li><a href="${categoryURL}">Danh sách thể loại</a></li>
					<li class="active">
						<c:if test="${empty model.id}">	
								Thêm thể loại
						</c:if> 
						<c:if test="${not empty model.id}">
								Cập nhật thể loại	
						</c:if>
					</li>
					
					
					
				</ul>
				<!-- /.breadcrumb -->
			</div>

			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<div class=row>
							<c:if test="${not empty message}">
								<div class="alert alert-${alert}">${message}</div>
							</c:if>
							<div class="widget-box table-filter">
									<div class="table-btn-controls">
										<div class="pull-right tableTools-container">
											<div class="dt-buttons btn-overlap btn-group">
												<c:if test="${not empty model.id}">
													<a flag="info"
														class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
														data-toggle="tooltip" title='Thêm thể loại'
														href='${editURL}'> <span> <i
															class="fa fa-plus-circle bigger-110 purple"></i>
													</span>
													</a>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
						<!-- PAGE CONTENT BEGINS -->
						<form:form class="form-horizontal" role="form" id="formSubmit"
							modelAttribute="model">
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="form-field-1"> Tên thể loại: </label>

								<div class="col-sm-9">
									<form:input path="name" class="col-xs-10 col-sm-5" />
								</div>
							</div>

							<div class="space-4"></div>

							<div class="form-group">
								<label for="shortDescription"
									class="col-sm-3 control-label no-padding-right">Code:</label>
								<div class="col-sm-9">
									<form:input path="code" class="col-xs-10 col-sm-5" />
								</div>
							</div>
							
							<div class="space-4"></div>

							<div class="form-group">
								<label for="keywords"
									class="col-sm-3 control-label no-padding-right">Từ khóa tìm kiếm:</label>
								<div class="col-sm-9">
									<form:textarea path="keyWords"
											class="col-xs-10 col-sm-5" rows="3" cols="10"
											id="keyWords" />
								</div>
							</div>

							<div class="space-4"></div>
							
							<form:hidden path="id" id="categoryId" />
							
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9">
									<c:if test="${not empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdate">
											<i class="ace-icon fa fa-check bigger-110"></i> Cập nhật thể loại
											
										</button>
									</c:if>

									<c:if test="${empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdate">
											<i class="ace-icon fa fa-check bigger-110"></i> Thêm thê loại
										</button>
									</c:if>

									&nbsp; &nbsp; &nbsp;
									<button class="btn" type="reset">
										<i class="ace-icon fa fa-undo bigger-110"></i> Hủy bỏ
									</button>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#btnAddOrUpdate').click(function(e) {
			e.preventDefault();
			var data = {};
			var formData = $('#formSubmit').serializeArray();
			$.each(formData, function(i, v) {
				data["" + v.name + ""] = v.value;
			});
			var id = $('#categoryId').val();
			if (id == "") {
				addCategory(data);
			} else {
				updateCategory(data);
			}
		});
		function addCategory(data) {
			$.ajax({
					url : '${categoryAPI}',
					type : 'POST',
					contentType : 'application/json',
					data : JSON.stringify(data),
					dataType : 'json',
					success : function(result) {
						window.location.href = "${editURL}?id=" + result.id
							+ "&message=insert_success";
					},
					error : function(error) {
						window.location.href = "${categoryURL}&message=error_system";
					}
				});
		};
		function updateCategory(data) {
			$.ajax({
				url : '${categoryAPI}',
				type : 'PUT',
				contentType : 'application/json',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(result) {
					window.location.href = "${editURL}?id=" + result.id
							+ "&message=update_success";
				},
				error : function(error) {
					window.location.href = "${newURL}?id=" + data.id
							+ "&message=error_system";
				}
			});
		};
	</script>
</body>
</html>

