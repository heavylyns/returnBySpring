package returnProject.site.edu.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import returnProject.admin.service.AdminEducationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("eduMapper")
public interface EduMapper {

	public List<AdminEducationVO> selectEduList() throws Exception;
	public List<?> regionalEduDataByDate(AdminEducationVO adminEducationVO)throws Exception;
	public List<?> regionalEduDataByDateInfo(AdminEducationVO adminEducationVO)throws Exception;
	//regionalEduDataByDateInfo
	
}
