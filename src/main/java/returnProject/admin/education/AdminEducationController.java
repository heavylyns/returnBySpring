package returnProject.admin.education;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import returnProject.admin.service.AdminBoardService;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminEducationService;
import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.HomepAdminService;

@Controller
@RequestMapping("/admin/education")
public class AdminEducationController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	
	@Resource(name = "AdminEducationService")
	private AdminEducationService adminEducationService;
	
	/** adminService */
	@Resource(name = "AdminBoardService")
	private AdminBoardService adminBoardService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	

	
	@RequestMapping(value = "/selectReturnHouse.do")
	public String selectBoardList(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		String houseCode = adminEduVO.getHouse_code();
		if("".equals(houseCode) || houseCode == null){
			adminEduVO.setHouse_code("01");
		}
		
		adminEduVO.setPageUnit(propertyService.getInt("pageUnit"));
		adminEduVO.setPageSize(propertyService.getInt("pageSize"));
						
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(adminEduVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(adminEduVO.getPageUnit());
		paginationInfo.setPageSize(adminEduVO.getPageSize());
		
		adminEduVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adminEduVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adminEduVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
		
			// 1. 일반 로그인 처리
			
			//List<AdminBoardVO> referenceList = adminBoardService.selectReferenceList(boardVO);
	//		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		Map<String, Object> map = adminEducationService.selectReturnHouseList(adminEduVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			//int totCnt = referenceList.size();
			
		paginationInfo.setTotalRecordCount(totCnt);
	//		AdminVO resultVO = null;
		model.addAttribute("curAdmin", user);
		model.addAttribute("houseCode", houseCode);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		returnUrl = "/admin/education/returnHouse/returnHouseList";
		
		return returnUrl;
		
	}
	@RequestMapping(value = "/returnHouseAddPage.do")
	public String returnHouseAddPage(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		model.addAttribute("curAdmin", user);
		returnUrl = "/admin/education/returnHouse/returnHouseAdd";
		
		return returnUrl;
		
	}

	@RequestMapping(value = "/returnHouseInsert.do")
	public void returnHouseInsert(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String houseCode = adminEduVO.getHouse_code();
		
		model.addAttribute("curAdmin", user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.returnHouseInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	@RequestMapping(value = "/returnHouseUpdatePage.do")
	public String returnHouseUpdatePage(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		AdminEducationVO result = new AdminEducationVO();
		result = adminEducationService.selectReturnHouseArticle(request);
		
		model.addAttribute("result", result);
		model.addAttribute("curAdmin", user);
		returnUrl = "/admin/education/returnHouse/returnHouseUpdate";
		
		return returnUrl;
		
	}

	@RequestMapping(value = "/returnHouseUpdate.do")
	public void returnHouseUpdate(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String houseCode = adminEduVO.getHouse_code();
		
		model.addAttribute("curAdmin", user);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.returnHouseUpdate(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
//	@RequestMapping(value = "/returnHouseDelete.do")
//	public String returnHouseDelete(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model) throws Exception {
//		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
//		String houseCode = adminEduVO.getHouse_code();
//		adminEducationService.returnHouseDelete(request);
//		model.addAttribute("curAdmin", user);
//		return "redirect:/admin/education/selectReturnHouse.do?house_code="+houseCode;
//		
//	}
	@RequestMapping(value = "/returnHouseDelete.do")
	public void returnHouseDelete(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String houseCode = adminEduVO.getHouse_code();
		
		model.addAttribute("curAdmin", user);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.returnHouseDelete(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/selectRegionalEduList.do")
	public String selectRegionalEduList(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		
		
		adminEduVO.setPageUnit(propertyService.getInt("pageUnit"));
		adminEduVO.setPageSize(propertyService.getInt("pageSize"));
						
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(adminEduVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(adminEduVO.getPageUnit());
		paginationInfo.setPageSize(adminEduVO.getPageSize());
		
		adminEduVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adminEduVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adminEduVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		BoardVO boardVO = new BoardVO();
		List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
		model.addAttribute("regionCombo", regionCombo);
		
		Map<String, Object> map = adminEducationService.selectRegionalEduList(adminEduVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
			
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("curAdmin", user);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		returnUrl = "/admin/education/regionalEducation/regionalEduList";
		
		return returnUrl;
		
	}
	@RequestMapping(value = "/selectRegionalEduArticle.do")
	public String selectRegionalEduArticle(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
				
		AdminEducationVO adminEdcationVO = adminEducationService.selectRegionalEduArticle(request);
				

		model.addAttribute("curAdmin", user);		
		model.addAttribute("result", adminEdcationVO);
		
		returnUrl = "/admin/education/regionalEducation/regionalEduView";
		
		return returnUrl;
		
	}
	@RequestMapping(value = "/regionalEduAddPage.do")
	public String regionalEduAddPage(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		model.addAttribute("curAdmin", user);
		BoardVO boardVO = new BoardVO();
		List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
		model.addAttribute("regionCombo", regionCombo);
		
		returnUrl = "/admin/education/regionalEducation/regionalEduAdd";
		
		return returnUrl;
		
	}

	@RequestMapping(value = "/regionalEduInsert.do")
	public void regionalEduInsert(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		
		model.addAttribute("curAdmin", user);
		
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.regionalEduInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	@RequestMapping(value = "/regionalEduUpdatePage.do")
	public String regionalEduUpdatePage(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		AdminEducationVO result = new AdminEducationVO();
		result = adminEducationService.selectRegionalEduArticle(request);
		BoardVO boardVO = new BoardVO();
		List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
		model.addAttribute("regionCombo", regionCombo);
		model.addAttribute("result", result);
		model.addAttribute("curAdmin", user);
		returnUrl = "/admin/education/regionalEducation/regionalEduUpdate";
		
		return returnUrl;
		
	}

	
	@RequestMapping(value = "/regionalEduUpdate.do")
	public void regionalEduUpdate(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		int r_edu_no = adminEduVO.getR_edu_no();
		
		model.addAttribute("curAdmin", user);


		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.regionalEduUpdate(request, adminEduVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}

	@RequestMapping(value = "/regionalEduDelete.do")
	public void regionalEduDelete(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String houseCode = adminEduVO.getHouse_code();
		
		model.addAttribute("curAdmin", user);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminEducationService.regionalEduDelete(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}

	
	
}
