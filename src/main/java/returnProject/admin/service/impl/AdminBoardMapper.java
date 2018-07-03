package returnProject.admin.service.impl;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;

import java.util.List;

@Mapper("adminBoardMapper")
public interface AdminBoardMapper {


	public List<AdminBoardVO> selectBoardList(BoardVO boardVO) throws Exception;
	public int selectBoardListCnt(BoardVO boardVO) throws Exception;
	public AdminBoardVO selectBoardArticle (BoardVO boardVO) throws Exception;
	public int boardViewUpdate(BoardVO boardVO) throws Exception;
	public int boardInsert (AdminBoardVO adminBoardVO) throws Exception;
	public int boardUpdate(AdminBoardVO adminBoardVO) throws Exception;
	public int boardDelete(AdminBoardVO adminBoardVO) throws Exception;
	public List<AdminBoardVO> regionCombo(BoardVO boardVO) throws Exception;
	public int replyInsert (AdminBoardVO adminBoardVO) throws Exception;
	public List<AdminBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception;
	public int replyUpdate(AdminBoardVO adminBoardVO) throws Exception;
	public int replyDelete(AdminBoardVO adminBoardVO) throws Exception;
	

}
