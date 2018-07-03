package returnProject.admin.service.impl;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminVO;

import java.util.List;

@Mapper("adminMapper")
public interface AdminMapper {



    public AdminVO adminLogin(AdminVO vo) throws Exception;
    
    public List<AdminRoleVO> getAdminRole(String id) throws Exception;
    
    public AdminBoardVO boardCnt (String boardCode) throws Exception;

    public AdminBoardVO houseCnt (String boardCode) throws Exception;
    
    public List<AdminVO> recentVisitor() throws Exception;
    
    public List<AdminVO> monthlyVisitor(String year) throws Exception;
    
    public int todayDateCheck (String visit_date) throws Exception;
    
    public int insertVisitorsDate () throws Exception;
    
    public int updateVisitorsCnt (String visit_date) throws Exception;
}
