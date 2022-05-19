/**
 *  ** AjaxTest02
	=> 반복문에 이벤트 적용하기
	=> axmlist : Image(file)download, id별로 board 조회, 관리자 기능 (DELETE)
	=> axblist : 상세글 보기
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
				$('#resultArea1').html('');
			},
			error: function(){
				$('#resultArea2').html('');
				alert('오류 입니다')
			}
		})
	}

