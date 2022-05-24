/**
 *  ** AjaxTest02
	=> 반복문에 이벤트 적용하기
	=> axmlist : Image(file)download, id별로 board 조회, 관리자 기능 (DELETE)
	=> axblist : 상세글 보기
 */
$(function(){
	$('#login_btn').click(function(){
		$.ajax({
			type: 'Get',
			url:'loginf',
			success: function(result){
				$("#resultArea").html(result);
			},
			errer: function(){
				$('#resultArea1').html('');
				alert('잠시 후 다시 시도해 주세요')
			},
		})
	})
	
	$('#axlogin').click(function(){
		$.ajax({
			type: 'Get',
			url:'login',
			data: {
				id : $('#id').val(),
				password :$('#password').val(),
			},
			success: function(result){
				$("#resultArea").html(result);
				location.reload();
			},
			errer: function(){
				$('#resultArea1').html('');
				alert('잠시 후 다시 시도해 주세요')
			},
		})
	})
});
