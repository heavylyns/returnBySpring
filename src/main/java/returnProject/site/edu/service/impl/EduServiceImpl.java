package returnProject.site.edu.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import returnProject.admin.service.AdminEducationVO;
import returnProject.site.edu.service.EduService;

@Service("eduService")
public class EduServiceImpl implements EduService{

	@Resource(name="eduMapper")
	private EduMapper eduMapper;
	
	@Override
	public List<AdminEducationVO> selectEduList() throws Exception {
		return eduMapper.selectEduList();
	}
	
	@Override
	public List<?> regionalEduDataByDate(HttpServletRequest request)throws Exception{
		AdminEducationVO adminEducationVO = new AdminEducationVO();
		adminEducationVO.setStandard_date(request.getParameter("standard_date"));
		return eduMapper.regionalEduDataByDate(adminEducationVO);
	}
	//regionalEduDataByDateInfo
	@Override
	public List<?> regionalEduDataByDateInfo(HttpServletRequest request)throws Exception{
		AdminEducationVO adminEducationVO = new AdminEducationVO();
		adminEducationVO.setEducation_no(Integer.parseInt(request.getParameter("education_no")));
		return eduMapper.regionalEduDataByDateInfo(adminEducationVO);
	}
}
