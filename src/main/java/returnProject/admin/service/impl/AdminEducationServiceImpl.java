package returnProject.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import returnProject.admin.service.AdminEducationService;
import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service("AdminEducationService")
public class AdminEducationServiceImpl extends EgovAbstractServiceImpl implements AdminEducationService {

	@Resource(name="adminBoardMapper")
	private AdminBoardMapper adminBoardMapper;
	@Resource(name="adminEducationMapper")
	private AdminEducationMapper adminEducationMapper;
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    
	@Override
	public Map<String, Object> selectReturnHouseList(AdminEducationVO adminEducationVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminEducationVO> resultList = adminEducationMapper.selectReturnHouseList(adminEducationVO); 
		int cnt = adminEducationMapper.selectReturnHouseListCnt(adminEducationVO); 
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map; 
	}
	
	@Override
	public int returnHouseInsert(MultipartHttpServletRequest request) throws Exception{
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setHouse_code(request.getParameter("house_code"));
		adminEduVO.setEducation_name(request.getParameter("education_name"));
		adminEduVO.setEducation_start(request.getParameter("education_start"));
		adminEduVO.setEducation_end(request.getParameter("education_end"));
		adminEduVO.setWriter(request.getParameter("writer"));
		return adminEducationMapper.returnHouseInsert(adminEduVO);
	}
	@Override
	public AdminEducationVO selectReturnHouseArticle(MultipartHttpServletRequest request) throws Exception {
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setEducation_no(Integer.parseInt(request.getParameter("education_no")));
		return adminEducationMapper.selectReturnHouseArticle(adminEduVO);
	}
	@Override
	public int returnHouseUpdate(MultipartHttpServletRequest request) throws Exception{
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setEducation_no(Integer.parseInt(request.getParameter("education_no")));
		adminEduVO.setHouse_code(request.getParameter("house_code"));
		adminEduVO.setEducation_name(request.getParameter("education_name"));
		adminEduVO.setEducation_start(request.getParameter("education_start"));
		adminEduVO.setEducation_end(request.getParameter("education_end"));
		adminEduVO.setWriter(request.getParameter("writer"));
		return adminEducationMapper.returnHouseUpdate(adminEduVO);
	}
	@Override
	public int returnHouseDelete(MultipartHttpServletRequest request) throws Exception{
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setEducation_no(Integer.parseInt(request.getParameter("education_no")));
		return adminEducationMapper.returnHouseDelete(adminEduVO);
	}	
	
	
	
	@Override
	public Map<String, Object> selectRegionalEduList(AdminEducationVO adminEducationVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminEducationVO> resultList = adminEducationMapper.selectRegionalEduList(adminEducationVO); 
		int cnt = adminEducationMapper.selectRegionalEduListCnt(adminEducationVO); 
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map; 
	}
	
	@Override
	public int regionalEduInsert(MultipartHttpServletRequest request) throws Exception{
		AdminEducationVO adminEduVO = new AdminEducationVO();
		
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = request.getFileMap();
		result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);		
		
		adminEduVO.setR_edu_title(request.getParameter("r_edu_title"));
		adminEduVO.setDisplay_yn(request.getParameter("display_yn"));
		adminEduVO.setR_edu_start(request.getParameter("r_edu_start"));
		adminEduVO.setR_edu_end(request.getParameter("r_edu_end"));
		adminEduVO.setR_edu_summary(request.getParameter("r_edu_summary"));
		adminEduVO.setR_edu_contents(request.getParameter("r_edu_contents"));
		adminEduVO.setR_edu_place(request.getParameter("r_edu_place"));
		adminEduVO.setR_edu_tel(request.getParameter("r_edu_tel"));
		adminEduVO.setRegion_code(request.getParameter("region_code"));
		adminEduVO.setWriter(request.getParameter("writer"));
		adminEduVO.setAttached_file_id(atchFileId);
		
