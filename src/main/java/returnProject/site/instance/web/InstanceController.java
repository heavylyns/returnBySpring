package returnProject.site.instance.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cop.bbs.service.BoardVO;

@Controller
@RequestMapping("/site/instance")
public class InstanceController {
	/**
	 * 귀농귀촌사례 > 귀농귀촌사례
	 */
	@RequestMapping(value = "/instance.do")
	public String instance(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","03");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 귀농귀촌사례 > 귀농귀촌사례view
	 */
	@RequestMapping(value = "/instance_view.do")
	public String instance_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","03");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 귀농귀촌사례 > 귀농귀촌사례 등록&수정
	 */
	@RequestMapping(value = "/instance_action.do")
	public String instance_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			request.setAttribute("boardCode","03");
			if(request.getParameter("type").equals("update"))
				return "forward:/site/board/boardUpdatePage.do";
			else
				return "forward:/site/board/boardInsertPage.do";
		}
	}
	
	/**
	 * 귀농귀촌사례 > 나의 귀농귀촌 이야기
	 */
	@RequestMapping(value = "/story.do")
	public String story(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","04");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 귀농귀촌사례 > 나의 귀농귀촌 이야기view
	 */
	@RequestMapping(value = "/story_view.do")
	public String story_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","04");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 귀농귀촌사례 > 나의 귀농귀촌 이야기 등록&수정
	 */
	@RequestMapping(value = "/story_action.do")
	public String story_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			request.setAttribute("boardCode","04");
			if(request.getParameter("type").equals("update"))
				return "forward:/site/board/boardUpdatePage.do";
			else
				return "forward:/site/board/boardInsertPage.do";
		}
	}
	
	/**
	 * 귀농귀촌사례 > 멘토에게 물어봐
	 */
	@RequestMapping(value = "/askMentor.do")
	public String askMentor(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","05");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 귀농귀촌사례 > 멘토에게 물어봐 view
	 */
	@RequestMapping(value = "/askMentor_view.do")
	public String askMentor_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","05");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 귀농귀촌사례 > 멘토에게 물어봐 작성&수정
	 */
	@RequestMapping(value = "/askMentor_action.do")
	public String askMentor_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
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
