package returnProject.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import returnProject.admin.service.AdminBoardService;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service("AdminBoardService")
public class AdminBoardServiceImpl extends EgovAbstractServiceImpl implements AdminBoardService {

	@Resource(name="adminBoardMapper")
	private AdminBoardMapper adminBoardMapper;
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    
	@Override
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminBoardVO> resultList = adminBoardMapper.selectBoardList(boardVO); 
		int cnt = adminBoardMapper.selectBoardListCnt(boardVO); 
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map; 
	}
	
	@Override
	public AdminBoardVO selectBoardArticle(BoardVO boardVO) throws Exception{
		
		return adminBoardMapper.selectBoardArticle(boardVO);
	}
	public int boardViewUpdate(BoardVO boardVO) throws Exception{
		return adminBoardMapper.boardViewUpdate(boardVO);
	}
	@Override
	public int boardInsert (MultipartHttpServletRequest request) throws Exception {
		AdminBoardVO adminBoardVO = new AdminBoardVO();
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
			
	    
		
		adminBoardVO.setBoard_code(request.getParameter("boardCode"));
		adminBoardVO.setTitle(request.getParameter("title"));
		adminBoardVO.setWriter(request.getParameter("writer"));
		adminBoardVO.setContents(request.getParameter("contents"));
		adminBoardVO.setRegion_code(request.getParameter("regionCode"));
		adminBoardVO.setAttached_file_id(atchFileId);
		
		return adminBoardMapper.boardInsert(adminBoardVO);
	}
	
	@Override
	public int boardUpdate (MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
		AdminBoardVO adminBoardVO = new AdminBoardVO();
		
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
					adminBoardVO.setAttached_file_id(atchFileId);
	    			
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				    fileMngService.updateFileInfs(_result);
				}
	    	}
	    }
		adminBoardVO.setBoard_code(request.getParameter("boardCode"));
		adminBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
		adminBoardVO.setTitle(request.getParameter("title"));
		adminBoardVO.setRegion_code(request.getParameter("regionCode"));
		adminBoardVO.setWriter(request.getParameter("writer"));
		adminBoardVO.setContents(request.getParameter("contents"));
		
		return adminBoardMapper.boardUpdate(adminBoardVO);
	}
	@Override
	public int boardDelete (AdminBoardVO adminBoardVO) throws Exception {
		int result = adminBoardMapper.boardDelete(adminBoardVO);
		if("02".equals(adminBoardVO.getBoard_code()) || "05".equals(adminBoardVO.getBoard_code())){
			int replyresult = adminBoardMapper.replyDelete(adminBoardVO);
		}
		
		return result;
	}
	@Override
	public List<AdminBoardVO> regionCombo(BoardVO boardVO) throws Exception{
		List<AdminBoardVO> resultList = adminBoardMapper.regionCombo(boardVO);
		return resultList;
	}
	
	@Override
	public int replyInsert (MultipartHttpServletRequest request) throws Exception {
		AdminBoardVO adminBoardVO = new AdminBoardVO();
		List<FileVO> result = null;
		String atchFileId = "";
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		final Map<String, MultipartFile> files = request.getFileMap();
	    
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
			
	    
		
		adminBoardVO.setBoard_no(boardNo);
		adminBoardVO.setTitle(request.getParameter("title"));
		adminBoardVO.setWriter(request.getParameter("writer"));
		adminBoardVO.setContents(request.getParameter("contents"));
		adminBoardVO.setAttached_file_id(atchFileId);
		
		return adminBoardMapper.replyInsert(adminBoardVO);
	}
	public List<AdminBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception{
		List<AdminBoardVO> resultList = adminBoardMapper.selectReplyArticle(boardVO);
		return resultList;
	}
	
	@Override
	public int replyUpdate (MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
		AdminBoardVO adminBoardVO = new AdminBoardVO();
		
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
					adminBoardVO.setAttached_file_id(atchFileId);
	    			
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				    fileMngService.updateFileInfs(_result);
				}
	    	}
	    }
		adminBoardVO.setReply_no(Integer.parseInt(request.getParameter("replyNo")));
		adminBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
		
		adminBoardVO.setWriter(request.getParameter("writer"));
		adminBoardVO.setContents(request.getParameter("contents"));
		
		return adminBoardMapper.replyUpdate(adminBoardVO);
	}
	@Override
	public int replyDelete (AdminBoardVO adminBoardVO) throws Exception {
		return adminBoardMapper.replyDelete(adminBoardVO);
	}
	

}
