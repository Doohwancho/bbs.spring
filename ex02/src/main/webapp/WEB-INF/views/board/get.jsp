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

					<button type="button" data-oper='modify' id="modifyBtn"
						class="btn btn-primary">Modify</button>
					<button type="button" data-oper='list' id="listBtn"
						class="btn btn-primary">List</button>
				</form>

			</div>
			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
				<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
				<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount }"/>'>
				<input type='hidden' id='type' name='type' value='<c:out value="${cri.type }"/>'/>
				<input type='hidden' id='keyword' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
			</form>
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
		$(document).ready(function() {

			var operForm = $("#operForm");

			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			});

			
			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list").submit();
			});
			 

			/*
			$("#modifyBtn").on("click", function(){
				self.location="/board/modify";
			});
			

			$("#listBtn").on("click", function() {
				self.location = "/board/list";
			});
			 */
		});
	</script>

</body>

</html>