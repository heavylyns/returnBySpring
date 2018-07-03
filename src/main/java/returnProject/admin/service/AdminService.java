package returnProject.admin.service;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;







import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

public interface AdminService {

	
    /**
     * 관리자 로그인을 처리한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public AdminVO adminLogin(AdminVO vo) throws Exception;

    public List<AdminRoleVO> getAdminRole(String id) throws Exception;
    
    public AdminBoardVO boardCnt (String boardCode) throws Exception;
    
    public List<AdminVO> getRecentVisitor() throws Exception;
    
    public List<AdminVO> monthlyVisitor(HttpServletRequest request) throws Exception;

    public void visitorCounter() throws Exception;
}
