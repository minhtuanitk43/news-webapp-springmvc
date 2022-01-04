<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userURL" value="/quan-tri/thanh-vien/danh-sach?page=1&limit=5" />
<c:url var="userAPI" value="/api/user" />
<c:url var="editURL" value="/quan-tri/thanh-vien/chinh-sua" />

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
					<li><a href="#">Quản lý thành viên</a></li>
					<li><a href="${userURL}">Danh sách thành viên</a></li>
					<li class="active">
					<c:if test="${empty model.id}">
							Thêm thành viên
						</c:if>
						<c:if test="${not empty model.id}">
							Cập nhật thành viên	
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
													data-toggle="tooltip" title='Thêm bài viết'
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
						<form:form  class="form-horizontal" role="form" id="formSubmit" method="POST" accept-charset="UTF-8"
									action="upload" enctype="multipart/form-data" modelAttribute="model">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"
									for="userName"> Username: </label>
								<div class="col-sm-8">
									<form:input path="userName" class="col-xs-10 col-sm-5" />
								</div>
							</div>

							<div class="space-4"></div>

							<div class="form-group">
								<label class="col-sm-4 control-label"
									for="password"> Password: </label>
								<div class="col-sm-8">
									<form:input path="password" class="col-xs-10 col-sm-5" type="password"/>
								</div>
							</div>

							<div class="space-4"></div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"
									for="fullName"> Họ tên: </label>
								<div class="col-sm-8">
									<form:input path="fullName" class="col-xs-10 col-sm-5" />
								</div>
							</div>

							<div class="space-4"></div>
							
							<div class="form-group">
								<label for="roleCode"
									class="col-sm-4 control-label">Quyền:</label>
								<div class="col-sm-8">
									<form:select path="roleCode" id="roleCode"
										class="col-xs-10 col-sm-5">
										<form:option value="" label="--Chọn quyền--" />
										<form:options items="${roles}" />
									</form:select>
								</div>
							</div>

							<div class="space-4"></div>
							
							<div class="form-group">
								<label for="status"
									class="col-sm-4 control-label">Trạng thái:</label>
								<div class="col-sm-8">
									<form:select path="status" id="status"
										class="col-xs-10 col-sm-5">
										<form:option value="" label="--Trạng thái--" />
										<form:options items="${status}" />
									</form:select>
								</div>
							</div>

							<div class="space-4"></div>

							<form:hidden path="id" id="userId" />
							
							<div class="clearfix form-actions">
								<div class="col-md-offset-4">
									<c:if test="${not empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdateNew">
											<i class="ace-icon fa fa-check bigger-110"></i> Cập nhật thành viên
										</button>
									</c:if>

									<c:if test="${empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdateNew">
											<i class="ace-icon fa fa-check bigger-110"></i> Thêm bài thành viên
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
		$('#btnAddOrUpdateNew').click(function(e) {
			e.preventDefault();
			var data = {};
			var formData = $('#formSubmit').serializeArray();
			$.each(formData, function(i, v) {
				data["" + v.name + ""] = v.value;
			});
			var id = $('#userId').val();
			if (id == "") {			
				addUser(data);
			} else {
				updateUser(data);
			} 
			
		});
		function addUser(data) {
			$
					.ajax({
						url : '${userAPI}',
						type : 'POST',
						contentType : 'application/json',
						data : JSON.stringify(data),
						dataType : 'json',
						success : function(result) {
 							
							window.location.href = "${editURL}?id=" + result.id
									+ "&message=insert_success";
						},
						error : function(error) {
							window.location.href = "${newURL}&message=error_system";
						}
					});
		}
		function updateUser(data) {
			$.ajax({
				url : '${userAPI}',
				type : 'PUT',
				contentType : 'application/json',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(result) {
					window.location.href = "${editURL}?id=" + result.id
							+ "&message=update_success";
				},
				error : function(error) {
					window.location.href = "${editURL}?id=" + data.id
							+ "&message=error_system";
				}
			});
		}; 
	</script>
</body>
</html>

