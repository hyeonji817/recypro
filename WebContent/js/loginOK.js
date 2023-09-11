let banner = {
    		rollId: null,
    		interval: 2000,
    		
    		// 롤링 배너 초기화
    		rollInit: function (newinterval) {
    			if (parseInt(newinterval) > 0) {
    				this.interval = newinterval;
    			}
    			
    			// 현재 배너
    			let firstitem = document.querySelector('.rolling_imgs li');
    			if (firstitem) {
    				firstitem.classList.add('currentroll');
    			}
    			// 다음 배너 
    			let seconditem = document.querySelectorAll('.rolling_imgs li')[1];
    			if (seconditem) {
    				seconditem.classList.add('nextroll');
    			}
    			// 이전 배너 
    			document.querySelector('.rolling_imgs li:last-child').classList.add('prevroll');
    			this.rollId = setInterval(this.rollNext, this.interval);	// 롤링 인터벌 호출 
    		},
    		
    		// 다음 배너 롤링 
    		rollNext: function () {
        		if(document.querySelector('.prevroll')){
            	document.querySelector('.prevroll').classList.remove('prevroll');
        	}
        	if(document.querySelector('.currentroll')){
            	document.querySelector('.currentroll').classList.add('prevroll');
            	document.querySelector('.currentroll').classList.remove('currentroll');
        	}
        	if(document.querySelector('.nextroll')){
            	document.querySelector('.nextroll').classList.add('currentroll');
            	document.querySelector('.nextroll').classList.remove('nextroll');
        	}
    		//다음 이미지 있으면 다음 롤링 이미지로 선택, 없으면 첫번째 이미지를 롤링 이미지로 지정
        	if(document.querySelector('.currentroll').nextElementSibling){
            	document.querySelector('.currentroll').nextElementSibling.classList.add('nextroll');
        	}else{
            	document.querySelector('.rolling_imgs li').classList.add('nextroll');
        	}
    	}
    }
    document.addEventListener('DOMContentLoaded', function(){
	    banner.rollInit(4000); // 배너 롤링
	});
    
    /** 반응형 처리 */
    var resizeId = "";
    
    window.addEventListener('resize', function() {
    	clearTimeout(resizeId);
    	resizeId = setTimeout(doneResizing, 250);
    });
    
    function doneResizing() {
    	console.log('doneResizing Window Width: ' + window.innerWidth);
    	// 반응형 레이아웃 처리
    }