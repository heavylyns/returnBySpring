package returnProject.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.HomepAdminService;
import returnProject.popup.service.PopupVO;

@Service("HomepAdminService")
public class HomepAdminServiceImpl extends EgovAbstractServiceImpl implements HomepAdminService {//implements HomepAdminService {

	@Resource(name="homepAdminMapper")
	private HomepAdminMapper homepAdminMapper;

	// 홈페이지 관리 > 관리자 list
	@Override
	public Map<String, Object> selectAdminList(BoardVO boardVO) throws Exception {
		List<BoardVO> list = homepAdminMapper.selectAdminList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
		result = list;
		
		int cnt = homepAdminMapper.selectAdminListCnt(boardVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}
//	 홈페이지 관리 > 관리자 view
	@Override
	public AdminVO selectAdminMember(String id) throws Exception {
		AdminVO adminVO = homepAdminMapper.selectAdminMember(id);
		return adminVO;
	}
	// 홈페이지 관리 > 관리자 등록
	@Override
	public void admin_join(AdminVO adminVO) throws Exception  {
		homepAdminMapper.admin_join(adminVO);
	}
	// 홈페이지 관리 > 관리자 수정
	@Override
	public void admin_update(AdminVO adminVO) throws Exception  {
		homepAdminMapper.admin_update(adminVO);
	}
	// 홈페이지 관리 > 관리자 삭제
	@Override
	public void admin_delete(AdminVO adminVO) throws Exception  {
		homepAdminMapper.admin_delete(adminVO);
	}
	
    // 홈페이지관리 > 권한관리 메뉴 조회
	@Override
	public List<AdminRoleVO> getAdminRole(String id) throws Exception {
		return homepAdminMapper.getAdminRole(id);
	}

	// 홈페이지관리 > 권한관리 메뉴 삭제
	@Override
	public void deleteAdminRole(String id) throws Exception {
		homepAdminMapper.deleteAdminRole(id);
	}

	// 홈페이지관리 > 권한관리 메뉴 등록
	@Override
	public void addAdminRole(AdminRoleVO adminRoleVO) throws Exception {
		homepAdminMapper.addAdminRole(adminRoleVO);
	}



	// 홈페이지 관리 > 관련기관 수정
	@Override
	public void organ_update(PopupVO popupVO) throws Exception  {
		homepAdminMapper.organ_update(popupVO);
	}
	// 홈페이지 관리 > 관련기관 삭제
	@Override
	public void organ_delete(PopupVO popupVO) throws Exception  {
		homepAdminMapper.organ_delete(popupVO);
	}
	// 홈페이지 관리 > 관련기관 첨부파일 삭제
	@Override
	public void organ_file_delete(PopupVO popupVO) throws Exception  {
		homepAdminMapper.organ_file_delete(popupVO);
	}

	// 홈페이지 관리 > 인포존 list
	@Override
	public Map<String, Object> selectInfoList(BoardVO boardVO) throws Exception {
		List<BoardVO> list = homepAdminMapper.selectInfoList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
		result = list;
		
		int cnt = homepAdminMapper.selectInfoListCnt(boardVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}
	// 홈페이지 관리 > 인포존 view
	@Override
	public PopupVO selectInfoView(String popup_no) throws Exception {
		PopupVO popupVO = homepAdminMapper.selectInfoView(popup_no);
		return popupVO;
	}
	// 홈페이지 관리 > 인포존 등록
	@Override
	public void info_join(PopupVO popupVO) throws Exception  {
		homepAdminMapper.info_join(popupVO);
	}
	// 홈페이지 관리 > 인포존 수정
	@Override
	public void info_update(PopupVO popupVO) throws Exception  {
		homepAdminMapper.info_update(popupVO);
	}

	// 홈페이지 관리 > 팝업 list
	@Override
	public Map<String, Object> selectPopupList(BoardVO boardVO) throws Exception {
		List<BoardVO> list = homepAdminMapper.selectPopupList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
		result = list;
		
		int cnt = homepAdminMapper.selectPopupListCnt(boardVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}
	// 홈페이지 관리 > 팝업 view
	@Override
	public PopupVO selectPopupView(String popup_no) throws Exception {
		PopupVO popupVO = homepAdminMapper.selectPopupView(popup_no);
		return popupVO;
	}
	// 홈페이지 관리 > 팝업 등록
	@Override
	public void popup_join(PopupVO popupVO) throws Exception  {
		homepAdminMapper.popup_join(popupVO);
	}
	// 홈페이지 관리 > 팝업 수정
	@Override
	public void popup_update(PopupVO popupVO) throws Exception  {
		homepAdminMapper.popup_update(popupVO);
	}
}
