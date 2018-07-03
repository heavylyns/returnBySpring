package returnProject.site.main.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import returnProject.popup.service.PopupVO;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.main.service.MainService;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("mainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService{
	
	@Resource(name="mainMapper")
	private MainMapper mainMapper;
	
	// main > 강원 귀농귀촌 뉴스 조회
	public List<BoardVO> selectNewsList(BoardVO boardVO) throws Exception {
		return mainMapper.selectNewsList(boardVO);
	}
	// main > 인포존 조회
	public List<PopupVO> selectInfoList() throws Exception {
		return mainMapper.selectInfoList();
	}
	// main > 나의 귀농귀촌이야기 조회
	public SiteBoardVO selectStory() throws Exception {
		return  mainMapper.selectStory();
	}
	// main > Popup List 조회
	public List<PopupVO> selectPopupList() throws Exception {
		return mainMapper.selectPopupList();
	}
	// main > Popup view 조회
	@Override
	public PopupVO selectPopupView(PopupVO popupVO) throws Exception {
		popupVO = mainMapper.selectPopupView(popupVO);
		return popupVO;
	}
	// 로그인 액션  - 사용자
	@Override
	public SiteMemberVO actionLogin(SiteMemberVO loginVO) throws Exception {
		String password = EgovFileScrty.encryptPassword(loginVO.getPassword(), loginVO.getId());
		loginVO.setEnc_password(password);
		return mainMapper.actionLogin(loginVO);
	}
	
	// 로그인 액션  - 관리자
	@Override
	public SiteMemberVO actionLogin2(SiteMemberVO loginVO) throws Exception {
		return mainMapper.actionLogin2(loginVO);
	}
	// 회원가입
	@Override
	public void insertMember(SiteMemberVO siteMemberVO) throws Exception {
		String password = EgovFileScrty.encryptPassword(siteMemberVO.getPassword(), siteMemberVO.getId());
		siteMemberVO.setPassword(password);
		mainMapper.insertMember(siteMemberVO);
	}
	// 회원정보 수정
	@Override
	public void updateMember(SiteMemberVO loginVO) throws Exception {
		String password = EgovFileScrty.encryptPassword(loginVO.getPassword(), loginVO.getId());
		loginVO.setPassword(password);
		mainMapper.updateMember(loginVO);
	}
	
	// 회원탈퇴
	@Override
	public void deleteMember(SiteMemberVO loginVO) throws Exception {
		mainMapper.deleteMember(loginVO);
	}
	
	//중복 체크
	@Override
	public int existChk_id(String id) throws Exception {
		return mainMapper.existChk_id(id);
	}
}
