var actionForm = $("#actionForm");
	
$(".page-item a").on("click", function(e) {
	e.preventDefault();
	console.log('click');
	pageNumber = $(this).attr("href");
	
	// data에 선택된 관심스택, 모집분야 값들을 담는다
	let data = {pageNum: pageNumber};
			
	// filter 처리할 ajax
	$.ajax({
		type: "GET", // 요청 방식
		url: "/board/mainWithFilter", //요청 URL
		data: data, // 요청 데이터
		success: function(data) {
			// 요청 성공 시 콜백 함수
			$('#main-filter').html(data);
		}, 
		error: function(xhr, status, error) {
			console.log(status + ": " + error);
		}
	});		
});
	
$(".move").on("click", function(e) {
	e.preventDefault();
	// kdh 0428 bno값이 있다면 중복해서 등록되지 않게끔 지우게 하는 코드
	if($("input[name='bno']").length) {
		$("input[name='bno']").remove();
	}
	actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
	actionForm.attr("action", "/board/get");
	actionForm.submit();
});

$(document).ready(function() {
	(function() { // 즉시 실행 함수
		// uidkey는 글마다 다르므로 배열로 저장해서 반복문으로 처리 
		uidkeys.forEach(function(uidKey, index) {
			$.getJSON("/user/getAttach", {uidKey:uidKey}, function(attach) {
				console.log(attach);
				var str = "";
				
				if(attach == null){
					str += "<li><div><img width='30px' height='30px' aspect-ratio='auto 30/30' display='block' style='border-radius: 50%' object-fit='cover'  src='/resources/Images/profileLogo.png'></div></li>";					
				} else {						
						//image type
						if(attach.fileType) {
							var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_" + attach.uuid +"_"+attach.fileName);
							
							str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+
							"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
							str += "<img width='30px' height='30px' aspect-ratio='auto 30/30' display='block' style='border-radius: 50%' object-fit='cover'  src='/display?fileName="+fileCallPath+"'>";
							str += "</div>";
							str += "</li>";
						} 				
				}
				$(".uploadResult ul").eq(index).html(str);
			}); // end getjson
		});
	})();// end function
});

	// 버튼통해서 관심글 등록하기 진행중...
	var bookmark = $('.studyItem_bookmark');

	bookmark.on("click", function(e) {
	    e.preventDefault();
	    
		// 해당 글 bno 값 얻기
		var bookmarkBno = $(this).closest('.card-body').attr('href');
		// 개발자 도구 콘솔창에서 bno 값 확인하는 용도
		console.log(bookmarkBno);
		// data에 담기
		let data = { bno: bookmarkBno };
		
	    var heartStatus = $(this).attr('src');
	    
	    if(heartStatus == "/resources/Images/nonfilledheart.png"){
	    	
	        $(this).attr("src", "/resources/Images/filledheart.png"); 
	        $.ajax({
	            type: "POST",
	            url: "/user/interest/insert",
	            data: data,
	            success: function(data) {
	            	alert("관심글 목록에 추가되었습니다.");
	            }
	        });
	    } else {
	        $(this).attr("src", "/resources/Images/nonfilledheart.png");
	        $.ajax({
	            type: "POST",
	            url: "/user/interest/delete",
	            data: data,
	            success: function(data) {
	            	alert("관심글 목록에서 삭제되었습니다.");
	            }
	        });
	    }
	    return false;
	});