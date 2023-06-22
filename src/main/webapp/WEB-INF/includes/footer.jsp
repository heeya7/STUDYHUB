<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

 
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
</script>
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
	
	<script type="text/javascript">
    $(document).ready(function() {
        var result = '<c:out value="${registerResult}"/>';
        if(!(result==''))
            alert("게시물이 등록되었습니다!");
    });
</script>
	<script type="text/javascript">
    $(document).ready(function() {
        var result = '<c:out value="${modifyResult}"/>';
        if(!(result==''))
            alert("글 수정이 완료되었습니다!");
    });
</script>

	<script type="text/javascript">
    $(document).ready(function() {
        var result = '<c:out value="${removeResult}"/>';
        if(!(result==''))
            alert("글 삭제가 완료되었습니다!");
    });
</script>

<script type="text/javascript">
    $(document).ready(function() {
        var result = '<c:out value="${CloseResult}"/>';
        if(!(result==''))
            alert("글 마감 처리가 완료되었습니다!");
    });
</script>
<script>
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
	
	// jsh <nav> 태그 사용자 이미지 불러오기
	(function(){
		
		var uidKey = '<c:out value="${ loginUser.uidKey }"/>';
		console.log(uidKey);
		var targetA = $("#dropImage");
		
		$.getJSON("/user/getAttach", {uidKey:uidKey}, function(attach){
			console.log(attach);
			if(attach != null){
				var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
				targetA.html("<img width='40px' height='40px' style='border-radius: 50%' width='40px' src='/display?fileName="+fileCallPath+"'>");
			}		 
		}); //end getjson						
						
		
	})();//end function	

	// 버튼통해서 관심글 등록하기 진행중...
	var bookmark = $('.studyItem_bookmark');

	bookmark.on("click", function(e) {
	    e.preventDefault();
	    
		// 해당 글 bno 값 얻기
		var bookmarkBno = $(this).closest('.card-body').attr('href');
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
		
		
	
	// 카테고리 변수
	let $languageBarArray = $('ul.LanguageBar_languages li');
	$languageBarArray.hide();
	category(0, 11);


	// 인기 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(0)').click(function() {
		$languageBarArray.hide(); // 모든 li 숨기기
		category(0, 11); // 인기 카테고리의 li만 보이기
		
	 // 모든 li에서 Category_selectedCategory 클래스 제거
    	$('.Category_categories li').removeClass('Category_selectedCategory');
    	// 클릭한 li에 Category_selectedCategory 클래스 추가
    	$(this).addClass('Category_selectedCategory');
	});

	// 프론트엔드 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(1)').click(function() {
		$('.Category_categories li').removeClass('Category_selectedCategory');
	    	// 클릭한 li에 Category_selectedCategory 클래스 추가
	    $(this).addClass('Category_selectedCategory');
	    $languageBarArray.hide(); // 모든 li 숨기기
	  	category(0, 7) // 프론트엔드 카테고리의 li만 보이기
	});

	// 백엔드 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(2)').click(function() {
		$('.Category_categories li').removeClass('Category_selectedCategory');
	    // 클릭한 li에 Category_selectedCategory 클래스 추가
		$(this).addClass('Category_selectedCategory');
	    $languageBarArray.hide(); // 모든 li 숨기기
	 	// 백엔드 카테고리의 li만 보이기
	    category(7,20)
	});

	// 모바일 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(3)').click(function() {
		$('.Category_categories li').removeClass('Category_selectedCategory');
	   	// 클릭한 li에 Category_selectedCategory 클래스 추가
	   	$(this).addClass('Category_selectedCategory');
	   	$languageBarArray.hide(); // 모든 li 숨기기
	   	$('ul.LanguageBar_languages li:eq(11)').show();
		// 모바일 카테고리의 li만 보이기
		category(20, 24)
	});

	  // 기타 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(4)').click(function() {
		$('.Category_categories li').removeClass('Category_selectedCategory');
		// 클릭한 li에 Category_selectedCategory__1J7es 클래스 추가
		$(this).addClass('Category_selectedCategory');
		$languageBarArray.hide();
		category(24,32);
	});
	  
	  // 모두보기 카테고리를 클릭할 경우
	$('li.Category_categoryItem:eq(5)').click(function() {
		$('.Category_categories li').removeClass('Category_selectedCategory');
	    // 클릭한 li에 Category_selectedCategory__1J7es 클래스 추가
		$(this).addClass('Category_selectedCategory');
	    $languageBarArray.show(); // 모든 li 보이기
	});

	function category(a, b) {
		for(let i=a; i<b; i++) {
			$languageBarArray.eq(i).show();
		}
	}
	
	
	var result='<c:out value="${result}"/>';
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		if(result==='' || history.state) {
			return;
		}
		
		if(parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
	$("#regBtn").on("click", function() {
		self.location="/board/register";
	});
	
	var actionForm = $("#actionForm");
	
	$(".page-item a").on("click", function(e) {
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
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
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e) {
		if(!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
});
// 화면 상단으로 올리기 버튼
$(function() {
	var btn = $('.Topbutton_topButton');
	
	$(window).scroll(function () {
		if($(window).scrollTop() > 700) {
			// 스크롤을 300포인트 이상하면 버튼 보여줌
			btn.show();
		} else {
			// 스크롤을 300포인트 이하면 버튼을 숨김
			btn.hide();
		}
	});
	// 버튼을 클릭하면 화면 상단으로 이동
	// 이동하는 속도는 300(0.3초)
	btn.on('click', function(e) {
		e.preventDefault();
		$('html, body').animate({scrollTop:0}, '1000');
	});
});

	/* 필터 관련 변수 모음 */
	let isFirst = true;
	let count = 0;
	var selectedClass = 'LanguageBar_full';
	var otherClasses = '.LanguageBar_languageIcon:not(.' + selectedClass	+ ')';
	// 기술 스택
	let filter = [];
	// 모집 분야(포지션)
	var position = $('#position').val();
	// 모집중 토글
	var deadlineToggle = true;
	
	// 필터 초기화 버튼 누르면 홈페이지 새로고침
	$('#root > section > div.SelectedLanguage_selectedWrapper > ul > li:last-child').click(function() {
		location.reload();
	});
	
	// 스택 아이콘 클릭 이벤트
	$('#root > section > ul.LanguageBar_languages > li').click(function() {
		// 스택 아이콘을 처음 눌렀을 때 발생하는 이벤트
		if (isFirst) {
			isFirst = false;
			$('.LanguageBar_languageIcon').removeClass(selectedClass).addClass('LanguageBar_transparent');
		}

		let $this = $(this);
		let language = $this.text();
		
		// 스택 아이콘이 눌러져 있었다면 count 를 하나 줄이고 
		// toogleLanguageBar의 Status를 inactive로 변경
		// LanguageFilter를 삭제
		if ($this.hasClass(selectedClass)) {
			count--;
			toogleLanguageBar($this, "inactive");
			removeLanguageFilter(language);
		// 그렇지 않다면 count를 늘리고 
		// toogleLanguageBar의 Status를 active로 변경,
		// languageFilter를 등록
		// 필터 초기화 버튼 보이게 하기
		} else {
			count++;
			toogleLanguageBar($this, "active");
			addLanguageFilter(language);
			
			// 필터초기화 버튼
			$('#root > section > div.SelectedLanguage_selectedWrapper > ul > li:last-child').css("display", "flex");
		}
		// data 배열안에 filter 라는 이름에 필터 값을 담는다
		mainfilter();
		
		// 필터를 다 해제했을 때 흐리게 되었던 필터들 다시 제대로 모든 필터 보이게 끔 하고, 필터초기화 버튼 안보이게 처리
		if (!isFirst && count == 0) {
			isFirst = true;
			$('.LanguageBar_languageIcon').removeClass('LanguageBar_transparent').addClass(selectedClass);
			$('#root > section > div.SelectedLanguage_selectedWrapper > ul > li:last-child').css("display", "none");
		}
	});
	// toogleLanguage bar 함수
	function toogleLanguageBar($languageBar, status) {
		// status가 active라면 선명하게 보이게 하기
		if (status === "active") {
			$languageBar.addClass(selectedClass).removeClass('LanguageBar_transparent');
		// status가 inactive 라면 흐리게 보이게 하기
		} else {
			$languageBar.removeClass(selectedClass).addClass('LanguageBar_transparent');
		}
	}
	
	// addLanguageFilter 함수
	// 필터를 누르면 하단에 <li> 추가하는 함수
	function addLanguageFilter(language) {
		filter.push(language);
		
		var newLi = $('<li>').attr('class',	'SelectedLanguage_selectedLanguage');
		var newDi = $('<div>').text(language);
		var newImg = $('<img>').attr('src',	'https://holaworld.io/images/info/delete.svg').attr('alt','deleteButton');

		$(newLi).append(newDi);
		$(newLi).append(newImg);
		$('.SelectedLanguage_selectedLanguages').prepend(newLi);

		// 추가된 <li> 태그에 클릭 이벤트 핸들러 추가
		// 누르면 삭제되게 함
		$(newLi).click(function() {
			$(this).remove();
			var language = $(this).text();
			let index = filter.indexOf(language);
			filter.splice(index, 1);
			
			mainfilter();
			
			$('li.LanguageBar_languageIcon').each(function() {
				
				let nthLanguage = $(this).text();
				
				if (nthLanguage === language) {
					count--;
					$(this).removeClass(selectedClass).addClass('LanguageBar_transparent');
					if (count == 0) {
						
						
						isFirst = true;
						$('.LanguageBar_languageIcon').removeClass('LanguageBar_transparent').addClass(selectedClass);
						$('#root > section > div.SelectedLanguage_selectedWrapper > ul > li:last-child').css("display", "none");
					}
				}
			});
		});
		
		mainfilter();
	}
	
	// 필터 아이콘 누르면 필터 삭제되게 하는 함수
	function removeLanguageFilter(language) {
		let index = filter.indexOf(language);
		filter.splice(index, 1);
		
		let $languageFilters = $('.SelectedLanguage_selectedLanguages > li');

		$languageFilters.each(function() {
			let nthLanguage = $(this).text();
			if (nthLanguage === language) {
				$(this).remove();
			}
		});
		mainfilter();
	}
	
	//list.jsp의 검색 버튼의 이벤트 처리
	var searchForm = $("#searchForm");
            		
	$("#searchForm button").on("click", function(e) {
		if(!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
	// 메인화면 필터 ajax 함수
	function mainfilter(){
		// data에 선택된 관심스택, 모집분야 값들을 담는다
			let data = {
				filter: filter,
				position : position,
				deadline : deadlineToggle
			};
			
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
		
	}
	
	 // 모집 분야 select 요소의 value가 변경될 때마다 이벤트 처리
	 $('#position').on('change', function() {
		// 선택된 option의 value값 가져오기   
		position = $('#position').val();
		mainfilter();
	 });
	 
		
	// jsh 0502 모집중 토글 이벤트
	// 토글 초기화(모집중만 보기 'on' 상태로 초기값 설정)
	$('#flexSwitchCheckChecked').css('background-color', '#ff914d');
	$('#flexSwitchCheckChecked').css('border-color', '#ff914d');
	
	$('#flexSwitchCheckChecked').on("click", function(e) {
		// deadlineToglle의 값은 1) 모집중 토글을 활성화하면 true, 2) 비활성화하면 false 
		deadlineToggle = !deadlineToggle;
		mainfilter();
		// 활성화 되어 있으면 배경색 변경
		if (deadlineToggle) {
			$(this).css('background-color', '#ff914d');
			$(this).css('border-color', '#ff914d');
		} else {
			$(this).css('background-color', '');
			$(this).css('border-color', '');
		}				
	});
</script>



</body>
</html>
