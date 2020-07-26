<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>Hello, BattleGround!</title>

<style>
	.uploadResult{
		width:100%;
		background-color:gray;
	}
	
	.uploadResult ul{
		display:flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img{
		width: 100px;
	}
	
	.uploadResult ul li span{
		color: white;
	}
	
	
</style>

</head>

<body>
   	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="list">Autochess</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link" href="list">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item">
						<form id='registerId' method='get' action="/customLogin">
							<a class="nav-link">Register</a>
							<input type="hidden" name="registerLoginSelector" value="registerActive" />		
						</form>
					</li>
					<li class="nav-item">
						<form id='loginId' method='get' action="/customLogin">
							<a class="nav-link">Login</a>
							<input type="hidden" name="registerLoginSelector" value="loginActive" />		
						</form> 
					</li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<a href="#" onclick="document.getElementById('logout-form').submit();">Sign out</a>
						<form id="logout-form" action='<c:url value='/customLogout'/>' method="POST">
						   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
						</form> 
					</li> 
					<!-- 
					<li class="nav-item">
					<form id='logoutId' method='post' action="/customLogout">
						<a class="nav-link">Logout</a>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />		
					</form>
					</li>
					 -->
				</sec:authorize>
			</ul>
		</div>
	</nav> <!-- end of nav-bar -->

	<div class="c1" style="padding-left: 1rem;">
		<h1>Board Get</h1>
		<br>

		<div class="card w-75 border-secondary mb-3">
			<h5 class="card-header">Get</h5>
			<div class="card-body">
				<form role="form">

					<div class="form-group">
						<label for="labelBno">Bno</label> <input type="text"
							class="form-control" name="bno" placeholder="Bno"
							value='<c:out value="${board.bno }"/>' readonly>
					</div>

					<div class="form-group form-group col-md-20">
						<label for="labelTitle">Title</label> <input type="text"
							class="form-control" name="title" placeholder="write title"
							value='<c:out value="${board.title }"/>' readonly>
					</div>


					<!-- textarea에 엔터치거나 스페이스있으면 웹에서도 그렇게 뜸!! 주의!! -->
					<div class="form-group">
						<label for="labelTextArea">Text Area</label>
						<textarea class="form-control" rows="5" name="content" placeholder="write content" readonly><c:out value="${board.content }" /></textarea>
					</div>

					<div class="form-group">
						<label for="labelWriter">Writer</label> <input type="text"
							class="form-control" name="writer" placeholder="write writer"
							value='<c:out value="${board.writer }"/>' readonly>
					</div>
					
					<sec:authentication property="principal" var="pinfo"/>
					
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<button type="button" data-oper='modify' id="modifyBtn" class="btn btn-primary">Modify</button>
						</c:if>
					</sec:authorize>
					
					<button type="button" data-oper='list' id="listBtn"
						class="btn btn-primary">List</button>
							<!-- end of button -->
				</form> <!-- end of a post -->

			</div>
			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
				<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
				<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount }"/>'>
				<input type='hidden' id='type' name='type' value='<c:out value="${cri.type }"/>'/>
				<input type='hidden' id='keyword' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
			</form>
			
		</div> <!-- end of hidden info regarding post -->
	</div> <!-- end of the entire div -->
		 
	
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
		}
	</script>
	 
</body>

</html>