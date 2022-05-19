package com.ncs.green;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.BoardService;
import vo.BoardVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	//BoardService service = new BoardServiceImpl();
	
	@RequestMapping(value = "/aidblist", method = RequestMethod.GET)
	public ModelAndView aidblist(ModelAndView mv, BoardVO vo) {
		mv.addObject("banana",service.aidBList(vo));
		mv.setViewName("axTest/axBoardList");
		return mv;
	}
	
	@RequestMapping(value = "/blist", method = RequestMethod.GET)
	public ModelAndView blist(ModelAndView mv) {
		mv.addObject("banana",service.selectList());
		mv.setViewName("board/boardList");
		return mv;
	}
	
	@RequestMapping(value = "/axblist", method = RequestMethod.GET)
	public ModelAndView axblist(ModelAndView mv) {
		mv.addObject("banana",service.selectList());
		mv.setViewName("axTest/axBoardList");
		return mv;
	}
	
	@RequestMapping(value = "/bdetail", method = RequestMethod.GET)
	public ModelAndView bdetail(ModelAndView mv, BoardVO vo,HttpServletRequest request, HttpServletResponse response,RedirectAttributes rttr) {
		
		Cookie viewCookie = null;
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for (Cookie c:cookies) {
				if(c.getName().equals("|"+vo.getSeq()+"|")) {
					viewCookie = c;
					break;
				}
			}
		}
		
		if(viewCookie == null) {
			if(service.countUpdate(vo) > 0) {
				Cookie newCookie = new Cookie("|" + vo.getSeq() + "|","view");
				newCookie.setMaxAge(20*60*60);
				response.addCookie(newCookie);
			} else {
				System.out.println("** 조회수 증가 정상적 처리 되지 않음 **");
				mv.addObject("message","~~조회수 증가가 정상적으로 처리되었습니다");
			}
		}
		
		vo = service.selectOne(vo);
		//=> Mybatis 적용시에는 중간객체를 거쳐 전달되기 때문에 vo에 결과를 담아야함.
		if(vo != null) {
			mv.addObject("apple",vo);
			mv.setViewName("board/boardDetail");
			System.out.println("*********************");
		} else {
			rttr.addFlashAttribute("message","내용이 없습니다");
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
	public ModelAndView binsert(ModelAndView mv,BoardVO vo, RedirectAttributes rttr) {
		if(service.insert(vo) > 0) {
			rttr.addFlashAttribute("message","~~ 새 글 등록 성공 ~~");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message","~~ 새 글 등록 실패!! 다시 시도하세요 ! ~~");
			mv.setViewName("board/insertForm");
		}
		return mv;
	}
	
	@RequestMapping(value = "/bupdatef", method = RequestMethod.GET)
	public ModelAndView bupdatef(ModelAndView mv,BoardVO vo, RedirectAttributes rttr) {
		vo = service.selectOne(vo);
		//=> Mybatis 적용시에는 중간객체를 거쳐 전달되기 때문에 vo에 결과를 담아야함.
		if(vo != null) {
			mv.addObject("apple",vo);
			mv.setViewName("board/updateForm");
		} else {
			rttr.addFlashAttribute("message","글 번호의 자료를 읽어오는데 실패했습니다");
			mv.setViewName("redirect:blist");
		}
		
		mv.setViewName("board/updateForm");
		return mv;
	}
	
	@RequestMapping(value = "/bupdate", method = RequestMethod.POST)
	public ModelAndView bupdate(ModelAndView mv,BoardVO vo, RedirectAttributes rttr) {
		if(service.update(vo) > 0) {
			rttr.addFlashAttribute("message", "글 수정 성공");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message", "글 수정 실패 다시 시도하세요");
			mv.setViewName("board/boardList");
		}
		return mv;
	}
	
	@RequestMapping(value = "/bdelete", method = RequestMethod.GET)
	public ModelAndView bdelete(ModelAndView mv,BoardVO vo, RedirectAttributes rttr) {
		if(service.delete(vo) > 0) {
			rttr.addFlashAttribute("message","~~ 글 삭제 성공 ~~");
			mv.setViewName("redirect:blist");
		} else {
			mv.addObject("message","~~ 글 삭제 실패!! 다시 시도하세요 ! ~~");
			mv.setViewName("redirect:bdetail?seq="+vo.getSeq());
		}
		return mv;
	}
}


