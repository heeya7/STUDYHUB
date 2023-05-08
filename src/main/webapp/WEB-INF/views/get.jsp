<%@page import="org.springframework.ui.Model"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import ="org.hub.domain.BoardVO" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- bootstrap css -->
		<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
			rel="stylesheet"
			integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
			crossorigin="anonymous">
			
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<!-- custom css -->
		<link rel="stylesheet" href="/resources/css/main.css" type="text/css" />
		<link rel="stylesheet" href="/resources/css/get.css" type="text/css" />
		
		<script>
			var uidkeys = [];
		</script>
		<title>스터디허브</title>
	
	</head>
<link rel="icon" href="/resources/Images/profileLogo.png">
	<body>
	
		<!--  nav 태그 -->
		<%@include file="../includes/header.jsp"%>
		<!-- nav 태그 끝 -->
	
	
		 <!--게시글 기본 정보 영역-->
		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
		
		<div class="studyContent_wrapper">
			<section class="studyContent_postHeader">
			    <!--뒤로가기버튼-->
			    <svg button onclick="goBack()" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" color="808080" cursor="pointer" height="30" width="30" xmlns="http://www.w3.org/2000/svg" style="color: rgb(128, 128, 128);" margin-left="0px">
			    	<path d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path>
			    	</svg>
			
			
			
			    <!--게시글 제목-->
			    <div class="studyContent_title" name="title" ><c:out value="${board.title }" /></div>
			    <!--사용자 닉네임영역-->
			    <div class="studyContent_userAndDate">
			        <div class="studyContent_user">
					<div id="uploadResult">
					<div class='uploadResult'>
					<ul>
						<li id="photo"></li>
					</ul>													
				</div>
				
				</div>        
			            <div class="studyContent_userName" ><c:out value="${board.uname }" /></div>
			        </div>
			        <div class="studyContent_registeredDate" ><fmt:formatDate value="${board.regdate}" pattern="YYYY-MM-dd"/></div></div>
			   
			      <!-- 사용자 수정,마감,삭제  -->
			    <c:if test="${loginUser.uidKey==board.uidkey}">
			        <section class="studyButtons_buttonWrapper">
			       		<button id="closed" class="studyButtons_buttons" data-bs-toggle="modal" data-bs-target="#deadlineModal">마감</button>	
						<button id="opend" class="studyButtons_buttons" data-bs-toggle="modal" data-bs-target="#resetModal">마감취소</button>
			        	<button onclick="location.href='modify?bno=<c:out value="${board.bno}" />'" class="studyButtons_buttons">수정</button>       
			       		<button class="studyButtons_buttons" data-bs-toggle="modal" data-bs-target="#removeModal">삭제</button>
						
						<!-- 마감 Modal -->
						<div class="modal fade" id="deadlineModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
						        마감 처리 하시겠어요?
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
						        <button type="button" class="btn btn-primary" data-oper='closed'>네, 마감할게요</button>						     
						      </div>
						    </div>
						  </div>
						</div>
		
						<!-- 마감취소 Modal -->
						<div class="modal fade" id="resetModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
							   <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							   <div class="modal-body">
							        마감 취소 하시겠어요?
							   </div>
							   <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
							        <button type="button" class="btn btn-primary" data-oper='opend'>네, 취소할게요</button>
							   </div>
							   </div>
							</div>
						</div>		
		
						<!-- 삭제 Modal -->
						<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
						        작성하신 글을 삭제 하시겠어요?
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
						        <button type="button" class="btn btn-primary" onclick="location.href='remove?bno=<c:out value="${board.bno}" />'" >네, 삭제할래요</button>
						      </div>
						    </div>
						  </div>
						</div>
					</section>
				</c:if>	 
				
				
				<!-- 관리자 삭제  -->
			    <% if (session.getAttribute("loginAdmin") != null) { %>
			    
			        <section class="studyButtons_buttonWrapper">
			       		       
			       		<button class="studyButtons_buttons" data-bs-toggle="modal" data-bs-target="#removeModal">삭제</button>
		
						<!-- 삭제 Modal -->
						<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
						        글을 삭제 하시겠어요?
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
						        <button type="button" class="btn btn-primary" onclick="location.href='remove?bno=<c:out value="${board.bno}" />'" >네, 삭제할래요</button>
						      </div>
						    </div>
						  </div>
						</div>
					</section>
					
				<% } %> 	    
				  	    
			
			    <!--게시글 기본 정보 영역-->
			    <ul class="studyInfo_studyGrid">
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">진행 방식</span>
			            <span class="studyInfo_content" ><c:out value="${board.meet}"/></span>
			        </li>
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">모집 인원</span>
			            <span class="studyInfo_content"> <c:out value="${board.memberNum}"/> </span>
			        </li>
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">마감 날짜</span>
			            <span class="studyInfo_content" > <c:out value="${board.deadline}"/></span>
			        </li>
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">연락 방법</span>
			            <div class="contactPoint_contactWrapper">
			                <a class="contactPoint_link" href='https://<c:out value="${board.contactaddress}"/>' target="_blank" rel="noreferrer">
			                    <span>${board.contact}</span><img class="contactPoint_linkImg" src="https://holaworld.io/images/info/link.svg" alt=""></a>
			                 </div>
			        </li>
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">예상 기간</span>
			            <span class="studyInfo_content"><c:out value="${board.period}" /></span>
			        </li>
			            <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">사용 언어</span>
			            <ul class="studyInfo_languageList">
			                <c:set var="snamesArr" value="${fn:split(board.snames, ',') }" />
													<c:forEach items="${snamesArr }" var="sname">
														<li class="studyItem_language"><img
															class="studyItem_languageImage" title="${sname }"
															src="https://holaworld.io/images/languages/${sname }.svg"
															alt="language"></li>
													</c:forEach>
			            </ul>
			        </li>
			        <li class="studyInfo_contentWrapper">
			            <span class="studyInfo_title">모집 분야</span>
			            <ul class="studyInfo_languageList">
			            <c:set var="fnamesArr" value="${fn:split(board.fnames, ',') }" />
													<c:forEach items="${fnamesArr}" var="fname">
														<li class="studyItem_position">${fname }</li>
													</c:forEach>
			            </ul>
			        </li>
			    </ul>
			</section>  
			<!--게시글 기본 정보 영역 끝-->
			
			<!--본문 영역-->
			<div class="studyContent_postContentWrapper">
			    <h2 class="studyContent_postInfo">스터디 소개</h2>
			    <div class="studyContent_postContent">
			        ${fn:replace(board.content, replaceChar, "<br/>")}
			    </div>
			</div>
			<!--본문영역 끝-->
			
			
			<!--댓글영역-->
			<section class="studyContent_commentAndViews">
			    <div class="studyContent_postComment">
			        <div class="commentInput_commentInput">
			            <h1 class="commentInput_commentCount">${board.replycnt }개의 댓글이 있습니다.</h1>
			            <c:if test="${loginUser.uidKey ne null}">
				            <textarea id="comment" class="commentInput_commentText" placeholder="댓글을 입력하세요."></textarea>
				            <div class="commentInput_buttonWrapper">
				           		<button class="commentInput_buttonComplete" id="addReplyBtn" name="register">댓글 등록</button>
			            	</div>
			            </c:if>
			            <!--  /.panel-heading -->
						<div class="panel-body"> 
						<!--  댓글 시작 -->
							<ul class="chat" id="commentList">
							
							</ul>
							<!--  댓글 끝 -->
						</div>
						<!--  panel-body 끝 -->
						<!--  /.panel-footer -->
						<div class="panel-footer">
			
						</div>
			        </div>
			        <ul class="commentList_CommentList"></ul>
			    </div>
			</section><!--댓글영역 끝-->
			
		</div>
		
		<!-- 댓글 삭제 모달 -->
		<div class="cancelButton_wrapper" style="display: none">
			<div>댓글을 삭제 하시겠어요?</div>
			<section class="cancelButton_buttons">
				<button class="cancelButton_cancelButton">아니요</button>
				<button class="cancelButton_registerButton">네, 삭제할래요</button>
			</section>
		</div>
	
		<!--  reply test -->
		<div><c:out value="${reply }"/></div>
	</body>
