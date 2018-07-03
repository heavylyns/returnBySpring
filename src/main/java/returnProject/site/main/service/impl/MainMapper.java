package returnProject.site.main.service.impl;

import java.util.List;

import returnProject.popup.service.PopupVO;
import returnProject.site.board.service.SiteBoardVO;
import returnProject.site.main.service.SiteMemberVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainMapper")
public interface MainMapper {
	//메인화면 인포존조회
	public List<PopupVO> selectInfoList() throws Exception;
	//메인화면 뉴스조회
	public List<BoardVO> selectNewsList(BoardVO boardVO) throws Exception;
	//메인화면 나의 귀농귀촌 이야기 조회
	public SiteBoardVO selectStory() throws Exception;
	//메인화면 팝업 조회
	public List<PopupVO> selectPopupList() throws Exception;
	//메인화면 팝업뷰
	public PopupVO selectPopupView(PopupVO popupVO) throws Exception;
	
	//로그인액션
	public SiteMemberVO actionLogin(SiteMemberVO loginVO) throws Exception;
	public SiteMemberVO actionLogin2(SiteMemberVO loginVO) throws Exception;
	//회원가입
	public void insertMember(SiteMemberVO siteMemberVO) throws Exception;
	//회원정보 수정
	public void updateMember(SiteMemberVO loginVO) throws Exception;
	//회원탈퇴
	public void deleteMember(SiteMemberVO loginVO) throws Exception;
	//아이디 중복체크
	public int existChk_id(String id) throws Exception;
	
	
	
	
	
}
