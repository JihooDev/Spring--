package com.ncs.green;



import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MemberService;
import service.MemberServiceImpl;
import vo.MemberVO;


// ** Bean 생성하는 문 @
// Java : @Component
// Spring : 세분화
// @Controller ,@Service, @Repository


@Controller
public class MemberController {
	@Autowired // 자동주입 (injection)
	
	MemberService service;
	// => 조건 : 주입받으려는 구현 클래스가 반드시 생성되어있어야함.
	//MemberService service = new MemberServiceImpl();
	
	// ajax 관리자 계정 (다른 계정을 마음대로 삭제 시킬수 있음)
	@RequestMapping(value="/axmdelete")
	public ModelAndView axmdelete(HttpServletRequest request,ModelAndView mv,MemberVO vo) {
		HttpSession session = request.getSession(false);
		if(session != null && ((String)session.getAttribute("LoginID")).equals("admin")) {
			// 삭제 가능
			// 2. Service
			if(service.delete(vo) > 0) {
				// 삭제 성공
				mv.addObject("code","200"); // 성공
			} else {
				// 삭제 실패 (DB오류)
				mv.addObject("code","201"); // 서버 오류
			}
		} else {
			// 삭제 불가
			mv.addObject("code","202"); // LoginID 가 없음
		}
		
		// 각 언어마다 인코딩 방식이 다르다.
		
		// 2. 결과 : view 처리 => Java객체 -> Json 
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "axmlist", method = RequestMethod.GET)
	public ModelAndView axmlist(ModelAndView mv) {
		mv.addObject("banana",service.selectList());
		mv.setViewName("axTest/axMemberList");
		return mv;
	}

	
	@RequestMapping(value = "idDupCheck", method = RequestMethod.GET)
	public ModelAndView idDupCheck(ModelAndView mv, MemberVO vo) {

		mv.addObject("newId",vo.getId());
		vo = service.selectOne(vo);
		
		if(vo!=null) {
			// 사용 불가능 id 존재
			mv.addObject("idUse", "F");
		} else {
			// 사용 가능 id 존재하지 않음
			mv.addObject("idUse","T");
		}
		
		mv.setViewName("member/idDupCheck");		
		return mv;
	}
	
