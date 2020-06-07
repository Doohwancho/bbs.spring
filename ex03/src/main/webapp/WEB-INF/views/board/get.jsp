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

<!-- 
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">	
	 -->
	 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

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

					<button type="button" data-oper='modify' id="modifyBtn"
						class="btn btn-primary">Modify</button>
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
		
		  
		<div class="card w-75 border-secondary mb-3" style="width: 18rem;"> 
		  <div class="card-header"> 
		    	댓글 
		    	<button type="button" id = "addReplyBtn" class="btn btn-success float-right">New Reply</button>
		  </div> <!-- button - new reply -->
		  
		  <ul class="list-group list-group-flush" id = "chat">
		  	<!-- 
		    <li class="list-group-item">
		    	<div class="d-flex w-100 justify-content-between">
			    	<h5 class='mb-1'>댓글돌이</h5>
					<small>2020년 1월1일</small>
				</div>
				<p class='mb-1'>안녕? 이건 내용이야</p> 
		    </li>
		     --> 
		  </ul>
		</div> <!-- end of reply -->
		
		<div id="replyPagination">
			<!-- 
			<nav aria-label="..."> 
			  <ul class="pagination w-75 border-secondary mb-3 justify-content-end">
			    <li class="page-item disabled">
			      <a class="page-link" href="#" tabindex="-1">Previous</a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item active">
			      <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav> 
			 -->
		</div> <!-- end of reply-pagination -->
	</div> <!-- end of the entire div -->
	
	<div class="modal" id = "myModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Reply Modal</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
			  <div class="form-group">
			    <label for="replyer">Replyer</label>
			    <input type="text" class="form-control" id="modalReplyer">
			  </div>
			  <div class="form-group">
			    <label for="reply">Reply</label>
			    <textarea class="form-control" id="modalReply" rows="3"></textarea>
			  </div>
			  
			  <div class="form-group" id="modalReplyDate">
			    <label for="replyDate">Reply Date</label>
			    <input type="text" class="form-control">
			  </div>
			  
			  	<!-- 
			    <label for="example-datetime-local-input" class="form-group" id="modalReplyDate">Date and time</label>
				  <div class="col-10">
				    <input class="form-control" type="datetime-local" value="2011-08-19T13:45:00" id="example-datetime-local-input">
				 </div>
				 -->
			</form>
	      </div>
	      <div class="modal-footer">
	      	<button type="submit" id="modalModifyBtn" class="btn btn-warning">Modify</button>
	      	<button type="submit" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
	        <button type="submit" id="modalRegisterBtn" class="btn btn-primary">Register</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div> <!-- end of reply-modal -->
	


	<!-- 
	<script
	  src="https://code.jquery.com/jquery-3.5.1.js"
	  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	  crossorigin="anonymous"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
		
		 -->
		 
	
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	<script>
		
		/*
		//for replyService add test
		replyService.add(
			{reply:"잘좀해봐", replyer:"오뻐", bno:bnoValue}
			,
			function(result){
				alert("RESULT: "+ result);
			}
		);
		*/
		
		
		/*
		replyService.getList({bno:bnoValue, page:1}, function(list){
			
			console.log("안됬나?");
		
			for(var i = 0, len=list.length||0; i<len; i++){
				console.log(list[i]);
			}		
		});
		*/
		
		/*
		replyService.remove(37, function(count){
			console.log(".remove()에 도착했다?");
			console.log("count: "+count);
			
			if(count === "success"){
				alert("REMOVED!");
			}
			
		}, function(err){
			alert("ERROR.....");
		});
		*/
		
		/*
		replyService.update({
			rno:35,
			bno:bnoValue,
			reply:"헐ㅋ"
		}, function(result){
			console.log(".update()에 도착했다?");
			console.log(result);
			
			if(result === "success"){
				alert("UPDATED!");
			}
		}, function(err){
			alert("ERROR... update failed!");
		});
		*/
		
		/*
		replyService.get(35, function(data){
			console.log(data);
		});
		*/
		
		
	</script>
	 

	
	<script type="text/javascript">
		$(document).ready(function() {

			//modify & back to list
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
			
			//show a list of replies
			var bnoValue = '<c:out value="${board.bno}"/>';
			
			var pageNum = 1; 
			
			var replyURL = $("#chat");
			
			
			showList(1);
			
			function showList(page){
				
				replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list){
					
					console.log("replyCnt: "+replyCnt);
					console.log("list: ");
					console.log(list);
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt / 10.0);
						showList(pageNum);
						return;
					}
					
					var str = "";
					if(list == null || list.length == 0){
						replyURL.html("");
						return; 
					}
					for(var i = 0, len=list.length||0; i<len; i++){
						str += "<li class='list-group-item' data-rno='"+ list[i].rno +"'>";
						str += "<div class='d-flex w-100 justify-content-between'>";
						str += "<h5 class='mb-1'>" + list[i].replyer + "</h5>";
						str += "<small>"+ moment(list[i].replyDate).format("YYYY-MM-DD HH:mm:ss") +"</small></div>"
						str += "<p class='mb-1'>"+ list[i].reply +"</p></li>";
					} 
					replyURL.html("");
					replyURL.html(str);
					
					showReplyPage(replyCnt);
				}); //end callback func of showList();
			} //end showList()
			
			
			var replyPageFooter = $("#replyPagination");
			
			//reply pagination
			function showReplyPage(replyCnt){
				var endNum = Math.ceil(pageNum/10.0) * 10;
				var startNum = endNum-9;
				
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt/10.0);
				}
				
				if(endNum * 10 < replyCnt){
					next = true;
				}
				
				//console.log("showReplyPage(replyCnt) startNum: "+startNum+" endNum: "+endNum);
				/*
				<nav aria-label="..."> 
				  <ul class="pagination w-75 border-secondary mb-3 justify-content-end">
				    <li class="page-item disabled">
				      <a class="page-link" href="#" tabindex="-1">Previous</a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item active">
				      <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item">
				      <a class="page-link" href="#">Next</a>
				    </li>
				  </ul>
				</nav> 
				*/
				var str = "<ul class='pagination w-75 border-secondary mb-3 justify-content-end'>";
				
				if(prev){
					str += "<li class='page-item'><a class='page-link' href='" + (startNum-1)  +"' tabindex='-1'>Previous</a></li>";
				}
				
				for(var i = startNum; i <= endNum; i++){
					var active = pageNum == i? "active":"";
					
					str += "<li class='page-item "+ active +"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				}
		
				if(next){
					str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
				}
				
				str += "</ul>";
				
				//console.log(str);
				
				replyPageFooter.html(str);
			}
			
			
			

			
			var modal = $('#myModal');
			var modalInputReply = modal.find("#modalReply");
			var modalInputReplyer = modal.find("#modalReplyer");
			var modalInputReplyDate = modal.find("#modalReplyDate");
			
			var modalModifyBtn = modal.find("#modalModifyBtn");
			var modalRemoveBtn = modal.find("#modalRemoveBtn");
			var modalRegisterBtn = modal.find("#modalRegisterBtn");
			
			
			 
			//when click "new reply"
			$("#addReplyBtn").on("click", function(){
				modalInputReply.val("");
				modalInputReplyer.val("");
				modalInputReplyDate.hide();
				modalModifyBtn.hide();
				modalRemoveBtn.hide(); 
				modalRegisterBtn.show();
				modal.modal('toggle');
			});
			
			//when click "register" on "new reply"
			$("#modalRegisterBtn").on("click", function(){
				var modalReplyerContent = modalInputReplyer.val(); 
				var modalReplyContent = modalInputReply.val();
				
				replyService.add(
					{reply:modalReplyContent, replyer:modalReplyerContent, bno:bnoValue}
					,
					function(result){
						alert("RESULT: "+ result);
					}
				);
				
				modalInputReply.val("");
				modalInputReplyer.val("");
				modal.modal("hide");
				//window.location.reload(); //page전체 refresh안하고 댓글 업데이트
				showList(-1);
			});
			
			
			
			
			//when click a reply
			replyURL.on("click", "li", function(e){ //왜 굳이 <li>에 이벤트 위임해주는거야?

				var rno = $(this).data("rno");
				
				replyService.get(rno, function(data){
					modal.data("rno", rno);
					
					modalModifyBtn.show();
					modalRemoveBtn.show();
					modalRegisterBtn.hide();
					modalInputReplyDate.show();
					
					modalInputReplyer.val(data.replyer); 
					modalInputReply.val(data.reply);
					modalInputReplyDate.find("input").val(moment(data.replyDate).format("YYYY-MM-DD HH:mm:ss")).attr("readonly","readonly");
					
					modal.modal('toggle');
					
				});
			});
			
			//click a reply -> modify (내용 reply만 바뀜)
			modalModifyBtn.on("click", function(e){
				var reply = {rno : modal.data("rno"), reply: modalInputReply.val()};
				
				replyService.update(reply, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			
			
			//click a reply -> remove
			modalRemoveBtn.on("click", function(e){
				replyService.remove(modal.data("rno"), function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			
			//click a reply pagination
			replyPageFooter.on("click","li a", function(e){ //왜 "li a"로 이벤트를 위임하는가?
				e.preventDefault();
				//console.log("page click");
				
				var targetPageNum = $(this).attr("href");
				//console.log("targetPageNum: "+ targetPageNum);
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			});
		});
	</script>
	 
</body>

</html>