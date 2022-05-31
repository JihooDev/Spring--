/**
 *  ** AjaxTest02
	=> 반복문에 이벤트 적용하기
	=> axmlist : Image(file)download, id별로 board 조회, 관리자 기능 (DELETE)
	=> axblist : 상세글 보기
 */

/*
 * * JQ 로 이벤트 핸들러 작성시 주의 사항 
=> jQuery 로 이벤트를 처리하기 위해 지금처럼 ready 이벤트를 사용하는 경우
   본구문이 포함된 axTest03.js 를 부모창에도 추가하고, 
   결과로 불리워지는 loginForm.jsp 에도 포함 하게되면
   마치 callBack 함수처럼 실행 할 때마다 이중으로 불리워지면서
   2의 자승으로 늘어나게 됨. 
=> 해결방법
  1) ~.js 를 각각 분리한다. 
  -> $('#jlogin').click( .....) 부분 axTest04.js 로 독립 
  2) JS의 함수 방식 으로 이벤트 처리
  
** ** 이벤트 전달
=> Tag 들이 겹겹이 포함관계에 있을때 이벤트가 전달되어 여러번 발생가능함. 
=> 이것을 이벤트 Propagation(전파) 이라함.
=> 해결 : return false
        -> e.preventDefault() + e.stopPropagation()

** ** JS & JQ 에서 익명함수의 매개변수역할 
=> 이벤트 핸들러 의 첫 매개변수 : 이벤트 객체를 전달 
=> ajax 메서드의 success 속성 : 서버의 response 결과 
=> css 속성값 : 0부터 순차적으로 대입됨 (jq03_attr.html 참고)

 */

$(function(){
	$('#axmlist').click(function(){
		$.ajax({
			type: 'Get',
			url:'axmlist',
			success: function(result){
				$('#resultArea1').html(result);
			},
			errer: function(){
				$('#resultArea1').html('');
				alert('잠시 후 다시 시도해 주세요')
			},
		})
	})
	
	$('#axblist').click(function(){
		$.ajax({
			type: 'Get',
			url:'axblist',
			success: function(result){
				$('#resultArea1').html(result);
			},
			errer: function(){
				$('#resultArea1').html('');
				alert('잠시후 다시 시도해 주세요')
			},
		})
	})
	
	// ** 반복문에 이벤트 적용하기2 - JQuery
	// => id별로 board조회
	
	$('.ccc').click(function(){
		//1) 요청 id 인식
		var id = $(this).html();
		console.log(id)
		
		$.ajax({
			type: 'Get',
			url: 'aidblist',
			data: {
				id : id
			},
			success: function(result){
				$('#resultArea2').html(result);
			},
			error: function(){
				$('#resultArea2').html('');
				alert('오류 입니다')
			}
		})
		return false;
	});
	
	// 삭제 후 표시
/*	$('.ddd').click(function(){
		var id = $(this).attr('id');
		
		// responce는 jsonView 로 처리
		$.ajax({
			type: 'Get',
			url: 'axmdelete',
			data : {
				id:id
			},
			success: function(resultData){
				if(resultData.code === '200') {
					alert('삭제가 정상적으로 처리 되었습니다');
					$('#'+id).html('Delete').css({
						color:"red",
						fontWeight : 'bold',
					}).off();
					
				} else if (resultData.code === '201') {
					alert('서버오류');
				} else {
					alert('관리자 로그인 정보 없음');
				}
			},
			error: function(){
				alert('오류입니다');
			}
		})
	})*/
});
// ** 반복문에 이벤트 적용하기
// => id별로 board조회
// test 1) JS function


	
	function aidBList(id){
		$.ajax({
			type: 'Get',
			url: 'aidblist',
			data: {
				id: id
			},
			success: function(result){
				$('#resultArea2').html(result);
			},
			error: function(){
				$('#resultArea2').html('');
				alert('오류 입니다')
			}
		})
	}
	
	function amDelete(id) {
		$.ajax({
			type: 'Get',
			url: 'axmdelete',
			data : {
				id:id
			},
			success: function(resultData){
				if(resultData.code == '200') {
					alert('삭제가 정상적으로 처리 되었습니다');
					$('#'+id).html('Delete').css({
						color:"red",
						fontWeight : 'bold',
					}).attr('onclick', null)
					
				} else if (resultData.code == '201') {
					alert('서버오류');
				} else {
					alert('관리자 로그인 정보 없음');
				}
			},
			error: function(){
				alert('오류입니다');
			}
		})
	}
