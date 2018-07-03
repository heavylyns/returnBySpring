package returnProject.site.comunity.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import returnProject.popup.service.PopupVO;
import returnProject.site.comunity.service.ComunityService;

@Service("comunityService")
public class ComunityServiceImpl implements ComunityService{
	
	@Resource(name="comunityMapper")
	private ComunityMapper comunityMapper;
	
	@Override
	public List<PopupVO> webzine() throws Exception {
		return comunityMapper.selectWebzineList();
		
	}
}
