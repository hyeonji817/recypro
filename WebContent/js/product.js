/* header fixed */
	    // 스크롤 체크 변수 선언
	    var didScroll;
	    var lastScrollTop = 0;
	    var delta = 5; // 동작의 구현이 시작되는 위치
	    var navbarHeight = $("header").outerHeight(); // 영향을 받을 요소
	    // 스크롤시에 사용자가 스크롤했다는 것을 알림
	    $(window).scroll(function(event) {
	        didScroll = true;
	    });
	    // hasScrolled()를 실행하고 didScroll 상태를 재설정
	    setInterval(function() {
	        if (didScroll) {
	            hasScrolled();
	            didScroll = false;
	        }
	    }, 250);

	    function hasScrolled() {
	        var st = $(this).scrollTop();
	        if (Math.abs(lastScrollTop - st) <= delta)
	            return;
	
	        if (st > lastScrollTop && st > navbarHeight) {
	            // 스크롤 내릴때
	            $("header").removeClass("nav-down").addClass("nav-up");
	        } else {
	            // 스크롤 올릴때
	            if(st + $(window).height() < $(document).height()) {
	                $("header").removeClass("nav-up").addClass("nav-down");
	            }
	        }
	        lastScrollTop = st;
	    }
		$(function() {
		/* header - menu modalwindow*/
			$(document).on("click","#hd_menu_icon", function(e) {
	       	 	e.preventDefault();
	       	 	$("#hd_menu_background").fadeIn(300);
	        	$("#hd_menu_front").fadeIn(200);
	    	});
	    	// 배경을 클릭한 경우
			$(document).on("click","#hd_menu_background", function(e) {
	        	$(this).fadeOut(300);
	        	$("#hd_menu_front").fadeOut(200);
	    	});
	    	// x버튼 (self.close << 쓰는게 깔끔)
			$(document).on("click","#hd_menu_close", function(e) {
	        	e.preventDefault();
	        	$("#hd_menu_front").fadeOut(200);
	        	$("#hd_menu_background").fadeOut(100);
	    	});
	    
		/* --------------------search modalwindow-------------------*/
			$("#search_text").focus(function(e) {
	        	e.preventDefault();
	        	$("#hd_search_background").fadeIn(300);
	        	$("#hd_search_front").fadeIn(200);
	        	$("#modal_search_text").focus();
	    	});
	    	// 배경을 클릭한 경우
	   		$("#hd_search_background").click(function() {
	        	$(this).fadeOut(300);
	        	$("#hd_search_front").fadeOut(200);
	    	});
	    	// 왼쪽 x버튼 (self.close << 쓰는게 깔끔)
	    	$("#search_close_icon").click(function(e) {
	        	e.preventDefault();
	        	$("#hd_search_front").fadeOut(200);
	        	$("#hd_search_background").fadeOut(100);
	    	});
			/** 게시글의 제목을 클릭한 경우 호출되는 이벤트 정의 */
	    	$(document).on("click",".ft_collapse a", function(e) {
		        // 링크의 기본 동작(페이지 이동) 방지
		        e.preventDefault();
		        // 클릭한 요소의 href 속성을 가져온다 --> 내용영역의 id
		        var target = $(this).attr('href');
		        // 가져온 내용영역의 id를 화면에 표시한다.
		        $(target).slideToggle(100);
		        // 내용영역(.content)중에서
		        // 클릭한 요소가 지정한 항목만 제외(not($(target)))
		        // 하고 화면에서 숨긴다.
		        $(".ft_content").not($(target)).slideUp(100);
		    });
		});