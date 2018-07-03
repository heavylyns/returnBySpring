package returnProject.site.comunity.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import returnProject.popup.service.PopupVO;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.comunity.service.ComunityService;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cop.bbs.service.BoardVO;

@Controller
@RequestMapping("/site/comunity")
public class ComunityController {
	
	/** comunityService */
	@Resource(name = "comunityService")
	private ComunityService comunityService;
	
	/**
	 * 커뮤니티 > 귀농귀촌 뉴스list
	 */
	@RequestMapping(value = "/news.do")
	public String news(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","06");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 커뮤니티 > 귀농귀촌 뉴스view
	 */
	@RequestMapping(value = "/news_view.do")
	public String news_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","06");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 지원정책 > 귀농귀촌 뉴스 등록&수정
	 */
	@RequestMapping(value = "/news_action.do")
	public String news_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			if(request.getParameter("type").equals("update"))
				return "forward:/site/board/boardUpdatePage.do";
			else
				return "forward:/site/board/boardInsertPage.do";
		}
	}
	
	/**
	 * 지원정책 > 웹진관리
	 */
	@RequestMapping(value = "/webzine.do")
	public String webzine(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		List<PopupVO> resultList = comunityService.webzine();
		
		model.addAttribute("resultList", resultList);
		return "/site/comunity/webzine";
	}
	
	/**
	 * 커뮤니티 > 갤러리 list
	 */
	@RequestMapping(value = "/gallery.do")
	public String gallery(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","07");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 커뮤니티 > 갤러리 view
	 */
	@RequestMapping(value = "/gallery_view.do")
	public String gallery_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","07");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 지원정책 > 갤러리 등록&수정
	 */
	@RequestMapping(value = "/gallery_action.do")
	public String gallery_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			if(request.getParameter("type").equals("update"))
				return "forward:/site/board/boardUpdatePage.do";
			else
				return "forward:/site/board/boardInsertPage.do";
		}
	}
	/**
	 * 커뮤니티 > 자유게시판 list
	 */
	@RequestMapping(value = "/freeBoard.do")
	public String freeBoard(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","08");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 커뮤니티 > 자유게시판 view
	 */
	@RequestMapping(value = "/freeBoard_view.do")
	public String freeBoard_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","08");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 지원정책 > 자유게시판 등록&수정
	 */
	@RequestMapping(value = "/freeBoard_action.do")
	public String freeBoard_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			if(request.getParameter("type").equals("update"))
				return "forward:/site/board/boardUpdatePage.do";
			else
				return "forward:/site/board/boardInsertPage.do";
		}
	}
}
