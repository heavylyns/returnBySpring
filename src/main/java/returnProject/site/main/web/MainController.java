package returnProject.site.main.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import returnProject.admin.service.AdminService;
import returnProject.popup.service.PopupVO;
import returnProject.site.board.service.BoardService;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.main.service.MainService;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/site")
public class MainController {
	
	/** mainService */
	@Resource(name = "mainService")
	private MainService mainService;
	/** boardService */
	@Resource(name = "boardService")
	private BoardService boardService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	@Resource(name = "AdminService")
	private AdminService adminService;
	/**
	 * 귀농귀촌 > main
	 */
	@RequestMapping(value = "/main.do")
	public String main(BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		
		HttpSession session = request.getSession();
		String visitorCounterYn= (String) session.getAttribute("visitorCounterYn");
		if(visitorCounterYn != null){
			if(visitorCounterYn.equals("Y")){
				adminService.visitorCounter();
				session.removeAttribute("visitorCounterYn");
			}
		}
		
		// 인포존 조회
		List<PopupVO> info = mainService.selectInfoList();
		
		// 강원 귀농귀촌 뉴스 조회
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());		
		paginationInfo.setRecordCountPerPage(8);								//메인에서는 8개만 조회한다.
		paginationInfo.setPageSize(boardVO.getPageSize());
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		boardVO.setBoardCode("06");												//귀농귀촌 뉴스 게시판 번호 설정
		List<BoardVO> news = mainService.selectNewsList(boardVO);
		
		// 나의 귀농귀촌 이야기 조회
		SiteBoardVO story = mainService.selectStory();
		String contents = story.getContents();													//게시글 내용 얻음
		contents = contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","");	//게시글 내용 html 태그제거
		story.setContents(contents);															//게시글 내용 재배치
		
		// 팝업 조회
		List<PopupVO> popup = mainService.selectPopupList();
		
