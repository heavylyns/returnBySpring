package returnProject.site.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import returnProject.admin.service.AdminEducationVO;
import returnProject.site.board.service.BoardService;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.edu.service.EducationVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    //리스트 조회
	@Override
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<SiteBoardVO> resultList = boardMapper.selectBoardList(boardVO);
		int cnt = boardMapper.selectBoardListCnt(boardVO); 
		
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map; 
	}
	//뷰 조회
	@Override
	public SiteBoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		return boardMapper.selectBoardArticle(boardVO);
	}
	//리플 조회
	@Override
	public List<SiteBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception {
		return boardMapper.selectReplyArticle(boardVO);
	}
	@Override
	public void boardViewUpdate(BoardVO boardVO) throws Exception {
		boardMapper.boardViewUpdate(boardVO);		
	}
	//등록
	@Override
	public int boardInsert (MultipartHttpServletRequest request) throws Exception {
		SiteBoardVO siteBoardVO = new SiteBoardVO();
		List<FileVO> result = null;
		String atchFileId = "";
		String boardCode = request.getParameter("boardCode");
		final Map<String, MultipartFile> files = request.getFileMap();
	    
		if (!files.isEmpty()) {
			if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
				atchFileId = fileMngService.insertFileInfs(result);
			}else{
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
		}
			
	    
		
		siteBoardVO.setBoard_code(request.getParameter("boardCode"));
		siteBoardVO.setTitle(request.getParameter("title"));
		siteBoardVO.setWriter(request.getParameter("writer"));
		siteBoardVO.setContents(request.getParameter("contents"));
		siteBoardVO.setRegion_code(request.getParameter("region_code"));
		siteBoardVO.setAttached_file_id(atchFileId);
		siteBoardVO.setLock_yn(request.getParameter("lock_yn"));
		
		return boardMapper.boardInsert(siteBoardVO);
	}
	//업데이트
	@Override
	public int boardUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
		SiteBoardVO siteBoardVO = new SiteBoardVO();
		
		List<FileVO> result = null;
		String atchFileId = boardVO.getAtchFileId();
		final Map<String, MultipartFile> files = request.getFileMap();
		String boardCode = request.getParameter("boardCode");
	    if (!files.isEmpty()) {
	    	if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
	    		if("".equals(atchFileId)){
    				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
    				atchFileId = fileMngService.insertFileInfs(result);
	    		}else{
		    		FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseImgFileInf(files, "BBS_", 0, atchFileId, request.getServletContext().getRealPath("/"));
				    fileMngService.updateFileDetail(_result);
			    	//updateFileDetail
	    		}
	    	}else{
	    		if ("".equals(atchFileId)) {
	    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					//board.setAtchFileId(atchFileId);
					siteBoardVO.setAttached_file_id(atchFileId);
	    			
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				    fileMngService.updateFileInfs(_result);
				}
	    	}
	    }
	    siteBoardVO.setBoard_code(request.getParameter("boardCode"));
	    siteBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
	    siteBoardVO.setTitle(request.getParameter("title"));
	    siteBoardVO.setRegion_code(request.getParameter("region_code"));
	    siteBoardVO.setWriter(request.getParameter("writer"));
	    siteBoardVO.setContents(request.getParameter("contents"));
	    siteBoardVO.setLock_yn(request.getParameter("lock_yn"));
	    
		return boardMapper.boardUpdate(siteBoardVO);
	}
	//삭제
	@Override
	public int boardDelete(SiteBoardVO siteBoardVO) throws Exception {
		int result = boardMapper.boardDelete(siteBoardVO);
		if("02".equals(siteBoardVO.getBoard_code()) || "05".equals(siteBoardVO.getBoard_code())){
			int replyresult = boardMapper.replyDelete(siteBoardVO);
		}
		
		return result;
	}
	//지역코드조회
	@Override
	public List<SiteBoardVO> regionCombo(BoardVO boardVO) throws Exception {
		List<SiteBoardVO> resultList = boardMapper.regionCombo(boardVO);
		return resultList;
	}
	
	//답변 액션 시작
	@Override
	public int replyInsert(MultipartHttpServletRequest request) throws Exception {
		SiteBoardVO siteBoardVO = new SiteBoardVO();
		List<FileVO> result = null;
		String atchFileId = "";
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		final Map<String, MultipartFile> files = request.getFileMap();
	    
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
			
	    
		
		siteBoardVO.setBoard_no(boardNo);
		siteBoardVO.setTitle(request.getParameter("title"));
		siteBoardVO.setWriter(request.getParameter("writer"));
		siteBoardVO.setContents(request.getParameter("contents"));
		siteBoardVO.setAttached_file_id(atchFileId);
		
		return boardMapper.replyInsert(siteBoardVO);
	}
	
	@Override
	public int replyUpdate(MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
		SiteBoardVO siteBoardVO = new SiteBoardVO();
		
		List<FileVO> result = null;
		String atchFileId = boardVO.getAtchFileId();
		final Map<String, MultipartFile> files = request.getFileMap();
		String boardCode = request.getParameter("boardCode");
	    if (!files.isEmpty()) {
	    	if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
	    		if("".equals(atchFileId)){
    				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
    				atchFileId = fileMngService.insertFileInfs(result);
	    		}else{
		    		FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseImgFileInf(files, "BBS_", 0, atchFileId, request.getServletContext().getRealPath("/"));
				    fileMngService.updateFileDetail(_result);
			    	//updateFileDetail
	    		}
	    	}else{
	    		if ("".equals(atchFileId)) {
	    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					//board.setAtchFileId(atchFileId);
					siteBoardVO.setAttached_file_id(atchFileId);
	    			
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				    fileMngService.updateFileInfs(_result);
				}
	    	}
	    }
		siteBoardVO.setReply_no(Integer.parseInt(request.getParameter("replyNo")));
		siteBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
		
		siteBoardVO.setWriter(request.getParameter("writer"));
		siteBoardVO.setContents(request.getParameter("contents"));
		
		return boardMapper.replyUpdate(siteBoardVO);
	}

	@Override
	public int replyDelete(SiteBoardVO siteBoardVO) throws Exception {
		return boardMapper.replyDelete(siteBoardVO);
	}
	//답변 액션 종료
	
	//시군별 교육 리스트 조회
	@Override
	public Map<String, Object> selectRegionalEduList(EducationVO eduVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		List<EducationVO> resultList = boardMapper.selectRegionalEduList(eduVO); 
		int cnt = boardMapper.selectRegionalEduListCnt(eduVO); 
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map; 
	}
	//시군별 교육 view
	@Override
	public EducationVO selectRegionalEduArticle(HttpServletRequest request) throws Exception {
		EducationVO eduVO = new EducationVO();
		eduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		return boardMapper.selectRegionalEduArticle(eduVO);
	}
	//시군별 교육 insert
	@Override
	public int regionalEduInsert(MultipartHttpServletRequest request) throws Exception {
		EducationVO eduVO = new EducationVO();
		
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = request.getFileMap();
		result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);		
		
		eduVO.setR_edu_title(request.getParameter("r_edu_title"));
		eduVO.setDisplay_yn(request.getParameter("display_yn"));
		eduVO.setR_edu_start(request.getParameter("r_edu_start"));
		eduVO.setR_edu_end(request.getParameter("r_edu_end"));
		eduVO.setR_edu_summary(request.getParameter("r_edu_summary"));
		eduVO.setR_edu_contents(request.getParameter("r_edu_contents"));
		eduVO.setR_edu_place(request.getParameter("r_edu_place"));
		eduVO.setR_edu_tel(request.getParameter("r_edu_tel"));
		eduVO.setRegion_code(request.getParameter("region_code"));
		eduVO.setWriter(request.getParameter("writer"));
		eduVO.setAttached_file_id(atchFileId);
		
		return boardMapper.regionalEduInsert(eduVO);
	}
	//시군별 교육 수정
	@Override
	public int regionalEduUpdate(MultipartHttpServletRequest request, EducationVO eduVO) throws Exception {
		List<FileVO> result = null;
		String atchFileId = eduVO.getAtchFileId();
		
		final Map<String, MultipartFile> files = request.getFileMap();
		if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				//board.setAtchFileId(atchFileId);
				eduVO.setAttached_file_id(atchFileId);
    			
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
			    fileMngService.updateFileInfs(_result);
			}	
		}
		
		eduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		eduVO.setR_edu_title(request.getParameter("r_edu_title"));
		eduVO.setDisplay_yn(request.getParameter("display_yn"));
		eduVO.setR_edu_start(request.getParameter("r_edu_start"));
		eduVO.setR_edu_end(request.getParameter("r_edu_end"));
		eduVO.setR_edu_summary(request.getParameter("r_edu_summary"));
		eduVO.setR_edu_contents(request.getParameter("r_edu_contents"));
		eduVO.setR_edu_place(request.getParameter("r_edu_place"));
		eduVO.setR_edu_tel(request.getParameter("r_edu_tel"));
		eduVO.setRegion_code(request.getParameter("region_code"));
		eduVO.setWriter(request.getParameter("writer"));
		eduVO.setAttached_file_id(atchFileId);
		return boardMapper.regionalEduUpdate(eduVO);
	}
	//시군별 교육 삭제
	@Override
	public int regionalEduDelete(MultipartHttpServletRequest request) throws Exception {
		EducationVO eduVO = new EducationVO();
		eduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		return boardMapper.regionalEduDelete(eduVO);
	}
	
	
}
