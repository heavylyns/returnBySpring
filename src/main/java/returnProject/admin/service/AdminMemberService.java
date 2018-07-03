package returnProject.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cop.bbs.service.BoardVO;
import returnProject.popup.service.PopupVO;

public interface AdminMemberService {

	// 홈페이지 관리 > 관리자 list
    public Map<String, Object> selectAdminMemberList(AdminMemberVO adminMemberVO) throws Exception;
    public List<AdminMemberVO> selectRegionStatistics(AdminMemberVO adminMemberVO) throws Exception;
    // 홈페이지 관리 > 관리자 view
	public AdminMemberVO selectAdminMember(String id) throws Exception;
	
	public int memberInsert(MultipartHttpServletRequest request) throws Exception;
	public int idCheck(String id) throws Exception;
	public int memberUpdate(MultipartHttpServletRequest request) throws Exception;
	public int memberDelete(String id) throws Exception;
	
}
