

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
function jsBDetail2(seq,count) {
	
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