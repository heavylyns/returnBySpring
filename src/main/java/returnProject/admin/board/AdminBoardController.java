package returnProject.admin.board;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;
import org.apache.commons.lang.StringEscapeUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.HomepAdminService;

@Controller
@RequestMapping("/admin/board")
public class AdminBoardController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/** adminService */
	@Resource(name = "AdminBoardService")
	private AdminBoardService adminBoardService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	

	
	/**
	 * 관리자 > login action
	 * @param adminVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectBoardList.do")
	public String selectBoardList(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";

		String boardCode = request.getParameter("boardCode");
			
		boardVO.setBoardCode(boardCode);
			
		if("07".equals(boardCode)){
			boardVO.setPageUnit(propertyService.getInt("galleryPageUnit"));
			boardVO.setPageSize(propertyService.getInt("galleryPageSize"));
		}else{
			boardVO.setPageUnit(propertyService.getInt("pageUnit"));
			boardVO.setPageSize(propertyService.getInt("pageSize"));
		}
		if("03".equals(boardCode) || "09".equals(boardCode)){
			List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
			model.addAttribute("regionCombo", regionCombo);
		}			
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
		
			// 1. 일반 로그인 처리
			
			//List<AdminBoardVO> referenceList = adminBoardService.selectReferenceList(boardVO);
	//		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		Map<String, Object> map = adminBoardService.selectBoardList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		//int totCnt = referenceList.size();
			
		paginationInfo.setTotalRecordCount(totCnt);
//		AdminVO resultVO = null;
		model.addAttribute("curAdmin", user);
			
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		if("01".equals(boardCode)){
			returnUrl = "/admin/board/reference/referenceList";
		}else if("02".equals(boardCode)){
			returnUrl = "/admin/board/onlineAdvice/onlineAdviceList";
		}else if("03".equals(boardCode)){
			returnUrl = "/admin/board/returnExample/returnExList";
		}else if("04".equals(boardCode)){
			returnUrl = "/admin/board/myReturnStory/returnStoryList";
		}else if("05".equals(boardCode)){
			returnUrl = "/admin/board/inqueryMentor/inqueryMentorList";
		}else if("06".equals(boardCode)){
			returnUrl = "/admin/board/returnNews/returnNewsList";
		}else if("07".equals(boardCode)){
			returnUrl = "/admin/board/gallery/galleryList";
		}else if("08".equals(boardCode)){
			returnUrl = "/admin/board/freeBoard/freeBoardList";
		}else if("09".equals(boardCode)){
			returnUrl = "/admin/education/regionalEducation/regionalEduList";
		}
		return returnUrl;
//		}
	}
	
	
	@RequestMapping(value = "/selectBoardArticle.do")
	public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();

		adminBoardService.boardViewUpdate(boardVO);
			
		AdminBoardVO vo = adminBoardService.selectBoardArticle(boardVO);
		if("02".equals(boardCode) || "05".equals(boardCode)){
			if("Y".equals(vo.getStatus())){
				List<AdminBoardVO> replyList = adminBoardService.selectReplyArticle(boardVO);
				model.addAttribute("replySize", replyList.size());
				model.addAttribute("replyList", replyList);
			}
			
		}
		
		model.addAttribute("result", vo);
		model.addAttribute("curAdmin", user);
			

						
		if("01".equals(boardCode)){
			returnUrl = "/admin/board/reference/referenceView";
		}else if("02".equals(boardCode)){
			returnUrl = "/admin/board/onlineAdvice/onlineAdviceView";
		}else if("03".equals(boardCode)){
			returnUrl = "/admin/board/returnExample/returnExView";
		}else if("04".equals(boardCode)){
			returnUrl = "/admin/board/myReturnStory/returnStoryView";
		}else if("05".equals(boardCode)){
			returnUrl = "/admin/board/inqueryMentor/inqueryMentorView";
		}else if("06".equals(boardCode)){
			returnUrl = "/admin/board/returnNews/returnNewsView";
		}else if("07".equals(boardCode)){
			returnUrl = "/admin/board/gallery/galleryView";
		}else if("08".equals(boardCode)){
			returnUrl = "/admin/board/freeBoard/freeBoardView";
		}else if("09".equals(boardCode)){
			returnUrl = "/admin/education/regionalEducation/regionalEduView";
		}
		return returnUrl;

	}

	@RequestMapping(value = "/boardAddPage.do")
	public String selectBoardAddPage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();

		if("03".equals(boardCode) || "09".equals(boardCode)){
			List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
			model.addAttribute("regionCombo", regionCombo);
		}			
		model.addAttribute("curAdmin", user);
		
		
		if("01".equals(boardCode)){
			returnUrl = "/admin/board/reference/referenceAdd";
		}else if("02".equals(boardCode)){
			returnUrl = "/admin/board/onlineAdvice/onlineAdviceAdd";
		}else if("03".equals(boardCode)){
			returnUrl = "/admin/board/returnExample/returnExAdd";
		}else if("04".equals(boardCode)){
			returnUrl = "/admin/board/myReturnStory/returnStoryAdd";
		}else if("05".equals(boardCode)){
			returnUrl = "/admin/board/inqueryMentor/inqueryMentorAdd";
		}else if("06".equals(boardCode)){
			returnUrl = "/admin/board/returnNews/returnNewsAdd";
		}else if("07".equals(boardCode)){
			returnUrl = "/admin/board/gallery/galleryAdd";
		}else if("08".equals(boardCode)){
			returnUrl = "/admin/board/freeBoard/freeBoardAdd";
		}else if("09".equals(boardCode)){
			returnUrl = "/admin/education/regionalEducation/regionalEduAdd";
		}
		return returnUrl;

	}


	@RequestMapping(value = "/boardInsert.do")
	public void boardInsert(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			
		String boardCode = boardVO.getBoardCode();
		
					
		model.addAttribute("curAdmin", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.boardInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	
	@RequestMapping(value = "/boardUpdatePage.do")
	public String boardUpdatePage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();

			
		AdminBoardVO vo = adminBoardService.selectBoardArticle(boardVO);
					
		model.addAttribute("result", vo);
		if("03".equals(boardCode) || "09".equals(boardCode)){
			List<AdminBoardVO> regionCombo = adminBoardService.regionCombo(boardVO);
			model.addAttribute("regionCombo", regionCombo);
		}
		model.addAttribute("curAdmin", user);
		
		if("01".equals(boardCode)){
			returnUrl = "/admin/board/reference/referenceUpdate";
		}else if("02".equals(boardCode)){
			returnUrl = "/admin/board/onlineAdvice/onlineAdviceUpdate";
		}else if("03".equals(boardCode)){
			returnUrl = "/admin/board/returnExample/returnExUpdate";
		}else if("04".equals(boardCode)){
			returnUrl = "/admin/board/myReturnStory/returnStoryUpdate";
		}else if("05".equals(boardCode)){
			returnUrl = "/admin/board/inqueryMentor/inqueryMentorUpdate";
		}else if("06".equals(boardCode)){
			returnUrl = "/admin/board/returnNews/returnNewsUpdate";
		}else if("07".equals(boardCode)){
			returnUrl = "/admin/board/gallery/galleryUpdate";
		}else if("08".equals(boardCode)){
			returnUrl = "/admin/board/freeBoard/freeBoardUpdate";
		}else if("09".equals(boardCode)){
			returnUrl = "/admin/education/regionalEducation/regionalEduUpdate";
		}
		return returnUrl;

	}

	@RequestMapping(value = "/boardUpdate.do")
	public void boardUpdate(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
		int pageIndex = boardVO.getPageIndex();
		String searchCnd = boardVO.getSearchCnd();
		String searchWrd = boardVO.getSearchWrd();
		
						
		model.addAttribute("curAdmin", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.boardUpdate(request, boardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	@RequestMapping(value = "/boardDelete.do", method=RequestMethod.POST)
	public void boardDelete(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		String boardCode = boardVO.getBoardCode();
		AdminBoardVO adminBoardVO = new AdminBoardVO();
		
		adminBoardVO.setBoard_code(boardVO.getBoardCode());
		adminBoardVO.setBoard_no(Integer.parseInt(boardVO.getBoardNo()));
		adminBoardVO.setWriter(request.getParameter("writer"));
		
//		adminBoardService.boardDelete(adminBoardVO);
						
		model.addAttribute("curAdmin", user);
			
//		return "redirect:/admin/board/selectBoardList.do?boardCode="+boardCode;
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.boardDelete(adminBoardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	
	

	@RequestMapping(value = "/replyInsert.do")
	public void replyInsert(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		
		String boardNo = boardVO.getBoardNo();
		String boardCode = boardVO.getBoardCode();
		
					
		model.addAttribute("curAdmin", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.replyInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}

	@RequestMapping(value = "/replyUpdate.do")
	public void replyUpdate(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
		
		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
		;
						
		model.addAttribute("curAdmin", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.replyUpdate(request, boardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}	

	@RequestMapping(value = "/replyDelete.do")
	public void replyDelete(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
		AdminBoardVO adminBoardVO = new AdminBoardVO();
			
		adminBoardVO.setReply_no(Integer.parseInt(request.getParameter("replyNo")));
		adminBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
			
		;
						
		model.addAttribute("curAdmin", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", adminBoardService.replyDelete(adminBoardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	
	
	
}