		return adminEducationMapper.regionalEduInsert(adminEduVO);
	}
	@Override
	public AdminEducationVO selectRegionalEduArticle(HttpServletRequest request) throws Exception {
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		return adminEducationMapper.selectRegionalEduArticle(adminEduVO);
	}
	@Override
	public int regionalEduUpdate(MultipartHttpServletRequest request, AdminEducationVO adminEduVO) throws Exception{
		List<FileVO> result = null;
		String atchFileId = adminEduVO.getAtchFileId();
		
		final Map<String, MultipartFile> files = request.getFileMap();
		if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				//board.setAtchFileId(atchFileId);
				adminEduVO.setAttached_file_id(atchFileId);
    			
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
			    fileMngService.updateFileInfs(_result);
			}	
		}
		
		adminEduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		adminEduVO.setR_edu_title(request.getParameter("r_edu_title"));
		adminEduVO.setDisplay_yn(request.getParameter("display_yn"));
		adminEduVO.setR_edu_start(request.getParameter("r_edu_start"));
		adminEduVO.setR_edu_end(request.getParameter("r_edu_end"));
		adminEduVO.setR_edu_summary(request.getParameter("r_edu_summary"));
		adminEduVO.setR_edu_contents(request.getParameter("r_edu_contents"));
		adminEduVO.setR_edu_place(request.getParameter("r_edu_place"));
		adminEduVO.setR_edu_tel(request.getParameter("r_edu_tel"));
		adminEduVO.setRegion_code(request.getParameter("region_code"));
		adminEduVO.setWriter(request.getParameter("writer"));
		adminEduVO.setAttached_file_id(atchFileId);
		return adminEducationMapper.regionalEduUpdate(adminEduVO);
	}
	@Override
	public int regionalEduDelete(MultipartHttpServletRequest request) throws Exception{
		AdminEducationVO adminEduVO = new AdminEducationVO();
		adminEduVO.setR_edu_no(Integer.parseInt(request.getParameter("r_edu_no")));
		return adminEducationMapper.regionalEduDelete(adminEduVO);
	}	
