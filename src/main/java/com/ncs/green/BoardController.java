package com.ncs.green;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.BoardService;
import vo.BoardVO;
import vo.PageVO;

@Controller
public class BoardController {

	@Autowired
	BoardService service;
	// BoardService service = new BoardServiceImpl();

	// ** PageList 2.
	// => ver01 Criteria
	// => ver02 Search Criteria

	@RequestMapping(value = "/bjoinlist", method = RequestMethod.GET)
	public ModelAndView bjoinlist(ModelAndView mv, BoardVO vo) {

		// ** Join_CheckList
		// => Board 에서 Level 별로 작성한 글목록 출력하기
		// => SQL : join 필요
		// => BoardVO 가 MemberVO 를 상속받으면 편리
		// => jsp : input Tag checkBox 로 lev 를 전달

		// 1) request 처리 => Check_Box 처리
		// => vo 의 check 값에 Parameter 로 전달된 lev 값들이 담겨있음
		
		List<BoardVO> list = service.joinList(vo);
		
		if (list != null && list.size() > 0) {
			mv.addObject("banana", list);
		} else {
			mv.addObject("banana", null);
		}

		mv.setViewName("board/bJoinCheckList");
		return mv;
	}

	@RequestMapping(value = "/bchecklist", method = RequestMethod.GET)
	public ModelAndView bchecklist(ModelAndView mv, BoardVO vo) {
		List<BoardVO> list = null;

		if (vo.getCheck() != null) {
			list = service.checkList(vo);
		} else {
			list = service.selectList();
		}

		if (list != null && list.size() > 0) {
			mv.addObject("banana", list);
		} else {
			mv.addObject("banana", null);
		}

		mv.setViewName("board/bCheckList");
		return mv;
	}

