package returnProject.admin.service;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;








import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface AdminEducationService {
	
	public Map<String, Object> selectReturnHouseList(AdminEducationVO adminEducationVO) throws Exception;
	
	public int returnHouseInsert(MultipartHttpServletRequest request) throws Exception;
	
	public AdminEducationVO selectReturnHouseArticle(MultipartHttpServletRequest request) throws Exception;
	
	public int returnHouseUpdate(MultipartHttpServletRequest request) throws Exception;
	
	public int returnHouseDelete(MultipartHttpServletRequest request) throws Exception;
	
	
	public Map<String, Object> selectRegionalEduList(AdminEducationVO adminEducationVO) throws Exception;
	
	public int regionalEduInsert(MultipartHttpServletRequest request) throws Exception;
	
	public AdminEducationVO selectRegionalEduArticle(HttpServletRequest request) throws Exception;
	
	public int regionalEduUpdate(MultipartHttpServletRequest request, AdminEducationVO adminEduVO) throws Exception;
	
	public int regionalEduDelete(MultipartHttpServletRequest request) throws Exception;

}
