package returnProject.site.policy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import returnProject.admin.service.AdminEducationVO;
import returnProject.admin.service.impl.AdminEducationMapper;
import returnProject.site.policy.service.PolicyService;

@Service("policyService")
public class PolicyServiceImpl implements PolicyService{
	
	@Resource(name="policyMapper")
	private PolicyMapper policyMapper;
	
	@Override
	public List<AdminEducationVO> houseDateData(String house_no){
		return policyMapper.houseDateData(house_no);
	}
}
