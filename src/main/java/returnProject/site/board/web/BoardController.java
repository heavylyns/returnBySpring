package returnProject.site.board.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.AdminVO;
import returnProject.site.board.service.BoardService;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/site/board")
public class BoardController {
	
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/** boardService */
	@Resource(name = "boardService")
	private BoardService boardService;
	/** propertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	//리스트조회
	@RequestMapping(value = "/selectBoardList.do")
	public String selectBoardList(@ModelAttribute("searchVO")BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception{
		String returnUrl="";
		PaginationInfo paginationInfo = new PaginationInfo();
		String boardCode = (String) request.getAttribute("boardCode");
		
		if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){	//포토게시판인 경우 페이징
			boardVO.setPageUnit(propertyService.getInt("galleryPageUnit"));
			boardVO.setPageSize(propertyService.getInt("galleryPageSize"));
		}else{	//그 외 게시판 페이징
			boardVO.setPageUnit(propertyService.getInt("pageUnit"));
			boardVO.setPageSize(propertyService.getInt("pageSize"));
		}
		
		if("03".equals(boardCode)){
			List<SiteBoardVO> regionCombo = boardService.regionCombo(boardVO);
			model.addAttribute("regionCombo", regionCombo);
		}
		
		/*페이징 설정 시작*/
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		boardVO.setBoardCode(boardCode);
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		/*페이징 설정 종료*/
		
		Map<String, Object> map = boardService.selectBoardList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("boardCode", boardCode);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		if("01".equals(boardCode)){
			returnUrl = "/site/board/reference/list";
		}else if("02".equals(boardCode)){
			returnUrl = "/site/board/onlineCounsel/list";
		}else if("03".equals(boardCode)){
			returnUrl = "/site/board/instance/list";
		}else if("04".equals(boardCode)){
			returnUrl = "/site/board/story/list";
		}else if("05".equals(boardCode)){
			returnUrl = "/site/board/askMentor/list";
		}else if("06".equals(boardCode)){
			returnUrl = "/site/board/news/list";
		}else if("07".equals(boardCode)){
			returnUrl = "/site/board/gallery/list";
		}else if("08".equals(boardCode)){
			returnUrl = "/site/board/freeBoard/list";
		}
		