<!-- body 끝 -->

<!-- bootstrap js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
</script>
<!-- 댓글 js -->
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
uidkeys.push('${board.uidkey}');
var bnoValue = '<c:out value="${board.bno}"/>'; // bno값 불러오기
var unameValue = '<c:out value="${loginUser.unickName}" />'; // uname 값 불러오기
var adminValue = '<c:out value="${loginAdmin.adminId}" />' // admin 값 불러오기
var replyUL = $(".chat"); 
var userImages = {};

$(document).ready(function() {
	
	(function() { // 즉시 실행 함수
		// uidkey는 글마다 다르므로 배열로 저장해서 반복문으로 처리 
		uidkeys.forEach(function(uidKey, index) {
			$.getJSON("/user/getAttach", {uidKey:uidKey}, function(attach) {
				console.log(attach);
				var str = "";
				
				if(attach == null){
					str += "<li><div><img width='30px' height='30px' aspect-ratio='auto 30/30' display='block' border-radius='50%' object-fit='cover'  src='/resources/Images/profileLogo.png'></div></li>";					
				} else {						
						//image type
						if(attach.fileType) {
							var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_" + attach.uuid +"_"+attach.fileName);
							
							str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+
							"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
							str += "<img width='30px' height='30px' aspect-ratio='auto 30/30' display='block' border-radius='50%' object-fit='cover'  src='/display?fileName="+fileCallPath+"'>";
							str += "</div>";
							str += "</li>";
						} 				
				}
				$(".uploadResult ul").eq(index).html(str);
			}); // end getjson
		});
	})();// end function
	
	// jsh <nav> 태그 사용자 이미지 불러오기
	(function(){
		
		var uidKey = '<c:out value="${ loginUser.uidKey }"/>';
		console.log(uidKey);
		var targetA = $("#dropImage");
		
		$.getJSON("/user/getAttach", {uidKey:uidKey}, function(attach){
			console.log(attach);
			if(attach == null){				
				 targetA.html("<img width='30px' height='30px' style='border-radius: 50%' src='/resources/Images/profileLogo.png'>");
			} else {
					var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
					targetA.html("<img width='40px' height='40px' style='border-radius: 50%' width='40px' src='/display?fileName="+fileCallPath+"'>");
			}			 
		}); //end getjson						
						
		
	})();//end function		

}); // end ready	
		
	
</script>

