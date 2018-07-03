package returnProject.admin.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cop.bbs.service.BoardVO;
import returnProject.popup.service.PopupVO;

public interface HomepAdminService {

	// 홈페이지 관리 > 관리자 list
    public Map<String, Object> selectAdminList(BoardVO boardVO) throws Exception;
    // 홈페이지 관리 > 관리자 view
	public AdminVO selectAdminMember(String id) throws Exception;
	// 홈페이지 관리 > 관리자 등록
	public void admin_join(AdminVO adminVO) throws Exception;
	// 홈페이지 관리 > 관리자 수정
	public void admin_update(AdminVO adminVO) throws Exception;
	// 홈페이지 관리 > 관리자 삭제
	public void admin_delete(AdminVO adminVO) throws Exception;

    // 홈페이지관리 > 권한관리 메뉴 조회
    public List<AdminRoleVO> getAdminRole(String id) throws Exception;
    // 홈페이지관리 > 권한관리 메뉴 삭제
    public void deleteAdminRole(String id) throws Exception;
    // 홈페이지관리 > 권한관리 메뉴 등록
    public void addAdminRole(AdminRoleVO adminRoleVO) throws Exception;
	
    
    
    
    
    
	// 홈페이지 관리 > 관련기관 수정
	public void organ_update(PopupVO popupVO) throws Exception;
	// 홈페이지 관리 > 관련기관 삭제
	public void organ_delete(PopupVO popupVO) throws Exception;
	// 홈페이지 관리 > 관련기관 첨부파일 삭제
	public void organ_file_delete(PopupVO popupVO) throws Exception;
	
	// 홈페이지 관리 > 인포존 list
    public Map<String, Object> selectInfoList(BoardVO boardVO) throws Exception;
    // 홈페이지 관리 > 관련기관 view
	public PopupVO selectInfoView(String popup_no) throws Exception;
	// 홈페이지 관리 > 인포존 등록
	public void info_join(PopupVO popupVO) throws Exception;
	// 홈페이지 관리 > 인포존 수정
	public void info_update(PopupVO popupVO) throws Exception;
	
	// 홈페이지 관리 > 팝업 list
    public Map<String, Object> selectPopupList(BoardVO boardVO) throws Exception;
    // 홈페이지 관리 > 팝업 view
	public PopupVO selectPopupView(String popup_no) throws Exception;
	// 홈페이지 관리 > 팝업 등록
	public void popup_join(PopupVO popupVO) throws Exception;
	// 홈페이지 관리 > 팝업 수정
	public void popup_update(PopupVO popupVO) throws Exception;
	
}
