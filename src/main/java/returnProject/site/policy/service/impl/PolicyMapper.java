package returnProject.site.policy.service.impl;

import java.util.List;

import returnProject.admin.service.AdminEducationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("policyMapper")
public interface PolicyMapper {

	List<AdminEducationVO> houseDateData(String house_no);
	
}
