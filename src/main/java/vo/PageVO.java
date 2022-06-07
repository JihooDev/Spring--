package vo;

import java.util.List;


import lombok.Data;

//** DTO : Data Transfer Object
//** member , board 모두 사용 가능하도록 Generic 설정

@Data
public class PageVO<T> {
	private List<T> list; // 출력 목록
	private int totalRowCount; // 전체 Row 갯수
	private int rowsPerPage = 5; // 전체Row 갯수 (전체 Page수 계산을위해 필요)
	private int pageNocount = 3; // 1Page당 출력할 row갯수
	private int currPage; // 요청(출력할) 페이지
	private int sno; // Start row num
	private int eno; // End row num
}
