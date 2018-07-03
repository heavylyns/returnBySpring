package returnProject.site.counsel.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.BoardVO;
import returnProject.site.counsel.service.CounselService;
import returnProject.site.main.service.SiteMemberVO;


@Controller
@RequestMapping("/site/counsel")
public class CounselController {
	/** CounselService */
	@Resource(name = "counselService")
	private CounselService counselService;
	
	/**
	 * 귀농귀촌상담 > 준비절차
	 */
	@RequestMapping(value = "/ready.do")
	public String ready(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/counsel/ready";
	}
	
	/**
	 * 귀농귀촌상담 > 상담안내
	 */
	@RequestMapping(value = "/info.do")
	public String info(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/counsel/info";
	}
	
	/**
	 * 귀농귀촌상담 > 온라인 상담
	 */
	@RequestMapping(value = "/onlineCounsel.do")
	public String onlineCounsel(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","02");
		return "forward:/site/board/selectBoardList.do";
	}
	
	/**
	 * 귀농귀촌상담 > 온라인 상담 view
	 */
	@RequestMapping(value = "/onlineCounsel_view.do")
	public String onlineCounsel_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","02");
		return "forward:/site/board/selectBoardArticle.do";
	}
	
	/**
	 * 귀농귀촌상담 > 온라인 상담 작성&수정
	 */
	@RequestMapping(value = "/onlineCounsel_action.do")
	public String onlineCounsel_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
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
	 * 귀농귀촌상담 > 시군별 상담센터
	 */
	@RequestMapping(value = "/cityCenter.do")
	public String cityCenter(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/counsel/cityCenter";
	}
	
	/**
	 * 귀농귀촌상담 > 강원 멘토단
	 */
	@RequestMapping(value = "/mentor.do")
	public String mentor(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/counsel/mentor";
	}
	
}
