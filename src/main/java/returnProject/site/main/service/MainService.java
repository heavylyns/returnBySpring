package returnProject.site.main.service;

import java.util.List;
import java.util.Map;

import returnProject.popup.service.PopupVO;
import returnProject.site.board.service.SiteBoardVO;
import egovframework.com.cop.bbs.service.BoardVO;

public interface MainService {
		//강원 귀농귀촌  뉴스 조회
		public List<BoardVO> selectNewsList(BoardVO boardVO) throws Exception;
		//인포존 조회
		public List<PopupVO> selectInfoList() throws Exception;
		//나의 귀농귀촌 이야기 조회
		public SiteBoardVO selectStory() throws Exception;
		//팝업 조회
		public List<PopupVO> selectPopupList() throws Exception;
		//팝업 뷰
		public PopupVO selectPopupView(PopupVO popupVO) throws Exception;
		
		//로그인 액션 - 사용자
		public SiteMemberVO actionLogin(SiteMemberVO loginVO) throws Exception;
		//로그인 액션 - 관리자
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