<script>
// 뒤로가기 화살표 눌렀을 때 함수
function goBack() {
	  window.history.back();
	}
// 수정 눌렀을 때 폼 보여주기 함수 
function showEditCommentForm(rno) {
  var commentItem = document.querySelector("[data-rno='" + rno + "']");
  var commentContent = commentItem.querySelector(".commentItem_commentContent");
  var commentText = commentContent.querySelector("p").textContent;
  var editInput = commentItem.querySelector(".commentItem_modifyInput");
  var commentInputButton = commentItem.querySelector(".commentItem_commentInputButton_");

  editInput.value = commentText;
  editInput.setAttribute("type", "text");
  commentInputButton.style.display = "flex";

  // 수정 취소 버튼
  var canBtn = commentItem.querySelector(".commentItem_buttonCancel");
  canBtn.addEventListener("click", function() {
    editInput.style.display = "none";
    commentInputButton.style.display = "none";
  });

  // 수정 완료 버튼
  var sucBtn = commentItem.querySelector(".commentItem_buttonComplete");
  sucBtn.addEventListener("click", function() {
    var editedComment = editInput.value;
    var rno = commentItem.getAttribute("data-rno");
    var updatedReply = { rno: rno, reply: editedComment };
    replyService.update(updatedReply, function (result) {
      alert(result);
      // 수정된 내용으로 화면 갱신
      commentContent.innerHTML = "<p class='commentItem_commentContent'>" + editedComment + "</p>";
      // 댓글 수정 입력 폼과 완료/취소 버튼 숨김
      editInput.style.display = "none";
      commentInputButton.style.display = "none";
    }); // end replyService.update
  });// end function sucBtn.onClick
}

