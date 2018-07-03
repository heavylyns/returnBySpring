package returnProject.admin.service;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;





import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface AdminBoardService {
	/**
	 *  게시판관리 > 자료실 리스트
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception;
	
	public AdminBoardVO selectBoardArticle(BoardVO boardVO) throws Exception;
	
	public int boardViewUpdate(BoardVO boardVO) throws Exception;
	
	public int boardInsert(MultipartHttpServletRequest request) throws Exception;
	
	public int boardUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception;
	
	public int boardDelete(AdminBoardVO adminBoardVO) throws Exception;
	
	public List<AdminBoardVO> regionCombo(BoardVO boardVO) throws Exception;
	
	public int replyInsert(MultipartHttpServletRequest request) throws Exception;
	
	public List<AdminBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception;
	
	public int replyUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception;
	
	public int replyDelete(AdminBoardVO adminBoardVO) throws Exception;

}
