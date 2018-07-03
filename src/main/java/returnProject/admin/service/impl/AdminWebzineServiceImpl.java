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
import returnProject.admin.service.AdminWebzineService;
import returnProject.admin.service.HomepAdminService;
import returnProject.popup.service.PopupVO;

@Service("AdminWebzineService")
public class AdminWebzineServiceImpl extends EgovAbstractServiceImpl implements AdminWebzineService {//implements HomepAdminService {

	@Resource(name="adminWebzineMapper")
	private AdminWebzineMapper adminWebzineMapper;
	
	@Override
	public Map<String, Object> selectWebzineList(BoardVO boardVO) throws Exception {
		List<BoardVO> list = adminWebzineMapper.selectWebzineList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
		result = list;
		
		int cnt = adminWebzineMapper.selectWebzineListCnt(boardVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}
	
	@Override
	public PopupVO selectWebzineView(String popup_no) throws Exception {
		PopupVO popupVO = adminWebzineMapper.selectWebzineView(popup_no);
		return popupVO;
	}
	
	@Override
	public void webzine_insert(PopupVO popupVO) throws Exception  {
		adminWebzineMapper.webzine_insert(popupVO);
	}
	
	@Override
	public void webzine_update(PopupVO popupVO) throws Exception  {
		adminWebzineMapper.webzine_update(popupVO);
	}
	@Override
	public void webzine_delete(PopupVO popupVO) throws Exception  {
		adminWebzineMapper.webzine_delete(popupVO);
	}
	
	@Override
	public void webzine_file_delete(PopupVO popupVO) throws Exception  {
		adminWebzineMapper.webzine_file_delete(popupVO);
	}
	
	
	
	
	
}
