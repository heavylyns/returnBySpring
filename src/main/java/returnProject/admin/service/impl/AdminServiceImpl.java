package returnProject.admin.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import returnProject.admin.service.AdminBoardVO;
import returnProject.admin.service.AdminRoleVO;
import returnProject.admin.service.AdminService;
import returnProject.admin.service.AdminVO;

import org.springframework.stereotype.Service;





@Service("AdminService")
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService {

	@Resource(name="adminMapper")
	private AdminMapper adminMapper;

//
//	/**
//	 * 관리자 로그인을 처리한다.
//	 * @param vo
//	 * @return
//	 * @throws Exception
//	 */
    @Override
	public AdminVO adminLogin(AdminVO vo) throws Exception {

    	// 1. 입력한 비밀번호를 암호화한다.
		//String enpassword = EgovFileScrty.encryptPassword(vo.getPassword(), vo.getId());
    	//vo.setPassword(enpassword);

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	AdminVO adminVO = adminMapper.adminLogin(vo);

    	// 3. 결과를 리턴한다.
    	if (adminVO != null && !adminVO.getId().equals("") && !adminVO.getPassword().equals("")) {
    		return adminVO;
    	} else {
    		adminVO = new AdminVO();
    	}

    	return adminVO;
    }
    // 홈페이지관리 > 권한관리 메뉴 조회
	@Override
	public List<AdminRoleVO> getAdminRole(String id) throws Exception {
		return adminMapper.getAdminRole(id);
	}

	@Override
	public AdminBoardVO boardCnt (String boardCode) throws Exception{
		if(boardCode == "00"){
			return adminMapper.houseCnt(boardCode);
		}else{
			return adminMapper.boardCnt(boardCode);
		}
		
	}
	@Override
	public List<AdminVO> getRecentVisitor () throws Exception{
		Date date = new Date();
		List<AdminVO> recentVisitorResult = new ArrayList<AdminVO>();
		
        String today = date.toString();
        
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date2 = dateFormat.parse(simpleDate.format(date));
        
        System.out.println("현재날짜 : "+ simpleDate.format(date));
        String [] dateArray = new String[10];
        for(int i = 9; i >= 0; i--){
        	Calendar cal = Calendar.getInstance();
            cal.setTime(date2);
            cal.add(Calendar.DATE, -i);
            dateArray[i] = simpleDate.format(cal.getTime());
            
            AdminVO sData = new AdminVO();
            sData.setVisit_date(simpleDate.format(cal.getTime()));
            recentVisitorResult.add(sData);
        }
		List<AdminVO> recentVisitorList = adminMapper.recentVisitor();
		
		for(int j = 0; j < recentVisitorResult.size(); j++){
			for(int jj=0; jj < recentVisitorList.size(); jj++){
				if(recentVisitorResult.get(j).getVisit_date().equals(recentVisitorList.get(jj).getVisit_date())){
					recentVisitorResult.get(j).setVisitor_cnt(recentVisitorList.get(jj).getVisitor_cnt());
				}
			}
		}
		
        return recentVisitorResult;

	}
	
	@Override
	public List<AdminVO> monthlyVisitor (HttpServletRequest request) throws Exception{
		String year = request.getParameter("year");
		List<AdminVO> monthlyVisitorResult = new ArrayList<AdminVO>();
		if(year == null || year.length() == 0){
			Date nowYear = new Date();
			SimpleDateFormat simpleDateYear = new SimpleDateFormat("yyyy");
			year = simpleDateYear.format(nowYear);
		}
		for(int i = 1; i < 13; i++){
			AdminVO sData = new AdminVO();
			sData.setVisit_date(year+"년 "+i+"월");
			monthlyVisitorResult.add(sData);
		}
		
		List<AdminVO> monthlyVisitorList = adminMapper.monthlyVisitor(year);
		
		for(int j = 0; j < monthlyVisitorResult.size(); j++){
			for(int jj=0; jj < monthlyVisitorList.size(); jj++){
				if(monthlyVisitorResult.get(j).getVisit_date().equals(monthlyVisitorList.get(jj).getVisit_date())){
					monthlyVisitorResult.get(j).setVisitor_cnt(monthlyVisitorList.get(jj).getVisitor_cnt());
				}
			}
		}
		
        return monthlyVisitorResult;

	}
	@Override
	public void visitorCounter() throws Exception{
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String visit_date = simpleDate.format(date);
		
		int todayDateCheck = adminMapper.todayDateCheck(visit_date);
		if(todayDateCheck > 0){
			adminMapper.updateVisitorsCnt(visit_date);
		}else{
			adminMapper.insertVisitorsDate();
		}
	}
}