//	public int boardViewUpdate(BoardVO boardVO) throws Exception{
//		return adminBoardMapper.boardViewUpdate(boardVO);
//	}
//	@Override
//	public int boardInsert (MultipartHttpServletRequest request) throws Exception {
//		AdminBoardVO adminBoardVO = new AdminBoardVO();
//		List<FileVO> result = null;
//		String atchFileId = "";
//		String boardCode = request.getParameter("boardCode");
//		final Map<String, MultipartFile> files = request.getFileMap();
//	    
//		if (!files.isEmpty()) { 
//			if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
//				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
//				atchFileId = fileMngService.insertFileInfs(result);
//			}else{
//				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
//				atchFileId = fileMngService.insertFileInfs(result);
//			}
//		}
//			
//	    
//		
//		adminBoardVO.setBoard_code(request.getParameter("boardCode"));
//		adminBoardVO.setTitle(request.getParameter("title"));
//		adminBoardVO.setWriter(request.getParameter("writer"));
//		adminBoardVO.setContents(request.getParameter("contents"));
//		adminBoardVO.setRegion_code(request.getParameter("regionCode"));
//		adminBoardVO.setAttached_file_id(atchFileId);
//		
//		return adminBoardMapper.boardInsert(adminBoardVO);
//	}
//	
//	@Override
//	public int boardUpdate (MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
//		AdminBoardVO adminBoardVO = new AdminBoardVO();
//		
//		List<FileVO> result = null;
//		String atchFileId = boardVO.getAtchFileId();
//		final Map<String, MultipartFile> files = request.getFileMap();
//		String boardCode = request.getParameter("boardCode");
//	    if (!files.isEmpty()) {
//	    	if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
//	    		if("".equals(atchFileId)){
//    				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
//    				atchFileId = fileMngService.insertFileInfs(result);
//	    		}else{
//		    		FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(atchFileId);
//				    int cnt = fileMngService.getMaxFileSN(fvo);
//				    List<FileVO> _result = fileUtil.parseImgFileInf(files, "BBS_", 0, atchFileId, request.getServletContext().getRealPath("/"));
//				    fileMngService.updateFileDetail(_result);
//			    	//updateFileDetail
//	    		}
//	    	}else{
//	    		if ("".equals(atchFileId)) {
//	    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
//					atchFileId = fileMngService.insertFileInfs(result);
//					//board.setAtchFileId(atchFileId);
//					adminBoardVO.setAttached_file_id(atchFileId);
//	    			
//				} else {
//				    FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(atchFileId);
//				    int cnt = fileMngService.getMaxFileSN(fvo);
//				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
//				    fileMngService.updateFileInfs(_result);
//				}
//	    	}
//	    }
//		adminBoardVO.setBoard_code(request.getParameter("boardCode"));
//		adminBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
//		adminBoardVO.setTitle(request.getParameter("title"));
//		adminBoardVO.setRegion_code(request.getParameter("regionCode"));
//		adminBoardVO.setWriter(request.getParameter("writer"));
//		adminBoardVO.setContents(request.getParameter("contents"));
//		
//		return adminBoardMapper.boardUpdate(adminBoardVO);
//	}
//	@Override
//	public int boardDelete (AdminBoardVO adminBoardVO) throws Exception {
//		int result = adminBoardMapper.boardDelete(adminBoardVO);
//		if("02".equals(adminBoardVO.getBoard_code()) || "05".equals(adminBoardVO.getBoard_code())){
//			int replyresult = adminBoardMapper.replyDelete(adminBoardVO);
//		}
//		
//		return result;
//	}
//	@Override
//	public List<AdminBoardVO> regionCombo(BoardVO boardVO) throws Exception{
//		List<AdminBoardVO> resultList = adminBoardMapper.regionCombo(boardVO);
//		return resultList;
//	}
//	
//	@Override
//	public int replyInsert (MultipartHttpServletRequest request) throws Exception {
//		AdminBoardVO adminBoardVO = new AdminBoardVO();
//		List<FileVO> result = null;
//		String atchFileId = "";
//		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
//		final Map<String, MultipartFile> files = request.getFileMap();
//	    
//		if (!files.isEmpty()) {
//			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
//			atchFileId = fileMngService.insertFileInfs(result);
//		}
//			
//	    
//		
//		adminBoardVO.setBoard_no(boardNo);
//		adminBoardVO.setTitle(request.getParameter("title"));
//		adminBoardVO.setWriter(request.getParameter("writer"));
//		adminBoardVO.setContents(request.getParameter("contents"));
//		adminBoardVO.setAttached_file_id(atchFileId);
//		
//		return adminBoardMapper.replyInsert(adminBoardVO);
//	}
//	public List<AdminBoardVO> selectReplyArticle(BoardVO boardVO) throws Exception{
//		List<AdminBoardVO> resultList = adminBoardMapper.selectReplyArticle(boardVO);
//		return resultList;
//	}
//	
//	@Override
//	public int replyUpdate (MultipartHttpServletRequest request, BoardVO boardVO) throws Exception {
//		AdminBoardVO adminBoardVO = new AdminBoardVO();
//		
//		List<FileVO> result = null;
//		String atchFileId = boardVO.getAtchFileId();
//		final Map<String, MultipartFile> files = request.getFileMap();
//		String boardCode = request.getParameter("boardCode");
//	    if (!files.isEmpty()) {
//	    	if("03".equals(boardCode) || "04".equals(boardCode) || "06".equals(boardCode) || "07".equals(boardCode)){
//	    		if("".equals(atchFileId)){
//    				result = fileUtil.parseImgFileInf(files, "BBS_", 0, "", request.getServletContext().getRealPath("/"));
//    				atchFileId = fileMngService.insertFileInfs(result);
//	    		}else{
//		    		FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(atchFileId);
//				    int cnt = fileMngService.getMaxFileSN(fvo);
//				    List<FileVO> _result = fileUtil.parseImgFileInf(files, "BBS_", 0, atchFileId, request.getServletContext().getRealPath("/"));
//				    fileMngService.updateFileDetail(_result);
//			    	//updateFileDetail
//	    		}
//	    	}else{
//	    		if ("".equals(atchFileId)) {
//	    			result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
//					atchFileId = fileMngService.insertFileInfs(result);
//					//board.setAtchFileId(atchFileId);
//					adminBoardVO.setAttached_file_id(atchFileId);
//	    			
//				} else {
//				    FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(atchFileId);
//				    int cnt = fileMngService.getMaxFileSN(fvo);
//				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
//				    fileMngService.updateFileInfs(_result);
//				}
//	    	}
//	    }
//		adminBoardVO.setReply_no(Integer.parseInt(request.getParameter("replyNo")));
//		adminBoardVO.setBoard_no(Integer.parseInt(request.getParameter("boardNo")));
//		
//		adminBoardVO.setWriter(request.getParameter("writer"));
//		adminBoardVO.setContents(request.getParameter("contents"));
//		
//		return adminBoardMapper.replyUpdate(adminBoardVO);
//	}
//	@Override
//	public int replyDelete (AdminBoardVO adminBoardVO) throws Exception {
//		return adminBoardMapper.replyDelete(adminBoardVO);
//	}
//	

}
