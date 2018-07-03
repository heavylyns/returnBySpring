package returnProject.admin.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cop.bbs.service.BoardVO;
import returnProject.popup.service.PopupVO;

public interface AdminWebzineService {

	public Map<String, Object> selectWebzineList(BoardVO boardVO) throws Exception;
	
	public PopupVO selectWebzineView(String popup_no) throws Exception;
	
	public void webzine_insert(PopupVO popupVO) throws Exception;
	
	public void webzine_update(PopupVO popupVO) throws Exception;
	
	public void webzine_delete(PopupVO popupVO) throws Exception;
	
	public void webzine_file_delete(PopupVO popupVO) throws Exception;
	
	
	
	
}
