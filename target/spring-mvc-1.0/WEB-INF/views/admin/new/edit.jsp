<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="newURL" value="/quan-tri/bai-viet/danh-sach?page=1&limit=2" />
<c:url var="newAPI" value="/api/new" />
<c:url var="editURL" value="/quan-tri/bai-viet/chinh-sua" />

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
					<li><a href="${newURL}">Danh sách bài viết</a></li>
					<li class="active">
					<c:if test="${empty model.id}">
							Thêm bài viết
						</c:if>
						<c:if test="${not empty model.id}">
							Cập nhật bài viết	
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
								<label for="categoryCode"
									class="col-sm-2 control-label">Thể loại:</label>
								<div class="col-sm-9">
									<form:select path="categoryCode" id="categoryCode"
										class="col-xs-10 col-sm-5">
										<form:option value="" label="--Chọn thể loại--" />
										<form:options items="${categories}" />
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"
									for="form-field-1"> Tên bài viết: </label>

								<div class="col-sm-9">
									<form:input path="title" class="col-xs-10 col-sm-5" />
								</div>
							</div>

							<div class="space-4"></div>

							<div class="form-group">
								<label for="thumbnail" 
									class="col-sm-2 control-label"> Ảnh đại diện: </label>

								<div class="col-sm-9">
									<form:input type="file" path="thumbnail"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>

							<div class="space-4"></div>

							<div class="form-group">
								<label for="shortDescription"
									class="col-sm-2 control-label">Mô tả ngắn:</label>
								<div class="col-sm-10">
									<form:textarea path="shortDescription"
										class="col-xs-10 col-sm-12" rows="3" cols="10"
										id="shortDescription" />
								</div>
							</div>

							<div class="space-4"></div>

							<div class="form-group">
								<label for="content"
									class="col-sm-2 control-label">Nội dung:</label>
								<div class="col-sm-10">
									<form:textarea path="content" 
										class="col-xs-10 col-sm-12" rows="5" cols="10" 
										id="content" />
								</div>
							</div>

							<div class="space-4"></div>
							<form:hidden path="id" id="newId" />
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9">
									<c:if test="${not empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdateNew">
											<i class="ace-icon fa fa-check bigger-110"></i> Cập nhật bài
											viết
										</button>
									</c:if>

									<c:if test="${empty model.id}">
										<button class="btn btn-info" type="button"
											id="btnAddOrUpdateNew">
											<i class="ace-icon fa fa-check bigger-110"></i> Thêm bài viết
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
		var editor = '';
	  	$(document).ready(function(){
	    editor = CKEDITOR.replace( 'content');
	  	});
		$('#btnAddOrUpdateNew').click(function(e) {
			e.preventDefault();
			$("#formSubmit").submit();
			/* var data = {};
			var formData = $('#formSubmit').serializeArray();
			$.each(formData, function(i, v) {
				data["" + v.name + ""] = v.value;
			});
			data["content"] = editor.getData();
			var id = $('#newId').val();
			if (id == "") {			
				addNew(data);
			} else {
				updateNew(data);
			} */
			
		});
		/* function addNew(data) {
			$
					.ajax({
						url : '${newAPI}',
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
		function updateNew(data) {
			$.ajax({
				url : '${newAPI}',
				type : 'PUT',
				contentType : 'application/json',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(result) {
					window.location.href = "${editURL}?id=" + result.id
							+ "&message=update_success";
				},
				error : function(error) {
					window.location.href = "${editURL}?id=" + result.id
							+ "&message=error_system";
				}
			});
		}; */ 
	</script>
</body>
</html>

