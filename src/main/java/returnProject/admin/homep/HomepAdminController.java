package returnProject.admin.homep;

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
@RequestMapping("/admin/homep")
public class HomepAdminController {
	
	/** homepAdminService */
	@Resource(name = "HomepAdminService")
	private HomepAdminService homepAdminService;

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/**
	 * 홈페이지관리 > 관리자관리 list
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/homep_admin_list.do")
	public String homep_admin_list(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		

			// 관리자 list
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> map = homepAdminService.selectAdminList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
		paginationInfo.setTotalRecordCount(totCnt);
					
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		//model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_admin_list";
		
	}

	/**
	 * 홈페이지관리 > 관리자관리 view
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/homep_admin_view.do")
	public String homep_admin_list(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		
			// update 일때만 조회
		if(adminVO.getType().equals("update")){
			adminVO = homepAdminService.selectAdminMember(adminVO.getId());
			model.addAttribute("homep_adminVO", adminVO);
		}

		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_admin_view";
		
	}
	
	/**
	 * 홈페이지관리 > 관리자관리 > 관리자 등록
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/admin_join.do")
	public String admin_join(@ModelAttribute("adminVO") AdminVO adminVO) throws Exception {
		
		homepAdminService.admin_join(adminVO);
		
		return "redirect:/admin/homep/homep_admin_list.do";
	}
	/**
	 * 홈페이지관리 > 관리자관리 > 관리자 수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/admin_update.do")
	public String admin_update(@ModelAttribute("adminVO") AdminVO adminVO) throws Exception {

		homepAdminService.admin_update(adminVO);

		return "redirect:/admin/homep/homep_admin_list.do";
	}
	/**
	 * 홈페이지관리 > 관리자관리 > 관리자 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/admin_delete.do")
	public String admin_delete(@ModelAttribute("adminVO") AdminVO adminVO) throws Exception {

		homepAdminService.admin_delete(adminVO);
		
		return "redirect:/admin/homep/homep_admin_list.do";
	}

	/**
	 * 홈페이지관리 > 권한관리 > 권한수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/homep_author.do")
	public String homep_author(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			
		BoardVO boardVO = new BoardVO();
		boardVO.setFirstIndex(0);
		boardVO.setRecordCountPerPage(1000);
			
		Map<String, Object> map = homepAdminService.selectAdminList(boardVO);
		model.addAttribute("resultList", map.get("resultList"));
			
		String admin_id = adminVO.getId();
		// id값이 안 넘어왔을때는 session id갑 사용
		if(admin_id == null || admin_id == ""){
			admin_id = user.getId();
		}
			// 메뉴권한 조회
		List<AdminRoleVO> adminMenus = homepAdminService.getAdminRole(admin_id);
		String menuIds = "";
		for (AdminRoleVO m : adminMenus) {
			menuIds += "[" + String.valueOf(m.getMenu_id()) + "]";
		}

		model.addAttribute("admin_id", admin_id);
		model.addAttribute("menuIds", menuIds);

		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_author";
		
	}

	/**
	 * 홈페이지관리 > 권한관리
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/author_agree.do")
	public String author_agree(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

					
		// 기존 메뉴권한 삭제
		homepAdminService.deleteAdminRole(adminVO.getId());
		// 메뉴권한 등록
		AdminRoleVO adminRoleVO = new AdminRoleVO();
		adminRoleVO.setId(adminVO.getId());
		String[] menuItems = adminVO.getMenuItems().split(":");
		for(String m: menuItems) {
			adminRoleVO.setMenu_id(m);
			homepAdminService.addAdminRole(adminRoleVO);
		}

		model.addAttribute("curAdmin", user);
		return "forward:/admin/homep/homep_author.do";
		
	}



	/**
	 * 홈페이지관리 > 관련기관 관리 > 관련기관 수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/organ_update.do")
	public String organ_update(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "ORGAN_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		homepAdminService.organ_update(popupVO);

		return "redirect:/admin/homep/homep_organ_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}
	/**
	 * 홈페이지관리 > 관련기관 관리 > 관련기관 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/organ_delete.do")
	public String organ_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_delete(popupVO);
		
		return "redirect:/admin/homep/homep_organ_list.do";
	}
	/**
	 * 홈페이지관리 > 관련기관 관리 > 관련기관 첨부파일 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/organ_file_delete.do")
	public String organ_file_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_file_delete(popupVO);
		
		return "redirect:/admin/homep/homep_organ_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}

	/**
	 * 홈페이지관리 > 인포존관리
	 * @return
	 */
	@RequestMapping(value = "/homep_info_list.do")
	public String homep_info_list(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			
		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> map = homepAdminService.selectInfoList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
		paginationInfo.setTotalRecordCount(totCnt);
					
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		//model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_info_list";
		
	}
	/**
	 * 홈페이지관리 > 인포존관리 view
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/homep_info_view.do")
	public String homep_info_view(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		// update 일때만 조회
		if(popupVO.getType().equals("update")){
			popupVO = homepAdminService.selectInfoView(popupVO.getPopup_no());
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
		return "/admin/homep/homep_info_view";
		
	}	
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 등록
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/info_join.do")
	public String info_join(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "INFO_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		homepAdminService.info_join(popupVO);
		
		return "redirect:/admin/homep/homep_info_list.do";
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/info_update.do")
	public String info_update(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "INFO_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		homepAdminService.info_update(popupVO);

		return "redirect:/admin/homep/homep_info_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/info_delete.do")
	public String info_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_delete(popupVO);
		
		return "redirect:/admin/homep/homep_info_list.do";
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 첨부파일 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/info_file_delete.do")
	public String info_file_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_file_delete(popupVO);
		
		return "redirect:/admin/homep/homep_info_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}

	/**
	 * 홈페이지관리 > 팝업관리
	 * @return
	 */
	@RequestMapping(value = "/homep_popup_list.do")
	public String homep_popup_list(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, Model model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

		PaginationInfo paginationInfo = new PaginationInfo();
			
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> map = homepAdminService.selectPopupList(boardVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
		paginationInfo.setTotalRecordCount(totCnt);
					
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		//model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);
			
		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_popup_list";
		
	}
	/**
	 * 홈페이지관리 > 팝업관리 view
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/homep_popup_view.do")
	public String homep_popup_view(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request, ModelMap model) throws Exception {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

			// update 일때만 조회
		if(popupVO.getType().equals("update")){
			popupVO = homepAdminService.selectPopupView(popupVO.getPopup_no());
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
		return "/admin/homep/homep_popup_view";
		
	}	
	/**
	 * 홈페이지관리 > 팝업관리 > 팝업 등록
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/popup_join.do")
	public String popup_join(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "INFO_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		homepAdminService.popup_join(popupVO);
		
		return "redirect:/admin/homep/homep_popup_list.do";
	}
	/**
	 * 홈페이지관리 > 팝업관리 > 팝업 수정
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/popup_update.do")
	public String popup_update(final MultipartHttpServletRequest multiRequest, @ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		// 이미지 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "INFO_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
	    }
	    popupVO.setAtch_file_id(atchFileId);
	    
		homepAdminService.popup_update(popupVO);

		return "redirect:/admin/homep/homep_popup_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/popup_delete.do")
	public String popup_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_delete(popupVO);
		
		return "redirect:/admin/homep/homep_popup_list.do";
	}
	/**
	 * 홈페이지관리 > 인포존 관리 > 인포존 첨부파일 삭제
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/popup_file_delete.do")
	public String popup_file_delete(@ModelAttribute("popupVO") PopupVO popupVO) throws Exception {

		homepAdminService.organ_file_delete(popupVO);
		
		return "redirect:/admin/homep/homep_popup_view.do?type=update&popup_no="+popupVO.getPopup_no();
	}

	/**
	 * 홈페이지관리 > 방문통계
	 * @return
	 */
	@RequestMapping(value = "/homep_visit.do")
	public String homep_visit(HttpServletRequest request, Model model) {
		AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");
	

		model.addAttribute("curAdmin", user);
		return "/admin/homep/homep_visit";
		
	}
}