// 댓글 수정 버튼 눌렀을 때
$('.commentItem_buttonModify').on("click", function() {
  var rno = $(this).closest('.commentItem_commentContainer').attr("data-rno");
  showEditCommentForm(rno);
});



	 
	 // kdh 댓글 삭제
	 function deleteReply(rno) {
		// 댓글 항목(li) 선택
	    var commentItem = $(this).closest(".commentItem_commentContainer");
	 	
		// 댓글 삭제 요청
   		replyService.remove(rno, function(result){
   	        
   	      alert(result);
   	   	  location.reload();
   	      
   	  });//end ReplyService
	 }
	 
	$(document).ready(function() {
		showList(1);
		    
		// 목록 보여주는 함수
		function showList(page){ 
			console.log("show list " + page);
		    
			// reply.js에 추가되어있는 replyService함수 호출
		    replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {
		      
			    console.log("replyCnt: "+ replyCnt );
			    console.log("list: " + list);
			    console.log(list);
			    
			    if(page == -1){
			      pageNum = Math.ceil(replyCnt/10.0);
			      showList(pageNum);
			      return;
			    }
		      
			     var str="";
			     
			     if(list == null || list.length == 0){
			       return;
			     }
			     
				for (var i = 0, len = list.length || 0; i < len; i++) {
					// 각 댓글 항목을 구성하는 HTML 코드 작성
					var commentId = 'comment_' + list[i].rno;
					str +="<li class='commentItem_commentContainer' data-rno='"+list[i].rno+"'>";
					str +="<section class='commentItem_commentHeader'>";
					str +="  <div class='commentItem_avatarWrapper_'>"
					// 사용자 이미지 추가
					str +="		<div class='commentItem_commentInfo'><div class='commentItem_title'>"
					str +="			<div class='commentItem_userNickname'>"+list[i].replyer+"</div>"
					str +="			<div class='commentItem_registeredDate'>"+replyService.displayTime(list[i].replyDate)+"</div>"
					str +="		</div></div></div>"
					if (unameValue == list[i].replyer) {
						str += "<section class='commentButtons_buttonWrapper'>";
						str += "<button id='modBtn_" + list[i].rno + "' class='commentButtons_buttons' onclick='showEditCommentForm(" + list[i].rno + ")'>수정</button> ";
						str += "<button id='remBtn' class='commentButtons_buttons' onclick='deleteReply("+list[i].rno+")'>삭제</button>";
						str += "</section>";
					}else if(adminValue !=  null) {
						str += "<section class='commentButtons_buttonWrapper'>";
						str += "<button id='remBtn' class='commentButtons_buttons' onclick='deleteReply("+list[i].rno+")'>삭제</button>";
						str += "</section>";
					}
					
					str +="</section><section class='commentItem_commentContent'><p class='commentItem_commentContent'>"+list[i].reply+"</p>"
					// 현재 로그인한 사용자와 댓글 작성자가 같은 경우에만 수정/삭제 버튼 추가
					if (unameValue == list[i].replyer) {
						// 댓글 수정 입력 폼 추가
						str += "<div><input class='commentItem_modifyInput' type='hidden' name='contentInput'"
						str += "placeholder='"+list[i].reply+"' value='"+list[i].reply+"' >"
						str += "<div class='commentItem_commentInputButton' style='display: none;'>";
						str += "<button id='canBtn' class='commentItem_buttonCancel' name='cancle'>취소</button>";
						str += "<button class='commentItem_buttonComplete' name='complete'>완료</button>";
						str += "</div></div>";
					}
					str += "</section></li>";
				}// end for 
		    
			     // 0426 댓글 수정부분 추가
			    replyUL.html(str);
				showReplyPage(replyCnt);
			});//end getList
		}//end showList
		
		
		 
		 
	    var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	    
	    // 댓글 페이지네이션
	    function showReplyPage(replyCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }// end function showReplyPage
	     
	    replyPageFooter.on("click","li a", function(e){
	       e.preventDefault();
	       console.log("page click");
	       
	       var targetPageNum = $(this).attr("href");
	       
	       console.log("targetPageNum: " + targetPageNum);
	       
	       pageNum = targetPageNum;
	       
	       showList(pageNum);
	     }); //end replyPageFooter
   
	    // 4-25 추가
	    var comment = $('#comment');

	    $("#addReplyBtn").on("click",function(e){
	      
	      var reply = {
	            reply: comment.val(),
	            replyer:unameValue,
	            bno:bnoValue
	          };
	      replyService.add(reply, function(result){
	        
	        alert(result);
	        		        
	        showList(1);
	        showList(-1);
	        
	      });//end replyService.add 
	    });//end onClick function
	});
    
</script>

<script type="text/javascript">
$(document).ready(function() {
  
  var operForm = $("#operForm"); 
  
  $("button[data-oper='modify']").on("click", function(e){
    
    operForm.attr("action","/board/modify").submit();
    
  });
  
    
  $("button[data-oper='list']").on("click", function(e){
    
    operForm.find("#bno").remove();
    operForm.attr("action","/board/main")
    operForm.submit();
    
  });
  /* 마감 기능 */
  // '마감' 또는 '마감취소' 버튼 display 기존값으로 초기화
	var status = '<c:out value="${board.status}"/>'; // expireck
	if (status == 'closed') {
	    $("#closed").css("display", "none");
	} else {
		$("#opend").css("display", "none");
	}
	
	// "네, 마감할게요." 버튼 눌렀을 시
	$("button[data-oper='closed']").on("click", function(e){		
		  	var bnoValue = '<c:out value="${board.bno}"/>'; // bno
		  	var data = {bno : bnoValue};
		  	
			$.ajax({
				type : "get",
				url : "/board/upClose",
				data : data,
				success : function(result){
					console.log("성공 여부" + result);
					if(result != 'fail'){
						$("#closed").css("display", "none");
						$("#opend").css("display","inline-block");
					}
				}
			});		
			$("#deadlineModal").modal('hide');
	});
	
	// "마감 취소" 버튼 눌렀을 시
	$("button[data-oper='opend']").on("click", function(e){		
		  	var bnoValue = '<c:out value="${board.bno}"/>'; // bno
		  	var data = {bno : bnoValue};
		  	
			$.ajax({
				type : "get",
				url : "/board/upOpen",
				data : data,
				success : function(result){
					console.log("성공 여부" + result);
					if(result != 'fail'){
						$("#opend").css("display", "none");
						$("#closed").css("display","inline-block");
					}
				}
			});			
			$("#resetModal").modal('hide');
	}); // end 버튼
});
</script>


</html>