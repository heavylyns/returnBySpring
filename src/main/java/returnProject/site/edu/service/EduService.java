package returnProject.site.edu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import returnProject.admin.service.AdminEducationVO;

public interface EduService {

	public List<AdminEducationVO> selectEduList() throws Exception;
	public List<?> regionalEduDataByDate(HttpServletRequest request)throws Exception;
	public List<?> regionalEduDataByDateInfo(HttpServletRequest request)throws Exception;
	//regionalEduDataByDateInfo
}
