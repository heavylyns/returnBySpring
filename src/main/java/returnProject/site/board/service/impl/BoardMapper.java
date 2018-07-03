package returnProject.site.board.service.impl;

import java.util.List;

import returnProject.admin.service.AdminEducationVO;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.edu.service.EducationVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	//리스트 조회
	List<SiteBoardVO> selectBoardList(BoardVO boardVO) throws Exception;
	int selectBoardListCnt(BoardVO boardVO) throws Exception;
	//뷰
	SiteBoardVO selectBoardArticle(BoardVO boardVO) throws Exception;
	void boardViewUpdate(BoardVO boardVO) throws Exception;
	//등록
	int boardInsert(SiteBoardVO siteBoardVO) throws Exception;
	//수정
	int boardUpdate(SiteBoardVO siteBoardVO) throws Exception;
	//삭제
	int boardDelete(SiteBoardVO adminBoardVO) throws Exception;
	int replyDelete(SiteBoardVO adminBoardVO) throws Exception;
	//지역 코드, 지역명 조회
	List<SiteBoardVO> regionCombo(BoardVO boardVO) throws Exception;
	//답변 조회
	List<SiteBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception;
	
	int replyInsert(SiteBoardVO siteBoardVO) throws Exception;
	int replyUpdate(SiteBoardVO siteBoardVO) throws Exception;
	
	//시군별 교육 조회
	List<EducationVO> selectRegionalEduList(EducationVO eduVO) throws Exception;
	int selectRegionalEduListCnt(AdminEducationVO adminEduVO) throws Exception;
	//시군별 교육 view
	EducationVO selectRegionalEduArticle(EducationVO eduVO) throws Exception;
	//시군별 교육 등록
	int regionalEduInsert(EducationVO eduVO) throws Exception;
	//시군별 교육 삭제
	int regionalEduDelete(EducationVO eduVO) throws Exception;
	//시군별 교육 수정
	int regionalEduUpdate(EducationVO eduVO) throws Exception;
	
}
