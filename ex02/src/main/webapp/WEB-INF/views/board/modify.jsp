<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">



<title>Hello, Autochess!</title>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Autochess</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link" href="#">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Register</a>
				</li>
			</ul>
		</div>
	</nav>

	<div class="c1" style="padding-left: 1rem;">
		<h1>Board Register</h1>
		<br>

		<div class="card w-75 border-secondary mb-3">
			<h5 class="card-header">Register</h5>
			<div class="card-body">
			
				<form role="form" action="/board/modify" method="post">
				
					<div class="form-group">
						<label for="exampleInputPassword1">Bno</label> <input
							type="text" class="form-control" id="exampleInputPassword1"
							name="bno" placeholder="Bno" value='<c:out value="${board.bno }"/>' readonly>
					</div>
					
					<div class="form-group form-group col-md-20">
						<label for="exampleInputPassword1">Title</label> 
						<input type="text" class="form-control" id="exampleInputPassword1"
							name="title" placeholder="write title" value='<c:out value="${board.title }"/>'>
					</div>
					<div class="form-group"><label for="exampleFormControlTextarea1">Text Area</label><textarea class="form-control" rows="5" name="content" placeholder="write content"><c:out value="${board.content }"/></textarea></div>
	
					<div class="form-group">
						<label for="exampleInputPassword1">Writer</label> <input
							type="text" class="form-control" id="exampleInputPassword1"
							name="writer" placeholder="write writer" value='<c:out value="${board.writer }"/>' readonly>
					</div>
					
					<div class="form-group">
						<label for="exampleInputPassword1">regdate</label> <input
							type="text" class="form-control" id="exampleInputPassword1"
							name="regdate" placeholder="write writer" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate }"/>' readonly>
					</div>
					
					<div class="form-group">
						<label for="exampleInputPassword1">updateDate</label> <input
							type="text" class="form-control" id="exampleInputPassword1"
							name="updateDate" placeholder="write writer" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate }"/>' readonly>
					</div>
	
					<button type="submit" data-oper='modify' class="btn btn-primary">Modify</button>
					<button type="submit" data-oper='remove' class="btn btn-primary">Remove</button>
					<button type="submit" data-oper='list' class="btn btn-primary">List</button>
					
					<input type='hidden' name='bno' value='<c:out value="${board.bno }"/>'>
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'/>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
		
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form");
			
			$('button').on("click", function(e){
				/*
					글을 작성할때나, 회원가입을 할때 버튼 한번 클릭할때마다 페이지가 쭉 위로 올라가는 경험을 해보신분들은 그 짜증스러움을 익히 아시리라 생각합니다. ㅠㅠ
					이 브라우저 행동을 막기위해서 사용하는게 preventDefault 입니다.
					preventDefault 는 a 태그 처럼 클릭 이벤트 외에 별도의 브라우저 행동을 막기 위해 사용됩니다.
				*/
				e.preventDefault(); 
				
				var operation = $(this).data("oper");
				
				console.log(operation);
				
				if(operation === 'remove'){
					formObj.attr("action", "/board/remove");
				} else if(operation === 'list'){
					//move to list
					formObj.attr("action", "/board/list").attr("method","get");
					
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var keywordTag = $("input[name='keyword']").clone();
					var typeTag = $("input[name='type']").clone();
					
					formObj.empty();
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(keywordTag);
					formObj.append(typeTag);
				}
				formObj.submit();
			});
		});
	
	</script>
</body>

</html>