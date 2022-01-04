<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <!-- Bootstrap core CSS -->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" href="<c:url value='/template/admin/font-awesome/4.5.0/css/font-awesome.min.css' />" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/e8a9d7cbeb.js" crossorigin="anonymous"></script>
    <link href="<c:url value='/template/web/vendor/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet">

	<link rel="stylesheet" href="<c:url value='/template/admin/css/sweetalert2.min.css '/>" />
	
	<!-- fontawesom -->
	<link href="<c:url value='/template/web/fontawesome/css/all.css'/>" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="<c:url value='/template/web/css/small-business.css'/>" rel="stylesheet">
    <link href="<c:url value='/template/web/css/mystyle.css'/>" rel="stylesheet">
</head>
<body>
    <!-- Navigation - header -->
    <div class="mb-5">
        <%@include file="/common/web/header.jsp"%>
    </div>

    <!-- Page Content -->
    <div class="mt-5 pt-5">
    	<dec:body/>
    </div>
    
        <!-- Footer -->
    <%@include file="/common/web/footer.jsp"%>

    <!-- Bootstrap core JavaScript -->
    <script src="<c:url value='/template/web/vendor/jquery/jquery.min.js'/> "></script>
    <script src="<c:url value='/template/web/vendor/bootstrap/js/bootstrap.min.js'/> "></script>
    <script src="<c:url value='/template/digitalclock/digitalclock.js'/> "></script>
    
    <!-- fontawesome -->
    <script src="<c:url value='/template/web/fontawesome/js/all.js'/> "></script>
    
    <script src="<c:url value='/template/admin/js/sweetalert2.min.js'/>"></script>
    
    <!-- Pagination -->
    <script src="<c:url value='/template/paging/jquery.twbsPagination.js'/>"></script>

</body>
</html>