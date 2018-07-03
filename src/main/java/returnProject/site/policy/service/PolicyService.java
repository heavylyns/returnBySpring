package returnProject.site.policy.service;

import java.util.List;

import returnProject.admin.service.AdminEducationVO;

public interface PolicyService {
	public List<AdminEducationVO> houseDateData (String house_no) throws Exception;
}
