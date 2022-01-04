<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
</head>
<body>
	<div class="container">

        <div class="card card-container">
            <c:if test="${param.incorrectAccount != null}">
                    <div class="alert alert-danger">
                            Username or Password incorrect
                    </div>
            </c:if>
            <c:if test="${param.accessDenied != null}">
                    <div class="alert alert-danger">
                            yot not Authorize
                    </div>
            </c:if>
            <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
            <p id="profile-name" class="profile-name-card"></p>
            <form class="form-signin" action="j_spring_security_check" method="POST">
                <span id="reauth-email" class="reauth-email"></span>
                <input type="text" id="inputEmail" class="form-control" placeholder="Tên đăng nhập" name="j_username" required autofocus>
                <input type="password" id="inputPassword" class="form-control" placeholder="Mật khẩu" name="j_password" required>
                <div id="remember" class="checkbox">
                    <label>
                        <input type="checkbox" value="remember-me"> Ghi nhớ tài khoản
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Đăng nhập</button>
            </form><!-- /form -->
            <a href="#" class="forgot-password">
                Quên mật khẩu
            </a>
        </div><!-- /card-container -->
    </div><!-- /container -->
</body>
</html>