	@RequestMapping(value = "/loginf", method = RequestMethod.GET)
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("member/loginForm");		
		return mv;
	}
	
	// ** Login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request,ModelAndView mv, MemberVO vo,RedirectAttributes rttr) {
		String password = vo.getPassword();
		
		vo = service.selectOne(vo);
		request.setAttribute("notLogin", "로그인 후 이용하세요~");
		if(vo != null) {
			if(vo.getPassword().equals(password)) {
				HttpSession session = request.getSession(true);
				session.setAttribute("LoginID", vo.getId());
				rttr.addFlashAttribute("message", vo.getName() + vo.getId() + "님 환영합니다~");
				mv.setViewName("redirect:home");
			} else {
				mv.addObject("message", "비밀번호가 잘못되었습니다. 다시 시도하세요.");
				mv.setViewName("member/loginForm");
			}
		} else {
			mv.addObject("message", "아이디가 잘못되었습니다. 다시 시도하세요");
			mv.setViewName("member/loginForm");
		}
		
		System.out.println("--------- Login ----------");
		return mv;
		}	
	
	//  **Logout
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request,ModelAndView mv,RedirectAttributes rttr) {
		request.getSession().invalidate();
		
		rttr.addFlashAttribute("message1", "로그아웃 되었습니다. 좋은 하루 되세요~");
		mv.setViewName("redirect:home");
		return mv;
	}//logout


	@RequestMapping(value = "/joinf", method = RequestMethod.GET)
	public ModelAndView joinf(ModelAndView mv) {
		mv.setViewName("member/joinForm");
		return mv;
	} //joinf
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView join(HttpServletRequest request ,ModelAndView mv,MemberVO vo) throws IOException {
		System.out.println(vo);
	      // 1. 요청분석
	      // 1.1) Upload Image 처리
	      // => image file 저장위치 결정 -> 저장 -> 저장위치를 vo 에 set
	      // => 이 작업을 도와주는 객체 : MultipartFile
	      
	      // ** Image 물리적위치 에 저장
	      // 1) 현재 웹어플리케이션의 실행 위치 확인 : 
	      // => eslipse 개발환경 (배포전)
	      //    D:\MTest\MyWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Spring01\
	      // => 톰캣서버에 배포 후 : 서버내에서의 위치가 됨
	      //    D:\MTest\IDESet\apache-tomcat-9.0.41\webapps\Spring01\
			// D:\MTest\newMyWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Spring01\
	      String realPath = request.getRealPath("/"); // deprecated Method
	      System.out.println("** realPath => "+realPath);
	      
	      if(realPath.contains(".eclipse.")) {
	    	  realPath = "D:\\MTest\\newMyWork\\Spring01\\src\\main\\webapp\\resources\\uploadImage\\";
	      } else {
	    	  realPath += "resources\\uploadImage\\";
	      }
	      
	      // ** 폴더 만들기 (File 클래스활용)
	      // => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
	      // => 매개변수에는 url 을 적어준다
	      File f1 = new File(realPath);
	      
	      if(!f1.exists()) {
	    	  // exists() => realPath 디렉터리가 존재하는지 검사 
	    	  // 존재하지 않으면 디렉토리 생성
	    	  f1.mkdir();
	      }
	      
	      // 기본 Image를 하나 만들어 놓기
	      String file1, file2 = "resources\\uploadImage\\basic.png";
	      
	      // ** MultipartFile
	      // => MultipartFile 타입의 uploadfilef 의 정보에서 
	      //    upload된 image 화일과 화일명을 get 처리,
	      // => upload된 image 화일은 서버의 정해진 폴더 (물리적위치)에 저장 하고, -> file1
	      // => 이 위치에 대한 정보를 table에 저장 (vo의 UploadFile 에 set) -> file2
	      // ** image 화일명 중복시 : 나중 이미지로 update 됨. 
	      
	      MultipartFile uploadfilef = vo.getUploadfilef();
	      
	      if(!uploadfilef.isEmpty() && uploadfilef != null) {
	    	  // image를 선택했음 -> image를 저장해줘야 함
//	    	  1) 물리적 저장 경로에 image 저장
	    	  file1 = realPath + uploadfilef.getOriginalFilename(); // 경로 완성
	    	  uploadfilef.transferTo(new File(file1));
	    	  //2) Table 저장 준비
	    	  
	    	  file2 = "resources\\uploadImage\\" + uploadfilef.getOriginalFilename();
	      }
	      
	      vo.setUploadfile(file2);
	      
	      
		// 2. Service
		if ( service.insert(vo) > 0) {
			// 입력 성공 -> loginForm 으로
			mv.addObject("message", "----- 회원가입 완료 -----");
			mv.setViewName("member/loginForm");
		} else {
			// 입력 실패 -> 재시도 유도( joinForm 으로)
			mv.addObject("message", "----- (ERROR)다시 시도 하세요-----");
			mv.setViewName("member/joinForm");
		}
		return mv;
	} //joinf
	
	@RequestMapping(value = "/mlist")
	public ModelAndView mlist(ModelAndView mv,MemberVO vo) {
		mv.addObject("banana",service.selectList());
		mv.setViewName("member/memberList");
		return mv;
	}
	
	@RequestMapping(value="mdetail")
	public ModelAndView mdetail(HttpServletRequest request,ModelAndView mv, MemberVO vo) {
		// 1. 요청분석
				// => 로그인 한 User의 개인정보를 출력
				// => session정보에서 id를 확인
				// 1)  session 생성
				HttpSession session = request.getSession(false); 
				// (), (true) -> 없으면 생성해서 return
				// (false) 는 없으면 null return (사용 전에 null이 아님을 확인해야 한다.)
				String url = "";
				if(session != null && session.getAttribute("LoginID") != null) {
					//Service 처리
					
					vo.setId((String)session.getAttribute("LoginID"));
					vo = service.selectOne(vo);
					
					if(vo != null) {
						// view 처리 (vo를 view가 출력할수있게 담고 view 지정)
						request.setAttribute("apple", vo);
						if(request.getParameter("jcode")!=null && request.getParameter("jcode").equals("U")) {
							mv.setViewName("member/updateForm");
				        }else {
				        		mv.setViewName("member/memberDetail");
				        }
					} else {
						// => user 정보가 있는데 실패 ->  로그인 유도 (loginForm.jsp)
						mv.addObject("message", "---- 개인정보 읽어오기 실패 (vo null) ----");
						mv.setViewName("member/loginForm");
					} // vo
				} else {
					// 로그인 정보가 없음(무효화) 을 알려줌 -> 로그인 유도 (loginForm.jsp)
					request.setAttribute("message", "---- 로그인 정보가 없습니다 다시 시도 하세요 (session null)  ----");
					mv.setViewName("member/loginForm");
				}
		return mv;
	} // detail
	
	@RequestMapping(value = "/mupdate", method = RequestMethod.POST)
	public ModelAndView mupdate(HttpServletRequest request,ModelAndView mv,MemberVO vo,RedirectAttributes rttr) throws IOException {
		// 1. 요청분석
		// 1.1) Upload Image 처리
		
		String realPath = request.getRealPath("/"); // deprecated Method
		
		
		if (realPath.contains(".eclipse.")) {
					// eclipse 개발환경:
			realPath = "D:\\MTest\\newMyWork\\Spring01\\src\\main\\webapp\\resources\\uploadImage\\";
		} else {
					// 톰캣서버에 배포 후 : 서버내에서의 위치
			realPath += "resources\\uploadImage\\";
		}
				
		// ** 폴더 만들기 (File 클래스 활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우) 만들어 준다
		File f1 = new File(realPath);
		if (!f1.exists()) {
			f1.mkdir();
		}
					
				// ** 기본 이미지 지정하기
		String file1, file2;
				
		MultipartFile uploadfilef = vo.getUploadfilef();
		if (!uploadfilef.isEmpty() && uploadfilef != null) {
			// ** new_Image 를 선택한 경우
			// 1) 물리적 저장경로에 Image 저장
			file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
			uploadfilef.transferTo(new File(file1)); // Image 저장
			// 2) Table 저장 준비
			file2="resources\\uploadImage\\"+uploadfilef.getOriginalFilename();
			vo.setUploadfile(file2);
		}
		
		mv.addObject("apple",vo);
		if ( service.update(vo) > 0) {
			// 입력 성공 -> memberDetail 로
			request.getSession().setAttribute("LoginName", vo.getName());
			mv.addObject("message", "----- 정보 수정완료 -----");
			mv.setViewName("member/memberDetail");
		} else {
			// 입력 실패  update
			mv.addObject("message", "----- (ERROR)다시 시도 하세요-----");	
			mv.setViewName("member/updateForm");
		}
		// 2. Service
		// ** new_Image 를 선택하지 않은 경우 : form 에서 전송된 vo에 담겨진 uploadfile 값을 사용하면 됨
		
		
		return mv;
	} //joinf
	
	@RequestMapping(value="/mdelete")
	public ModelAndView mdelete(HttpServletRequest request,ModelAndView mv,MemberVO vo,RedirectAttributes rttr) {
		HttpSession session = request.getSession(false);
		if(session != null && session.getAttribute("LoginID") != null) {
			// 삭제 가능
			// 2. Service
			vo.setId((String)session.getAttribute("LoginID"));
			if(service.delete(vo) > 0) {
				// 삭제 성공
				session.invalidate();
				rttr.addFlashAttribute("message","------ 회원 탈퇴 성공입니다 : 10일 후 재 가입 가능합니다 -----");
				System.out.println("************************삭제 성공");
			} else {
				// 삭제 실패 (DB오류)
				rttr.addFlashAttribute("message","------ 회원 탈퇴를 처리 할 수 없습니다 : 서버오류-----");
				System.out.println("*********************** 삭제 실패 (DB문제)");
			}
		} else {
			// 삭제 불가
			rttr.addFlashAttribute("message","------ 회원 탈퇴를 처리 할 수 없습니다 : 로그인 정보 없음-----");
			System.out.println("*********************삭제 실패");
		}
		
		mv.setViewName("redirect:home");
		return mv;
	}
	
	
	
}
