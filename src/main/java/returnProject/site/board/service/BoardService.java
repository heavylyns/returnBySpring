package returnProject.site.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import returnProject.admin.service.AdminEducationVO;
import returnProject.site.edu.service.EducationVO;
import egovframework.com.cop.bbs.service.BoardVO;

public interface BoardService {
	//리스트 조회
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception;
	//뷰 조회
	public SiteBoardVO selectBoardArticle(BoardVO boardVO) throws Exception;
	public List<SiteBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception;
	public void boardViewUpdate(BoardVO boardVO) throws Exception;
	//등록
	public int boardInsert(MultipartHttpServletRequest request) throws Exception;
	//업데이트
	public int boardUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception;
	//삭제
	public int boardDelete(SiteBoardVO adminBoardVO) throws Exception;
	//지역 코드 이름 조회
	public List<SiteBoardVO> regionCombo(BoardVO boardVO) throws Exception;
	
	//둗고 답하는 게시판 - 답변처리
	public int replyInsert(MultipartHttpServletRequest request) throws Exception;
	public int replyUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception;
	public int replyDelete(SiteBoardVO siteBoardVO) throws Exception;
	
	//시군별 교육
	public Map<String, Object> selectRegionalEduList(EducationVO eduVO) throws Exception;
	public EducationVO selectRegionalEduArticle(HttpServletRequest request) throws Exception;
	public int regionalEduInsert(MultipartHttpServletRequest request) throws Exception;
	public int regionalEduUpdate(MultipartHttpServletRequest request, EducationVO eduVO) throws Exception;
	public int regionalEduDelete(MultipartHttpServletRequest request) throws Exception;
	
}
