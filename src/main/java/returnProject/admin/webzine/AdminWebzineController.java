package returnProject.admin.webzine;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.AdminWebzineService;
import returnProject.admin.service.HomepAdminService;
import returnProject.popup.service.PopupVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/admin/webzine")
public class AdminWebzineController {
	
	/** homepAdminService */
	@Resource(name = "HomepAdminService")
	private HomepAdminService homepAdminService;
	
	/** homepAdminService */
	@Resource(name = "AdminWebzineService")
	private AdminWebzineService adminWebzineService;

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	

	/**
	 * 웹진리스트
	 * @return
	 */
	@RequestMapping(value = "/webzine_list.do")
	public String homep_info_list(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> map = adminWebzineService.selectWebzineList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
		paginationInfo.setTotalRecordCount(totCnt);
					
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		//model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("curAdmin", user);
		/*return "/admin/homep/homep_info_list";*/
		return "/admin/webzine/webzine_list";
		
	}
	/**
	 * 홈페이지관리 > 웹진관리 view
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/webzine_view.do")
	public String homep_info_view(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		// update 일때만 조회
		if(popupVO.getType().equals("update")){
			popupVO = adminWebzineService.selectWebzineView(popupVO.getPopup_no());
			model.addAttribute("popupVO", popupVO);
			
			// 첨부파일 조회
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(popupVO.getAtch_file_id());
			// 마지막 파일 참조
			int newMaxFileSN = fileMngService.getMaxFileSN(fileVO);
			fileVO.setFileSn(Integer.toString(newMaxFileSN - 1));
			FileVO file = fileMngService.selectFileInf(fileVO);
			model.addAttribute("file", file);
		}

		model.addAttribute("curAdmin", user);
		return "/admin/webzine/webzine_view";
		
	}	
	/**
	 * 웹진 관리 > 웹진 등록
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/webzine_insert.do")
	public String webzine_insert(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "WEBZINE_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		adminWebzineService.webzine_insert(popupVO);
		
		return "redirect:/admin/webzine/webzine_list.do";
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/webzine_update.do")
	public String webzine_update(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "WEBZINE_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		adminWebzineService.webzine_update(popupVO);

		return "redirect:/admin/webzine/webzine_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/webzine_delete.do")
	public String webzine_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		adminWebzineService.webzine_delete(popupVO);
		
		return "redirect:/admin/webzine/webzine_list.do";
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 첨부파일 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/info_file_delete.do")
	public String info_file_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		adminWebzineService.webzine_file_delete(popupVO);
		
		return "redirect:/admin/homep/homep_info_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}

	
	
	
}