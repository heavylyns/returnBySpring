package returnProject.admin.service.impl;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

@Mapper("adminEducationMapper")
public interface AdminEducationMapper {


	public List<AdminEducationVO> selectReturnHouseList(AdminEducationVO educationVO) throws Exception;
	public int selectReturnHouseListCnt(AdminEducationVO educationVO) throws Exception;
	public int returnHouseInsert(AdminEducationVO educationVO) throws Exception;
	public AdminEducationVO selectReturnHouseArticle(AdminEducationVO educationVO) throws Exception;
	public int returnHouseUpdate(AdminEducationVO educationVO) throws Exception;
	public int returnHouseDelete(AdminEducationVO educationVO) throws Exception;

	public List<AdminEducationVO> selectRegionalEduList(AdminEducationVO educationVO) throws Exception;
	public int selectRegionalEduListCnt(AdminEducationVO educationVO) throws Exception;
	public int regionalEduInsert(AdminEducationVO educationVO) throws Exception;
	public AdminEducationVO selectRegionalEduArticle(AdminEducationVO educationVO) throws Exception;
	public int regionalEduUpdate(AdminEducationVO educationVO) throws Exception;
	public int regionalEduDelete(AdminEducationVO educationVO) throws Exception;
}
