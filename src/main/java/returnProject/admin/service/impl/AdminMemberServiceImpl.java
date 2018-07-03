package returnProject.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import returnProject.admin.service.AdminMemberService;
import returnProject.admin.service.AdminMemberVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;
import returnProject.admin.service.AdminWebzineService;
import returnProject.admin.service.HomepAdminService;
import returnProject.popup.service.PopupVO;

@Service("AdminMemberService")
public class AdminMemberServiceImpl extends EgovAbstractServiceImpl implements AdminMemberService {//implements HomepAdminService {

	@Resource(name="adminMemberMapper")
	private AdminMemberMapper adminMemberMapper;
	
	@Override
	public Map<String, Object> selectAdminMemberList(AdminMemberVO adminMemberVO) throws Exception {
		List<AdminMemberVO> list = adminMemberMapper.selectAdminMemberList(adminMemberVO);
		List<AdminMemberVO> result = new ArrayList<AdminMemberVO>();
		result = list;
		
		
		int cnt = adminMemberMapper.selectAdminMemberListCnt(adminMemberVO);
		int preReturnCnt = adminMemberMapper.selectAdminMemberListCntByMemberType("01");
		int returnedCnt = adminMemberMapper.selectAdminMemberListCntByMemberType("02");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		map.put("returnedCnt", Integer.toString(returnedCnt));
		map.put("preReturnCnt", Integer.toString(preReturnCnt));
		
		return map;
	}
	@Override
	public List<AdminMemberVO> selectRegionStatistics(AdminMemberVO adminMemberVO) throws Exception {
		List<AdminMemberVO> list = adminMemberMapper.selectRegionStatistics(adminMemberVO);
		return list;
	}
	@Override
	public AdminMemberVO selectAdminMember(String id) throws Exception {
		AdminMemberVO adminMemberVO= adminMemberMapper.selectAdminMember(id);
		return adminMemberVO;
	}
	
	@Override
	public int memberInsert(MultipartHttpServletRequest request) throws Exception{
		AdminMemberVO adminMemberVO = new AdminMemberVO();
		adminMemberVO.setId(request.getParameter("id"));
		adminMemberVO.setName(request.getParameter("name"));
		adminMemberVO.setRegion_code(request.getParameter("regionCode"));
		adminMemberVO.setMember_type(request.getParameter("member_type"));
		
		String password = EgovFileScrty.encryptPassword(request.getParameter("password"), request.getParameter("id"));
		adminMemberVO.setPassword(password);
		
		return adminMemberMapper.memberInsert(adminMemberVO);
	}
	@Override
	public int idCheck(String id) throws Exception{
		return adminMemberMapper.idCheck(id);
	}
	
	@Override
	public int memberUpdate (MultipartHttpServletRequest request) throws Exception{
		AdminMemberVO adminMemberVO = new AdminMemberVO();
		adminMemberVO.setId(request.getParameter("id"));
		adminMemberVO.setName(request.getParameter("name"));
		adminMemberVO.setRegion_code(request.getParameter("regionCode"));
		adminMemberVO.setMember_type(request.getParameter("member_type"));
		
		String password = EgovFileScrty.encryptPassword(request.getParameter("password"), request.getParameter("id"));
		adminMemberVO.setPassword(password);
		
		return adminMemberMapper.memberUpdate(adminMemberVO);
	} 
	
	@Override
	public int memberDelete (String id) throws Exception{
		return adminMemberMapper.memberDelete(id);
	}
	
	
}