		return returnUrl;
	}
	//뷰 호출
	@RequestMapping(value = "/selectBoardArticle.do")
	public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();
		boardService.boardViewUpdate(boardVO);
		SiteBoardVO vo = boardService.selectBoardArticle(boardVO);
		if("02".equals(boardCode) || "05".equals(boardCode)){	//답변 조회
			if("Y".equals(vo.getStatus())){
				List<SiteBoardVO> replyList = boardService.selectReplyArticle(boardVO);
				model.addAttribute("replySize", replyList.size());
				model.addAttribute("replyList", replyList);
			}
		}
		
		model.addAttribute("result", vo);
		model.addAttribute("user", user);
		if("01".equals(boardCode)){
			returnUrl = "/site/board/reference/view";
		}else if("02".equals(boardCode)){
			returnUrl = "/site/board/onlineCounsel/view";
		}else if("03".equals(boardCode)){
			returnUrl = "/site/board/instance/view";
		}else if("04".equals(boardCode)){
			returnUrl = "/site/board/story/view";
		}else if("05".equals(boardCode)){
			returnUrl = "/site/board/askMentor/view";
		}else if("06".equals(boardCode)){
			returnUrl = "/site/board/news/view";
		}else if("07".equals(boardCode)){
			returnUrl = "/site/board/gallery/view";
		}else if("08".equals(boardCode)){
			returnUrl = "/site/board/freeBoard/view";
		}
		return returnUrl;
	}
	@RequestMapping(value = "/boardInsertPage.do")
	public String selectBoardAddPage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();
		if(user == null){
			return "redirect:/site/member/login.do";
		}
		else{
			if("03".equals(boardCode)){
				List<SiteBoardVO> regionCombo = boardService.regionCombo(boardVO);
				model.addAttribute("regionCombo", regionCombo);
			}			
			model.addAttribute("loginVO", user);
			
			if("01".equals(boardCode)){
				returnUrl = "/site/board/reference/insert";
			}else if("02".equals(boardCode)){
				returnUrl = "/site/board/onlineCounsel/insert";
			}else if("03".equals(boardCode)){
				returnUrl = "/site/board/instance/insert";
			}else if("04".equals(boardCode)){
				returnUrl = "/site/board/story/insert";
			}else if("05".equals(boardCode)){
				returnUrl = "/site/board/askMentor/insert";
			}else if("06".equals(boardCode)){
				returnUrl = "/site/board/news/insert";
			}else if("07".equals(boardCode)){
				returnUrl = "/site/board/gallery/insert";
			}else if("08".equals(boardCode)){
				returnUrl = "/site/board/freeBoard/insert";
			}
			return returnUrl;
		}

	}
	@RequestMapping(value = "/boardInsert.do")
	public void boardInsert(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		String boardCode = boardVO.getBoardCode();
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.boardInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	@RequestMapping(value = "/boardUpdatePage.do")
	public String boardUpdatePage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		String returnUrl = "";
		String boardCode = boardVO.getBoardCode();

			
		SiteBoardVO vo = boardService.selectBoardArticle(boardVO);
					
		model.addAttribute("result", vo);
		if("03".equals(boardCode) || "09".equals(boardCode)){
			List<SiteBoardVO> regionCombo = boardService.regionCombo(boardVO);
			model.addAttribute("regionCombo", regionCombo);
		}
		model.addAttribute("loginVO", user);
		
		if("01".equals(boardCode)){
			returnUrl = "/site/board/reference/update";
		}else if("02".equals(boardCode)){
			returnUrl = "/site/board/onlineCounsel/update";
		}else if("03".equals(boardCode)){
			returnUrl = "/site/board/instance/update";
		}else if("04".equals(boardCode)){
			returnUrl = "/site/board/story/update";
		}else if("05".equals(boardCode)){
			returnUrl = "/site/board/askMentor/update";
		}else if("06".equals(boardCode)){
			returnUrl = "/site/board/news/update";
		}else if("07".equals(boardCode)){
			returnUrl = "/site/board/gallery/update";
		}else if("08".equals(boardCode)){
			returnUrl = "/site/board/freeBoard/update";
		}else if("09".equals(boardCode)){
			returnUrl = "/admin/education/regionalEducation/regionalEduUpdate";
		}
		return returnUrl;

	}
	@RequestMapping(value = "/boardUpdate.do")
	public void boardUpdate(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
		int pageIndex = boardVO.getPageIndex();
		String searchCnd = boardVO.getSearchCnd();
		String searchWrd = boardVO.getSearchWrd();
		
						
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.boardUpdate(request, boardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	@RequestMapping(value = "/boardDelete.do", method=RequestMethod.POST)
	public void boardDelete(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");

		String boardCode = boardVO.getBoardCode();
		SiteBoardVO siteBoardVO = new SiteBoardVO();
		
		siteBoardVO.setBoard_code(boardVO.getBoardCode());
		siteBoardVO.setBoard_no(Integer.parseInt(boardVO.getBoardNo()));
		siteBoardVO.setWriter(request.getParameter("writer"));
		
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.boardDelete(siteBoardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();
	}
	@RequestMapping(value = "/replyInsert.do")
	public void replyInsert(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		
		String boardNo = boardVO.getBoardNo();
		String boardCode = boardVO.getBoardCode();
		
					
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.replyInsert(request));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	
	@RequestMapping(value = "/replyUpdate.do")
	public void replyUpdate(@ModelAttribute("searchVO") BoardVO boardVO, MultipartHttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
		
		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
						
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.replyUpdate(request, boardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
	
	@RequestMapping(value = "/replyDelete.do")
	public void replyDelete(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, HttpServletResponse reps) throws Exception {
		SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");

		String boardCode = boardVO.getBoardCode();
		String boardNo = boardVO.getBoardNo();
		SiteBoardVO siteBoardVO = new SiteBoardVO();
			
		siteBoardVO.setReply_no(Integer.parseInt(request.getParameter("replyNo")));
		siteBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
						
		model.addAttribute("loginVO", user);
			
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("count", boardService.replyDelete(siteBoardVO));

		reps.setContentType("text/json;charset=utf-8");
		PrintWriter pr = reps.getWriter();
		pr.write(jsonObject.toString());
		pr.flush();
		pr.close();

	}
}