	@RequestMapping(value = "/bcrilist", method = RequestMethod.GET)
	public ModelAndView bcrilist(ModelAndView mv, PageMaker pageMaker, SearchCriteria cri) {

		// 1) Criteria 처리
		// => setCurrPage, setRowsPerPage 는 Parameter 로 전달되어,
		// setCurrPage(..) , setRowsPerPage(..) 는 자동처리됨(스프링에 의해)
		// -> cri.setCurrPage(Integer.parseInt(request.getParameter("currPage")))
		// => 그러므로 currPage 이용해서 sno, eno 계산만 하면됨
		cri.setSnoEno();

		// 2) Service 처리하기
		// => List 읽어오기
		mv.addObject("banana", service.criList(cri));

		// 3) PageMaker 처리
		// => pageMaker : setCri, setTotalRowCount
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.totalCriCount(cri));
		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("board/bCriList");
		return mv;
	}

	@RequestMapping(value = "/bpagelist", method = RequestMethod.GET)
	public ModelAndView bpagelist(ModelAndView mv, PageVO<BoardVO> pvo) {
		// 1) Paging 준비
		// => 한 Page당 출력할 Row 갯수 : PageVO 에 지정
		// => 요청 Page 확인 : currPage ( Parameter )
		// => sno , eno 계산후 List 읽어오기
		// => totalRowCount : 전체Page수 계산
		int currPage = 1;
		if (pvo.getCurrPage() > 1) {
			currPage = pvo.getCurrPage();
		} else {
			pvo.setCurrPage(currPage);
		}

		int sno = (currPage - 1) * pvo.getRowsPerPage();
		int eno = sno + pvo.getRowsPerPage() - 1;
		pvo.setSno(sno);
		pvo.setEno(eno);

		// 2) Service 처리
		// => List 읽어오기, 전체Row수(totalRowCount)
		// => 전체 PageNo 계산하기

		pvo = service.pageList(pvo);
		int totalPageNo = pvo.getTotalRowCount() / pvo.getRowsPerPage();

		if (pvo.getTotalRowCount() % pvo.getRowsPerPage() != 0) {
			totalPageNo += 1;
		}

		// 3 view 처리
		// ** View 01
		mv.addObject("currPage", currPage);
		mv.addObject("totalPageNo", totalPageNo);
		mv.addObject("banana", pvo.getList());

		// ** View 02 (Page block 기능)
		// => PageBlock 기능 추가 : sPageNo, ePageNo
		// => 이를 위해 currPage, pageNoCount
		// => 유형 1) currPage 가 항상 중앙에 위치하도록 할때 (ex. 쿠팡)
		// int sPageNo = currPage - (pageNoCount/2) ;
		// int ePageNo = currPage + (pageNoCount/2) ;

		// => 유형 2) 11번가의 상품List, Naver 카페글 유형
		// 예를들어 currPage=3 이고 pageNoCount 가 3 이면 1,2,3 page까지 출력 되어야 하므로
		// 아래 처럼 currPage-1 을 pageNoCount 으로 나눈후 다시 곱하고 +1
		// currPage=11 -> 10,11,12, => (11-1)/3 * 3 +1 = 10
		// 연습 ( pageNoCount=5 )
		// -> currPage=11 인경우 : 11,12,13,14,15 -> ((11-1)/5)*5 +1 : 11
		// -> currPage=7 인경우 : 6,7,8,9,10 -> ((7-1)/5)*5 +1 : 6

		int sPageNo = ((currPage - 1) / pvo.getPageNocount()) * pvo.getPageNocount() + 1;
		// 결과 값이 실수가 떨어져도 정수로 가져옴

		int ePageNo = sPageNo + pvo.getPageNocount() - 1;
		// 계산으로 얻어진 ePageNo가 실제 LastPage 인 totalPageNo 보다 크면 수정 필요.

		if (ePageNo > totalPageNo) {
			// ** 끝나는 페이지보다 총 페이지가 더 크면?
			// => 끝나는 페이지에 총 페이지를 넣어줌
			ePageNo = totalPageNo;
		}

		mv.addObject("sPageNo", sPageNo);
		mv.addObject("ePageNo", ePageNo);
		mv.addObject("pageNocount", pvo.getPageNocount());

		mv.setViewName("board/bPageList");
		return mv;
	} // rinsert

	// ** 답글 달기
	@RequestMapping(value = "/rinsertf", method = RequestMethod.GET)
	public ModelAndView rinsertf(ModelAndView mv, BoardVO vo) {
		// => vo 에는 전달된 부모글의 root, step, indent 가 담겨있음
		// => 매핑메서드의 인자로 정의된 vo 는 request.setAttribute 와 동일 scope
		// 단, 클래스명의 첫글자를 소문자로 ... ${boardVO.root}

		mv.setViewName("board/rinsertForm");

		return mv;
	} // rinsert

	@RequestMapping(value = "/rinsert", method = RequestMethod.POST)
	public ModelAndView rinsert(ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {

		// => parameter 로 전달되는값 : id, title, content
		// => 추가적으로 필요한값 : root, step, indent
		// root: 부모글의 root 와 동일
		// step: 부모글의 step + 1
		// (기존 답글의 step 값이 현재 계산된 이값보다 같거나 큰값들은 +1씩 모두증가 : sql 에서 처리)
		// indent : 부모글의 indent + 1
		vo.setStep(vo.getStep() + 1); // vo의 step을 1증가
		vo.setIndent(vo.getIndent() + 1);

		if (service.rinsert(vo) > 0) {
			rttr.addFlashAttribute("message", "~~ 답글 등록 성공 ~~");
			mv.setViewName("redirect:blist");
		} else {
			// 실패: 재입력 유도
			// => root,step,indent의 값을 본래 부모의 값으로 변경 후 사용
			vo.setStep(vo.getStep() - 1);
			vo.setIndent(vo.getIndent() - 1);
			mv.addObject("message", "~~ 답글 등록 실패!! 다시 시도하세요 ! ~~");
			mv.setViewName("board/rinsertForm");
		}
		return mv;
	}

	// Json view
	@RequestMapping(value = "/jsbdetail", method = RequestMethod.GET)
	public ModelAndView jsbdetail(ModelAndView mv, BoardVO vo, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		vo = service.selectOne(vo);
		mv.addObject("content", vo.getContent());
		mv.setViewName("jsonView");
		return mv;
	}

	@RequestMapping(value = "/aidblist", method = RequestMethod.GET)
	public ModelAndView aidblist(ModelAndView mv, BoardVO vo) {
		mv.addObject("banana", service.aidBList(vo));
		mv.setViewName("axTest/axBoardList");
		return mv;
	}

	@RequestMapping(value = "/blist", method = RequestMethod.GET)
	public ModelAndView blist(ModelAndView mv) {
		mv.addObject("banana", service.selectList());
		mv.setViewName("board/boardList");
		return mv;
	}

	@RequestMapping(value = "/axblist", method = RequestMethod.GET)
	public ModelAndView axblist(ModelAndView mv) {
		mv.addObject("banana", service.selectList());
		mv.setViewName("axTest/axBoardList");
		return mv;
	}

	@RequestMapping(value = "/bdetail", method = RequestMethod.GET)
	public ModelAndView bdetail(ModelAndView mv, BoardVO vo, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes rttr) {

		Cookie viewCookie = null;
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("|" + vo.getSeq() + "|")) {
					viewCookie = c;
					break;
				}
			}
		}

		if (viewCookie == null) {
			if (service.countUpdate(vo) > 0) {
				Cookie newCookie = new Cookie("|" + vo.getSeq() + "|", "view");
				newCookie.setMaxAge(20 * 60 * 60);
				response.addCookie(newCookie);
			} else {
				System.out.println("** 조회수 증가 정상적 처리 되지 않음 **");
				mv.addObject("message", "~~조회수 증가가 정상적으로 처리되었습니다");
			}
		}

		vo = service.selectOne(vo);
		// => Mybatis 적용시에는 중간객체를 거쳐 전달되기 때문에 vo에 결과를 담아야함.
		if (vo != null) {
			mv.addObject("apple", vo);
			mv.setViewName("board/boardDetail");
			System.out.println("*********************");
		} else {
			rttr.addFlashAttribute("message", "내용이 없습니다");
			mv.setViewName("redirect:blist");
		}

		return mv;
	}

	@RequestMapping(value = "/binsertf", method = RequestMethod.GET)
	public ModelAndView binsertf(ModelAndView mv) {
		mv.setViewName("board/insertForm");
		return mv;
	}

	@RequestMapping(value = "/binsert", method = RequestMethod.POST)
	public ModelAndView binsert(ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {
		if (service.insert(vo) > 0) {
			rttr.addFlashAttribute("message", "~~ 새 글 등록 성공 ~~");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message", "~~ 새 글 등록 실패!! 다시 시도하세요 ! ~~");
			mv.setViewName("board/insertForm");
		}
		return mv;
	}

	@RequestMapping(value = "/bupdatef", method = RequestMethod.GET)
	public ModelAndView bupdatef(ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {
		vo = service.selectOne(vo);
		// => Mybatis 적용시에는 중간객체를 거쳐 전달되기 때문에 vo에 결과를 담아야함.
		if (vo != null) {
			mv.addObject("apple", vo);
			mv.setViewName("board/updateForm");
		} else {
			rttr.addFlashAttribute("message", "글 번호의 자료를 읽어오는데 실패했습니다");
			mv.setViewName("redirect:blist");
		}

		mv.setViewName("board/updateForm");
		return mv;
	}

	@RequestMapping(value = "/bupdate", method = RequestMethod.POST)
	public ModelAndView bupdate(ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {
		if (service.update(vo) > 0) {
			rttr.addFlashAttribute("message", "글 수정 성공");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message", "글 수정 실패 다시 시도하세요");
			mv.setViewName("board/boardList");
		}
		return mv;
	}

	@RequestMapping(value = "/bdelete", method = RequestMethod.GET)
	public ModelAndView bdelete(ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {
		if (service.delete(vo) > 0) {
			rttr.addFlashAttribute("message", "~~ 글 삭제 성공 ~~");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message", "~~ 글 삭제 실패!! 다시 시도하세요 ! ~~");
			mv.setViewName("redirect:bdetail?seq=" + vo.getSeq());
		}
		return mv;
	}
}