		model.addAttribute("info", info);
		model.addAttribute("news", news);
		model.addAttribute("story", story);
		model.addAttribute("popup", popup);
		
		
		return "/site/main";
	}
	
	/**
	 * main > popup 출력
	 * @return
	 */
	@RequestMapping(value = "/popup.do")
	public String popup(PopupVO popupVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		popupVO = mainService.selectPopupView(popupVO);
		model.addAttribute("popupVO", popupVO);
		
		return "/site/popup";
	}
	
	
	
	/**
	 * 귀농귀촌 > 로그인
	 */
	@RequestMapping(value = "/member/login.do")
	public String login(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");		
		if (user == null)
			return "/site/member/login";
		else	//이미 로그인 되어있으므로 Main으로 Redirect
			return "redirect:/site/main.do";
	}
	
	/**
	 * 귀농귀촌 > 로그인 액션
	 */
	@RequestMapping(value = "/member/actionLogin.do")
	public String actionLogin(SiteMemberVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		// 1. 사용자 로그인 처리
		SiteMemberVO resultVO = mainService.actionLogin(loginVO);
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			// 로그인 정보를 세션에 저장
			resultVO.setLogin_type("user"); //사용자 로그인 성공 -> login_type을 user으로 설정한다.
			request.getSession().setAttribute("loginVO", resultVO);
			model.addAttribute("loginVO", resultVO);
			return "redirect:/site/main.do";
		
		//2.사용자 로그인 실패
		} else {
			resultVO = mainService.actionLogin2(loginVO);
			// 3.관리자 로그인 처리
			// 사용자 계정은 e-mail 형식이므로 관리자 계정과 중복될 수 없음
			if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
				// 로그인 정보를 세션에 저장
				resultVO.setLogin_type("admin");	//관리자 로그인 성공 -> login_type을 admin으로 설정한다.
				request.getSession().setAttribute("loginVO", resultVO);
				model.addAttribute("loginVO", resultVO);
				return "redirect:/site/main.do";
			}
			//사용자 로그인 실패 AND 관리자 로그인 실패 
			else{
				model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
				return "forward:/site/member/login.do";
			}
		}
	}
	
	/**
	 * 귀농귀촌 > 로그아웃 액션
	 */
	@RequestMapping(value = "/member/logout.do")
	public String actionLogout(HttpServletRequest request) throws Exception{
		request.getSession().setAttribute("loginVO", null);
		return "redirect:/site/main.do";
	}
	
	/**
	 * 귀농귀촌 > 회원가입 step-01
	 */
	@RequestMapping(value = "/member/join_01.do")
	public String join_01(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user != null)	//이미 로그인 중이라면	
			return "redirect:/site/main.do";
		else
			return "/site/member/join_01";
	}
	
	/**
	 * 귀농귀촌 > 회원가입 step-02
	 */
	@RequestMapping(value = "/member/join_02.do")
	public String join_02(HttpServletRequest request) throws Exception{
		return "/site/member/join_02";
	}
	
	/**
	 * 귀농귀촌 > 회원가입 step-03
	 */
	@RequestMapping(value = "/member/join_03.do")
	public String join_03(@ModelAttribute("searchVO")BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception{
		List<SiteBoardVO> list = boardService.regionCombo(boardVO);
		model.addAttribute("regionCombo", list);
		return "/site/member/join_03";
	}
	
	/**
	 * 귀농귀촌 > 회원가입 step-03 > 아이디 중복체크
	 */
	@RequestMapping(value = "/member/exist_chk.do")
	public void exist_chk(HttpServletRequest request, ModelMap model, HttpServletResponse response) throws Exception{
		JSONObject jsonObject = new JSONObject();
		String id = request.getParameter("id");
		int count = mainService.existChk_id(id);
		jsonObject.put("count", count);
		response.setContentType("text/json;charset=utf-8");
		PrintWriter pr = response.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	
	/**
	 * 귀농귀촌 > 회원가입 step-04
	 */
	@RequestMapping(value = "/member/join_04.do")
	public String join_04(@ModelAttribute("joinVO") SiteMemberVO siteMemberVO, HttpServletRequest request) throws Exception{
		mainService.insertMember(siteMemberVO);
		return "/site/member/join_04";
	}
	
	/**
	 * 귀농귀촌 > 아이디 찾기 step-01
	 */
	@RequestMapping(value = "/member/find_01.do")
	public String find_01(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user != null)	//이미 로그인 중이라면	
			return "redirect:/site/main.do";
		else
			return "/site/member/find_01";
	}
	
	/**
	 * 귀농귀촌 > 아이디 찾기 step-02
	 */
	@RequestMapping(value = "/member/find_02.do")
	public String find_02(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user != null)	//이미 로그인 중이라면	
			return "redirect:/site/main.do";
		else
			return "/site/member/find_02";
	}
	
	/**
	 * 귀농귀촌 > 비밀번호 초기화 step-01
	 */
	@RequestMapping(value = "/member/reset_01.do")
	public String reset_01(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user != null)	//이미 로그인 중이라면	
			return "redirect:/site/main.do";
		else
			return "/site/member/reset_01";
	}
	
	/**
	 * 귀농귀촌 > 비밀번호 초기화 step-02
	 */
	@RequestMapping(value = "/member/reset_02.do")
	public String reset_02(HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user != null)	//이미 로그인 중이라면	
			return "redirect:/site/main.do";
		else
			return "/site/member/reset_02";
	}
	
	/**
	 * 귀농귀촌 > 회원정보 수정
	 * - 회원정보 수정은 사용자 계정 로그인시에만 접근할 수 있다.
	 */
	@RequestMapping(value = "/member/updateMember.do")
	public String updateMember(HttpServletRequest request, ModelMap model) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		if (user == null){
			return "/site/member/login";
		}
		else{
			model.addAttribute("loginVO",user);
			return "/site/member/updateMember";
		}
	}
	
	/**
	 * 귀농귀촌  > 회원정보 수정 액션
	 */
	@RequestMapping(value = "/member/updateAction.do")
	public String updateAction(SiteMemberVO loginVO, HttpServletRequest request, ModelMap model) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "redirect:/site/member/login.do";
		}
		else{
			mainService.updateMember(loginVO);					//정보수정
			request.getSession().setAttribute("loginVO", null);	//로그아웃 처리
			return "redirect:/site/member/login.do";
		}
	}
	
	/**
	 * 귀농귀촌 > 회원탈퇴
	 */
	@RequestMapping(value = "/member/memBreak.do")
	public String memBreak(HttpServletRequest request, ModelMap model) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			model.addAttribute("loginVO",user);
			return "/site/member/memBreak";
		}
	}
	
	/**
	 * 귀농귀촌 > 회원탈퇴 액션
	 */
	@RequestMapping(value = "/member/deleteMember.do")
	public String deleteMember(HttpServletRequest request, ModelMap model) throws Exception{
		SiteMemberVO loginVO = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (loginVO == null){
			return "/site/member/login";
		}
		else{
			mainService.deleteMember(loginVO);						//회원탈퇴
			request.getSession().setAttribute("loginVO", null);		//로그아웃 처리
			return "redirect:/site/main.do";
		}
	}
	
	
}
