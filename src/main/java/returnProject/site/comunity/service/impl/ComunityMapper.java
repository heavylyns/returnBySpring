package returnProject.site.comunity.service.impl;

import java.util.List;

import returnProject.popup.service.PopupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("comunityMapper")
public interface ComunityMapper {

	List<PopupVO> selectWebzineList() throws Exception;
}
