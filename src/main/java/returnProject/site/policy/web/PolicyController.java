package returnProject.site.policy.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import returnProject.admin.service.AdminEducationVO;
import returnProject.site.main.service.SiteMemberVO;
import returnProject.site.policy.service.PolicyService;
import egovframework.com.cop.bbs.service.BoardVO;


@Controller
@RequestMapping("/site/policy")
public class PolicyController {
	
	/** policyService */
	@Resource(name = "policyService")
	private PolicyService policyService;
	
	/**
	 * 지원정책 > 강원도 지원정책
	 */
	@RequestMapping(value = "/gangwondo.do")
	public String gangwondo(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/policy/gangwondo";
	}
	/**
	 * 지원정책 > 시군 지원정책
	 */
	@RequestMapping(value = "/city.do")
	public String city(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/policy/city";
	}
	/**
	 * 지원정책 > 귀농인의 집
	 */
	@RequestMapping(value = "/house.do")
	public String house(ModelMap model, HttpServletRequest request) throws Exception{
		String house_no = request.getParameter("houseNo");	// 귀농인의집 코드를 얻는다.
		List<AdminEducationVO> houseDateData =  policyService.houseDateData(house_no);	//귀농인의 집 코드에 해당하는 교육일정을 가져온다.
		model.addAttribute("houseDateData", houseDateData);
		return "/site/policy/house";
	}
	
	/**
	 * 지원정책 > 체류형 농업창업지원센터
	 */
	@RequestMapping(value = "/fcenter.do")
	public String fcenter(ModelMap model, HttpServletRequest request) throws Exception{
		return "/site/policy/fcenter";
	}
	
	/**
	 * 지원정책 > 자료실
	 */
	@RequestMapping(value = "/reference.do")
	public String reference(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","01");
		return "forward:/site/board/selectBoardList.do";
	}
	/**
	 * 지원정책 > 자료실view
	 */
	@RequestMapping(value = "/reference_view.do")
	public String reference_view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		request.setAttribute("boardCode","01");
		return "forward:/site/board/selectBoardArticle.do";
	}
	/**
	 * 지원정책 > 자료실 등록&수정
	 */
	@RequestMapping(value = "/reference_action.do")
	public String reference_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{
			if(request.getParameter("type").equals("update")){
				return "forward:/site/board/boardUpdatePage.do";
			}
			else
				return "/site/board/reference/insert";
		}
	}
}
