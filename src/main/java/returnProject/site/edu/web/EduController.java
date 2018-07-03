package returnProject.site.edu.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.AdminVO;
import returnProject.site.board.service.BoardService;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.edu.service.EduService;
import returnProject.site.edu.service.EducationVO;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/site/edu")
public class EduController {
	
	@Resource(name = "eduService")
	private EduService eduService;
	
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	
    @Resource(name = "boardService")
    private BoardService boardService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	
	/**
	 * 교육정보 > 이달의 교육
	 */
	@RequestMapping(value = "/monthlyEdu.do")
	public String monthlyEdu(HttpServletRequest request, ModelMap model) throws Exception {
		
		//이달의 교육으로 등록된 교육 일정을 가져온다.
		List<AdminEducationVO> eduList = eduService.selectEduList();
		
		model.addAttribute("eduList", eduList);
		
		return "/site/edu/monthlyEdu";
	}
	
	
	/**
	 * 교육정보 > 시군별 교육 list
	 */
	@RequestMapping(value = "/cityEdu.do")
	public String selectRegionalEduList(@ModelAttribute("searchVO") EducationVO eduVO, HttpServletRequest request, ModelMap model) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		String returnUrl = "";
		
		
		eduVO.setPageUnit(propertyService.getInt("pageUnit"));
		eduVO.setPageSize(propertyService.getInt("pageSize"));
						
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(eduVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eduVO.getPageUnit());
		paginationInfo.setPageSize(eduVO.getPageSize());
		
		eduVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eduVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eduVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		BoardVO boardVO = new BoardVO();
		List<SiteBoardVO> regionCombo = boardService.regionCombo(boardVO);
		
		
		Map<String, Object> map = boardService.selectRegionalEduList(eduVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
			
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("regionCombo", regionCombo);
		model.addAttribute("loginVO", user);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		returnUrl = "/site/board/cityEdu/list";
		
		return returnUrl;
	}
	
	/**
	 * 교육정보 > 시군별 교육 view
	 */
	@RequestMapping(value = "/cityEdu_view.do")
	public String selectRegionalEduArticle(@ModelAttribute("searchVO") EducationVO eduVO, HttpServletRequest request, ModelMap model) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		EducationVO educationVO = boardService.selectRegionalEduArticle(request);
	
		model.addAttribute("loginVO", user);
		model.addAttribute("result", educationVO);
		
		return "/site/board/cityEdu/view";
	}
	/**
	 * 교육정보 > 시군별 교육 등록&수정
	 */
	@RequestMapping(value = "/cityEdu_action.do")
	public String reference_insert(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception{
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		if (user == null){
			return "/site/member/login";
		}
		else{ 
			List<SiteBoardVO> regionCombo = boardService.regionCombo(boardVO);	//지역코드, 지역이름 조회
			//수정	
			if(request.getParameter("type").equals("update")){ 
				EducationVO educationVO = boardService.selectRegionalEduArticle(request);
				model.addAttribute("result",educationVO);
				model.addAttribute("regionCombo", regionCombo);
				model.addAttribute("loginVO",user);
				return "/site/board/cityEdu/update";
			}
			//글쓰기
			else{ 
				model.addAttribute("regionCombo", regionCombo);
				model.addAttribute("loginVO", user);
				return "/site/board/cityEdu/insert";
			}
		}
	}
	/**
	 * 시군별교육 등록
	 */
	@RequestMapping(value = "/regionalEduInsert.do")
	public void regionalEduInsert(@ModelAttribute("searchVO") AdminEducationVO adminEduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");

		model.addAttribute("loginVO", user);
		
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.regionalEduInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	/**
	 * 시군별 교육 수정
	 */
	@RequestMapping(value = "/regionalEduUpdate.do")
	public void regionalEduUpdate(@ModelAttribute("searchVO") EducationVO eduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		int r_edu_no = eduVO.getR_edu_no();
		
		model.addAttribute("loginVO", user);


		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.regionalEduUpdate(request, eduVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
		
	}
	/**
	 * 시군별 교육 삭제
	 */
	@RequestMapping(value = "/regionalEduDelete.do")
	public void regionalEduDelete(@ModelAttribute("searchVO") EducationVO eduVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		model.addAttribute("loginVO", user);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.regionalEduDelete(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	
	@RequestMapping(value = "/regionalEduDataByDate.do")
	public void regionalEduDataByDate(@RequestParam(value = "standard_date") String standard_date, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		/*SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		model.addAttribute("loginVO", user);
*/
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("resultList", eduService.regionalEduDataByDate(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	@RequestMapping(value = "/regionalEduDataByDateInfo.do")
	public void regionalEduDataByDateInfo(@RequestParam(value = "education_no") String education_no, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		/*SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		model.addAttribute("loginVO", user);
*/
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("resultList", eduService.regionalEduDataByDateInfo(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
}
