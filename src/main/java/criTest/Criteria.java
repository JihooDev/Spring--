package criTest;

import lombok.Getter;
import lombok.ToString;

//** Criteria : (판단이나 결정을 위한) 기준
//=> 출력할 Row 를 select 하기 위한 클래스
//=> 이것을 위한 기준 값들을 관리

@Getter
@ToString
public class Criteria {
	private int rowsPerPage = 5; // 1Page 다 출력 할 row 갯수
	private int currPage; // 요청(출력할) Pageㅜㅜㅐ
	private int sno; // start Row 번호
	private int eno; // End Row 번호

	// 1) 필요한 초기값은 생성자로 설정
	public Criteria() {
		this.rowsPerPage = 5;
		this.currPage = 1;
	}

	// 2) setter

	// 2.1) setCurrPage : 요청받은 (출력할) PageNo를 set
	public void setCurrPage(int currPage) {
		if (currPage > 1) {
			this.currPage = currPage;
		} else {
			this.currPage = 1;
		}
	}

	// 2.2) setRowsPerPage
	// => 1페이지당 보여줄 Row(Record,튜플) 갯수 확인
	// => 제한조건 점검 ( 50개 까지만 허용)
	// => 당장은 사용하지 않지만 사용가능하도록 작성
	
	public void setRowsPerPage(int rowsPerPage) {
		if(rowsPerPage < 1 && rowsPerPage > 50) {
			this.rowsPerPage = 5;
		} else {
			this.rowsPerPage = rowsPerPage;
		}
	}
	
	// 2.3) setSnoEno
	// => sno 와 eno를 계산
	public void setSnoEno() {
		if(this.sno < 1) {
			this.sno = 1;
		} else {
			this.sno = (this.currPage-1)*this.rowsPerPage;
		}
		
		this.eno = this.sno + this.rowsPerPage -1;
	}
}
