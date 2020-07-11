<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Custom Login Page</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
	.login-container{
    margin-top: 5%;
    margin-bottom: 5%;
}
.login-form-1{
    padding: 5%;
    box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
}
.login-form-1 h3{
    text-align: center;
    color: #333;
}
.login-form-2{
    padding: 5%;
    background: #0062cc;
    box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
}
.login-form-2 h3{
    text-align: center;
    color: #fff;
}
.login-container form{
    padding: 10%;
}
.btnSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    border: none;
    cursor: pointer;
}
.login-form-1 .btnSubmit{
    font-weight: 600;
    color: #fff;
    background-color: #0062cc;
}
.login-form-2 .btnSubmit{
    font-weight: 600;
    color: #0062cc;
    background-color: #fff;
}
.login-form-2 .ForgetPwd{
    color: #fff;
    font-weight: 600;
    text-decoration: none;
}
.login-form-1 .ForgetPwd{
    color: #0062cc;
    font-weight: 600;
    text-decoration: none;
}
	
</style>
</head>
<body>
	<h2><c:out value="${error }"/></h2>
	<!-- <h2><c:out value="${logout }"/></h2>  -->
	
	<div class="container login-container">
            <div class="row">
                <div class="col-md-6 login-form-2">
                    <h3>Login</h3>
                    <form method='post' action="/login">
                        <div class="form-group">
                            <input type="text" class="form-control" name='username' placeholder="Your ID *" value="" autofocus/>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" name='password' placeholder="Your Password *" value="" />
                        </div>
                        <div>
							<input type='checkbox' name='remember-me'>Remember Me
						</div>
                        <div class="form-group">
                            <input type="submit" class="btnSubmit" value="Login" />
                        </div>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
						<!-- 
							csrf란
							cross-site request forgery(공격과 토큰)
							사이트간 위조방지목적으로 특정한 값의 토큰을 사용하는 방식
							CSRF를 이용해서 단순히 게시물의 조회수를 늘리는 등의 조작부터 피해자의 계정을 이용하는 다양한 공격 가능
							CSRF공격은 서버에서 받아들이는 요청을 해석하고 처리할때 어떤 출처에서 호출이 진행되었는지 따지지 않기 때문에 생기는 허점을 노리는 방식
							
							ex) <img src="www.aaa.xxx/update?grade=admin&account=123'>
							
							CSRF 토큰값을 유저꺼랑 서버꺼랑 비교해서 맞으면 요청을 받는 방식
							쿠키가 달라지면 CSRF값이 달라짐.
						 -->
                    </form>
                </div>
            </div>
        </div>
        
	<script>
		$(".btnSubmit").on("click", function(e){
			e.preventDefault();
			$("form").submit();
		});
	</script>
</body>
</html>