
$(function(){
	$('.sss1').hover(function(e){
		// seq 확인 , ajax 처리 div에 출력(마우스 위치)
		// => 마우스 위치는 이벤트 객체가 알려줌
		// ** seq확인, ajax content 읽어오기, div에 출력(마우스 위치필요)
        // => 마우스 위치필요 : event객체 (이벤트핸들러 첫번째 매개변수) 가 제공 
        // 1) 마우스포인터 위치인식
        // => e.pageX, e.pageY : 전체 Page 기준
        // => e.clientX, e.clientY : 보여지는 화면 기준-> page Scroll 시에 불편함

		var mleft = e.pageX;
		var mtop = e.pageY;
		
		// 2) seq 확인
		var seq = $(this).attr('id');
		
		$.ajax({
			type : 'Get',
			url : 'jsbdetail?seq='+seq,
			success : function(resultData){
				$('.content').html('')
				$('#contentBox').html(resultData.content).css({
					display : 'block',
					left : mleft,
					top : mtop,
				})
			},
			error : function(){
				alert('서버 오류 입니다');
			}
		})
	},function(){
		$('.content').html('');
		$('#contentBox').css({
			display : "none",
		})
	}) // hover
	
	$('.sss2').hover(function(e){
		var mleft = e.pageX;
		var mtop = e.pageY;
		
		console.log(e.pageX,e.pageY)
		
		var seq = $(this).html();
		
		$.ajax({
			type : 'Get',
			url : 'jsbdetail?seq='+seq,
			success : function(resultData){
				$('.content').html('')
				$('#contentBox').html(resultData.content).show().css({
					left : mleft,
					top : mtop
				});
			},
			error : function(){
				alert('서버 오류 입니다');
			}
		})
		return false;
	},function(){
		$('#contentBox').hide();
		return false;
	})
})

function jsBDetail1(seq) {
	$.ajax({
		type : 'Get',
		url : 'jsbdetail?seq='+seq,
		success : function(resultData){
			$('#resultArea2').html(resultData.content);
		},
		error : function(){
			alert('서버 오류 입니다');
		}
	})
}

// => toggle 방식
// => event객체 전달 test
function jsBDetail2(e,seq,count) {
	
	
	if($('#'+count).html() == ''){
		// 글이 없을 때만 Ajax 로 가져오기
		$.ajax({
			type : 'Get',
			url : 'jsbdetail?seq='+seq,
			success : function(resultData){
				$('.content').html('');
				$('#'+count).html(resultData.content);
			},
			error : function(){
				alert('서버 오류 입니다');
			}
		})
	} else {
		$('#'+count).html('');
	}
}