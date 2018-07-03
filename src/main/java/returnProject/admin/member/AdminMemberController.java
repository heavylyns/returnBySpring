package returnProject.admin.member;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import returnProject.admin.service.AdminBoardService;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminMemberService;
import returnProject.admin.service.AdminMemberVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.AdminWebzineService;
import returnProject.admin.service.HomepAdminService;
import returnProject.popup.service.PopupVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	/** homepAdminService */
	@Resource(name = "AdminMemberService")
	private AdminMemberService adminMemberService;
	
	@Resource(name = "AdminBoardService")
	private AdminBoardService adminBoardService;
	
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	

	/**
	 * 회원관리 - 리스트
	 * @return
	 */
	@RequestMapping(value = "/member_list.do")
	public String member_list(@ModelAttribute("AdminMemberVO") AdminMemberVO adminMemberVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(adminMemberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(adminMemberVO.getPageUnit());
		paginationInfo.setPageSize(adminMemberVO.getPageSize());
	
		adminMemberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adminMemberVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adminMemberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> map = adminMemberService.selectAdminMemberList(adminMemberVO);
//		Map<String, Object> map = null;
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<AdminMemberVO> regionStatisticsList = adminMemberService.selectRegionStatistics(adminMemberVO);
					
		model.addAttribute("regionStatisticsList", regionStatisticsList);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("preReturnCnt", map.get("preReturnCnt"));
		model.addAttribute("returnedCnt", map.get("returnedCnt"));
		model.addAttribute("adminMemberVO", adminMemberVO);
		//model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("curAdmin", user);
		/*return "/admin/homep/homep_info_list";*/
		return "/admin/member/memberList";
		
	}
	
	@RequestMapping(value = "/member_view.do")
	public String homep_info_view(@ModelAttribute("AdminMemberVO") AdminMemberVO adminMemberVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		// update 일때만 조회
		if(adminMemberVO.getType().equals("update")){
			adminMemberVO = adminMemberService.selectAdminMember(adminMemberVO.getId());
			model.addAttribute("result", adminMemberVO);
	
		}
		BoardVO boardVO = null;
		List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
		model.addAttribute("type", request.getParameter("type"));
		model.addAttribute("regionCombo", regionCombo);
		model.addAttribute("curAdmin", user);
		return "/admin/member/memberView";
		
	}
	
	@RequestMapping(value = "/member_insert.do")
	public void member_insert(@ModelAttribute("AdminMemberVO") AdminMemberVO adminMemberVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		model.addAttribute("curAdmin", user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminMemberService.memberInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	@RequestMapping(value = "/idCheck.do")
	public void idCheck(@RequestParam(value = "id") String id, HttpServletRequest request, ModelMap model, HttpServletResponse reps, HttpSession session) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		model.addAttribute("curAdmin", user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminMemberService.idCheck(id));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	@RequestMapping(value = "/member_update.do")
	public void member_update(@ModelAttribute("AdminMemberVO") AdminMemberVO adminMemberVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		model.addAttribute("curAdmin", user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminMemberService.memberUpdate(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	@RequestMapping(value = "/member_delete.do")
	public void member_delete(@RequestParam(value = "id") String id, HttpServletRequest request, ModelMap model, HttpServletResponse reps, HttpSession session) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		model.addAttribute("curAdmin", user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminMemberService.memberDelete(id));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	
}