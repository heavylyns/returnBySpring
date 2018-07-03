package returnProject.admin.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.uss.umt.service.EgovMberManageService;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.HomepAdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/** adminService */
	@Resource(name = "AdminService")
	private AdminService adminService;


	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 관리자 > login
	 * @return
	 */
	@RequestMapping(value = "/login.do")
	public String login(HttpServletRequest request, ModelMap model) {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String url = "";
		
		if (user != null) {
			url = "redirect:/admin/main.do";
		}else{
			url = "/admin/login";
		}
		return url;
	}
	
	/**
	 * 관리자 > login action
	 * @param adminVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminLogin.do")
	public String adminLogin(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request, ModelMap model) throws Exception {

		// 1. 일반 로그인 처리
		AdminVO resultVO = adminService.adminLogin(adminVO);
//		AdminVO resultVO = null;

		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			System.out.println("로그인성공");

			// 메뉴권한 조회
			List<AdminRoleVO> adminMenus = adminService.getAdminRole(adminVO.getId());
			String menuIds = "";
			for (AdminRoleVO m : adminMenus) {
				menuIds += "[" + String.valueOf(m.getMenu_id()) + "]";
			}
			System.out.println("menuIds::::::::::::::::::::::::::::::::::::"+menuIds);
			resultVO.setMenuIds(menuIds);
			
			// 2-1. 로그인 정보를 세션에 저장
			request.getSession().setAttribute("adminVO", resultVO);
			
			model.addAttribute("adminVO", resultVO);
//			if(resultVO.getRoleId().equals("1")){
//				return "redirect:/admin/fran/franchise_new_list.do";
//			}else{
//				return "redirect:/admin/fran/franchise_add.do";
//			}
			return "redirect:/admin/main.do";
		} else {
			System.out.println("로그인씰패");
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "forward:/admin/login.do";
		}
	}

	/**
	 * 관리자 > logout action
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminLogout.do")
	public String adminLogout(HttpServletRequest request, ModelMap model) throws Exception {

		/*String userIp = EgovClntInfo.getClntIP(request);

		// 1. Security 연동
		return "redirect:/j_spring_security_logout";*/

		request.getSession().setAttribute("adminVO", null);

		//return "redirect:/egovDevIndex.jsp";
		return "redirect:/admin/login.do";
	}
	
	
	@RequestMapping(value = "/main.do")
	public String adminMain(HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		if (user == null) {
			return "redirect:/admin/login.do";
		}else{
			HttpSession session = request.getSession();
			String visitorCounterYn= (String) session.getAttribute("visitorCounterYn");
			if(visitorCounterYn != null){
				if(visitorCounterYn.equals("Y")){
					adminService.visitorCounter();
					session.removeAttribute("visitorCounterYn");
				}
			}

			
			AdminBoardVO houseCnt = adminService.boardCnt("00");
			model.addAttribute("houseCnt", houseCnt);
			AdminBoardVO inqueryCnt = adminService.boardCnt("05");
			model.addAttribute("inqueryCnt", inqueryCnt);
			AdminBoardVO adviceCnt = adminService.boardCnt("02");
			model.addAttribute("adviceCnt", adviceCnt);
			AdminBoardVO freeCnt = adminService.boardCnt("08");
			model.addAttribute("freeCnt", freeCnt);
			AdminBoardVO storyCnt = adminService.boardCnt("04");
			model.addAttribute("storyCnt", storyCnt);
			
			List<AdminVO> recentVisitorMap = adminService.getRecentVisitor();
			model.addAttribute("recentVisitorResult", recentVisitorMap);
			List<AdminVO> monthlyVisitorMap = adminService.monthlyVisitor(request);
			model.addAttribute("monthlyVisitorResult", monthlyVisitorMap);
			
		}
		
		model.addAttribute("curAdmin", user);
		
		return "/admin/main";
	}
}
