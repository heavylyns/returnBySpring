package returnProject.admin.service.impl;

import java.util.List;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.popup.service.PopupVO;

@Mapper("adminWebzineMapper")
public interface AdminWebzineMapper {

	public List<BoardVO> selectWebzineList(BoardVO boardVO) throws Exception;
	public int selectWebzineListCnt(BoardVO boardVO) throws Exception;
	public PopupVO selectWebzineView(String popup_no) throws Exception;
	public void webzine_insert(PopupVO popupVO) throws Exception;
	public void webzine_update(PopupVO popupVO) throws Exception;
	public void webzine_delete(PopupVO popupVO) throws Exception;
	public void webzine_file_delete(PopupVO popupVO) throws Exception;
	
	
}
