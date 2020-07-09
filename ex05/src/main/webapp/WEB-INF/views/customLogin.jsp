<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>Custom Login Page</h1>
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>
	
	<form method='post' action="/login">
		<div>
			<input type='text' name='username' value='admin'>
		</div>
		<div>
			<input type='password' name='password' value='admin'>
		</div>
		<div>
			<input type='checkbox' name='remember-me'>Remember Me
		</div>
		<div>
			<input type='submit'>
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
		 
</body>
</html>