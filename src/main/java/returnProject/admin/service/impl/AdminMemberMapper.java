package returnProject.admin.service.impl;

import java.util.List;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import returnProject.admin.service.AdminMemberVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.popup.service.PopupVO;

@Mapper("adminMemberMapper")
public interface AdminMemberMapper {

	public List<AdminMemberVO> selectAdminMemberList(AdminMemberVO adminMemberVO) throws Exception;
	public List<AdminMemberVO> selectRegionStatistics(AdminMemberVO adminMemberVO) throws Exception;
	public int selectAdminMemberListCnt(AdminMemberVO adminMemberVO) throws Exception;
	public int selectAdminMemberListCntByMemberType(String member_type) throws Exception;
	public AdminMemberVO selectAdminMember(String id) throws Exception;
	public int memberInsert(AdminMemberVO adminMemberVO)throws Exception;
	public int idCheck(String id)throws Exception;
	public int memberUpdate(AdminMemberVO adminMemberVO) throws Exception;
	public int memberDelete(String id) throws Exception; 
	
}
