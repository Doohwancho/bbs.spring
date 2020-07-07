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
	<h1>Custom Logout Page</h1>
	
	<form method='post' action="/customLogout">

	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	<button>로그아웃</button>
	</form>
		 
</body>
</html>