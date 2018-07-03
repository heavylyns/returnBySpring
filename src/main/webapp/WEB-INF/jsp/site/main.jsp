<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="returnProject.site.main.service.SiteMemberVO"%>
<%@ page import="returnProject.popup.service.PopupVO" %>
<%@ page import="java.util.List"%>

<%  /* 사용자-관리자 구분을 위해 세션으로부터 값을 가져온다.  */
	SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
	/* 팝업 리스트 */
	List<PopupVO> popupList = (List<PopupVO>)request.getAttribute("popup");
%>

	<script type="text/javascript">
		$(document).ready(function(){
			// 팝업 출력
			<%for(int i=0;i<popupList.size();i++){ %>
				window.open('/site/popup.do?popup_no=<%=popupList.get(i).getPopup_no()%>', 'popup<%=popupList.get(i).getPopup_no()%>', 'width=<%=popupList.get(i).getSize_width()%>, height=<%=popupList.get(i).getSize_height()%>, left=<%=popupList.get(i).getView_width()%> ,top=<%=popupList.get(i).getView_height()%>');
			<%}%>
		});
		//메인 > 강원 귀농귀촌 뉴스 > view페이지 이동
		function selectNews(boardNo){	
			document.frm_news.boardNo.value = boardNo;
			document.frm_news.action = "/site/comunity/news_view.do";
			document.frm_news.submit();
		}
		//메인 > 나의 귀농귀촌 이야기 > view페이지 이동
		function selectStory(boardNo){
			document.frm_story.boardNo.value = boardNo;
			document.frm_story.action = "/site/instance/story_view.do";
			document.frm_story.submit();
		}
	</script>
	
		<div class="skip">
		    <a href="#container">콘텐츠 바로가기</a>
		</div>
		
		<div class="wrapper">
		    <div class="headerwrap">
		        <div class="sub-header">
		            <div class="header-container">
		                <a href="/site/main.do" class="head-gobtn"><span>홈으로</span></a>
		                
		                <%-- 로그인 전 시작 --%>
		                <%if(user == null){%>
		                <ul class="header-topmenu clearfix">
		                    <li><a href="/site/member/login.do">로그인</a></li>
		                    <li><a href="/site/member/join_01.do">회원가입</a></li>
		                    <li><a href="/site/member/find_01.do">아이디 찾기</a></li>
		                    <li><a href="/site/member/reset_01.do">비밀번호 초기화</a></li>
		                </ul>
		                <%-- 로그인 전 끝 --%>
		                <%-- 로그인 후 시작--%>
		                <%}else{%>
		                <ul class="header-topmenu clearfix">
		                	<%-- 관리자 로그인시 출력 --%>
		                	<c:if test="${loginVO.login_type eq 'admin'}"><li><a>관리자 모드</a></li></c:if>
		                    <li><a href="/site/member/logout.do">로그아웃</a></li>
		                    <%-- 이용자 로그인 시에만 회원정보 수정이 가능 --%>
		                    <%if(user.getLogin_type().equals("user")){%>
		                    	<li><a href="/site/member/updateMember.do">회원정보수정</a></li>
		                	<%}%>
		                </ul>
		                <%} %>
		                <%-- 로그인 후 끝  --%>
		            </div>
		        </div>
		        <div class="header">
            <div class="header-container">
                <h1 class="logo"><a href="/site/main.do"><img src="/image/common/header-logo.png" alt="강원도 로고 이미지"/><span>강원도귀농귀촌지원센터</span></a></h1>
                <div class="gnbwrap clearfix">
                    <ul class="gnb clearfix">
                        <li>
                            <a href="/site/intro/greeting.do">센터소개</a>
                            <div class="dep2wrap">
                                <ul class="gnbdep2">
                                    <li><a href="/site/intro/greeting.do">인사말</a></li>
                                    <li><a href="/site/intro/introduce.do">센터안내</a></li>
                                    <li><a href="/site/intro/directions.do">오시는길</a></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="/site/policy/gangwondo.do">지원정책</a>
                            <div class="dep2wrap">
                                <ul class="gnbdep2">
                                    <li><a href="/site/policy/gangwondo.do">강원도 지원정책</a></li>
                                    <li><a href="/site/policy/city.do">시군 지원정책</a></li>
                                    <li><a href="/site/policy/house.do?houseNo=01">귀농인의 집</a></li>
                                    <li><a href="/site/policy/fcenter.do">체류형 농업창업지원센터</a></li>
                                    <li><a href="/site/policy/reference.do">자료실</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="wide">
                            <a href="/site/counsel/ready.do">귀농귀촌상담</a>
                            <div class="dep2wrap">
                                <ul class="gnbdep2">
                                    <li><a href="/site/counsel/ready.do">준비절차</a></li>
                                    <li><a href="/site/counsel/info.do">상담안내</a></li>
                                    <li><a href="/site/counsel/onlineCounsel.do">온라인 상담안내</a></li>
                                    <li><a href="/site/counsel/cityCenter.do">시군별 상담센터</a></li>
                                    <li><a href="/site/counsel/mentor.do">강원 귀농귀촌 멘토단</a></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="/site/edu/monthlyEdu.do">교육정보</a>
                           <div class="dep2wrap">
                               <ul class="gnbdep2">
                                   <li><a href="/site/edu/monthlyEdu.do">이달의 교육</a></li>
                                   <li><a href="/site/edu/cityEdu.do">시군별 교육</a></li>
                                   <li class="blanklink"><a href="http://www.agriedu.net/hrm/edu/edu/eduIntgEdusntMOnLineAllList.do?eduLclassCd=5&searchType=edu" target="_blank" title="새창열림">온라인 교육과정</a></li>
                               </ul>
                           </div>
                        </li>
                        <li>
                            <a href="/site/instance/instance.do">귀농귀촌 사례</a>
                            <div class="dep2wrap">
                                <ul class="gnbdep2">
                                    <li><a href="/site/instance/instance.do">귀농귀촌 사례</a></li>
                                    <li><a href="/site/instance/story.do">나의 귀농귀촌 이야기</a></li>
                                    <li><a href="/site/instance/askMentor.do">멘토에게 물어봐</a></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="/site/comunity/news.do">커뮤니티</a>
                            <div class="dep2wrap">
                                <ul class="gnbdep2">
                                    <li><a href="/site/comunity/news.do">강원 귀농귀촌 뉴스</a></li>
                                    <li><a href="/site/comunity/webzine.do">웹진</a></li>
                                    <li><a href="/site/comunity/gallery.do">갤러리</a></li>
                                    <li><a href="/site/comunity/freeBoard.do">자유게시판</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="gnb-dimed"></div>
        </div>
    </div>
    <div class="container" id="container">
		
		<div class="mainbgwrap">
		    <div class="incontainer">
		        <p class="mainsub-tit tc"><img src="/image/main/midtxt.png" alt="귀농인은 소득 두배, 귀촌인은 행복두배"/></p>
		        <div class="mainconwrap clearfix">
		            <div class="mainvisslide-wrap">
		                <div class="slidebox opacityslide mainvisslidejs">
		                    <div class="op-control">
		                        <button type="button"  class="prev">prev</button>
		                        <button type="button" class="next">next</button>
		                    </div>
		                    <div class="op-indicator">
		                        <button type="button" class="op-play"><span class="screen_out">재생</span></button>
		                        <button type="button" class="op-stop"><span class="screen_out">정지</span></button>
		                        <div class="op-indibox">
		                        	<c:forEach var="result" items="${info}" varStatus="status">
		                            	<button type="button" class="op-pager"><span class="screen_out">${status.count}</span></button>
		                        	</c:forEach>
		                        </div>
		                    </div>
		                    
		                    <%-- 인포존 시작 --%>
		                    <ul class="slide">
		                    	<c:forEach var="result" items="${info}">
			                        <li>
			                        	<a href="<c:url value="${result.link}"/>" target="${result.target}"><img src="/cmm/fms/getImage.do?atchFileId=${result.atch_file_id}&fileSn=${result.file_sn}" alt="${result.contents}" width="588px" height="603px"/></a>
			                        </li>
			                    </c:forEach>
		                    </ul>
		                    <%-- 인포존 끝 --%>
		                </div>
		            </div>
		            <div class="mainright-wrap">
		                <div class="clearfix">
		                    <div class="newswrap">
		                        <%-- 강원 귀농귀촌 뉴스 : 시작 --%>
		                        <div>
		                            <p class="main-areatit">강원 귀농귀촌 뉴스</p>
		                            <form name="frm_news" action ="" method="post">
										<input type="hidden" id="boardNo" name="boardNo"/>
										<input type="hidden" name="boardCode" value="06"/>
		                            </form>
		                            <ul>
		                            	<c:forEach var="row" items="${news}" varStatus="status">
			                                <li><a href="#" class="dotline" onclick="javascript:selectNews('${row.boardNo}');">${row.nttSj}</a></li>
		                            	</c:forEach>
		                            </ul>
		                            <a href="/site/comunity/news.do" class="morebtn"><span class="screen_out">더보기 버튼</span></a>
		                        </div>
		                        <%-- 강원 귀농귀촌 뉴스 : 끝 --%>
		                    </div>
		                    
		                    <%-- 나의 귀농귀촌 이야기 : 시작 --%>
		                    <div class="storywrap">
		                       <div>
		                           <div class="imgarea">
		                               <img src="${story.attached_file_url}" width="285px" height="206.27px"/>
		                           </div>
		                           <div class="storytxt">
			                           <form name="frm_story" action ="" method="post">
											<input type="hidden" id="boardNo" name="boardNo"/>
											<input type="hidden" name="boardCode" value="04"/>
			                            </form>
		                               <a href="#" class="title dotline" onclick="javascript:selectStory('${story.board_no}');"><span>나의 귀농귀촌 이야기</span>${story.title}</a>
		                               <p class="desc dotline"><c:out value="${story.contents}"  escapeXml="false"/></p>
		                           </div>
		                           <a href="/site/instance/story.do" class="morebtn"><span class="screen_out">더보기 버튼</span></a>
		                       </div>
		                    </div>
		                    <%-- 나의 귀농귀촌 이야기 : 끝 --%>
		                    
		                    <div class="infowrap">
		                        <div>
		                            <p class="main-areatit">귀농귀촌 종합상담 안내</p>
		                            <div class="infoarea">
		                                <strong>전화번호</strong>
		                                <span>(033)249-2631~4</span>
		                                <span>(상담가능시간 09:00~18:00)</span>
		                            </div>
		                            <div class="infoarea">
		                                <strong>방문상담</strong>
		                                <span>강원도 춘천시 동면 소양강로 110-402호</span>
		                                <span>(강원도사회복지관)</span>
		                            </div>
		                            <a href="/site/counsel/info.do" class="morebtn">go</a>
		                        </div>
		                    </div>
		                </div>
		                
		                <div class="quickwrap">
		                    <p class="main-areatit">빠른메뉴 바로가기</p>
		                    <div class="quickslidewrap">
		                        <div class="slidebox">
		                            <div class="basicslide">
		                                <div class="basicslide-container">
		                                    <ul class="slide">
		                                        <li class="ico1"><a href="/site/policy/gangwondo.do">강원도 지원정책</a></li>
		                                        <li class="ico2"><a href="/site/counsel/cityCenter.do">시군별 상담센터</a></li>
		                                        <li class="ico3"><a href="/site/policy/city.do">시군 지원정책</a></li>
		                                        <li class="ico4"><a href="/site/counsel/mentor.do">강원 귀농귀촌 멘토단</a></li>
		                                        <li class="ico5"><a href="/site/comunity/news.do">강원 귀농귀촌 뉴스</a></li>
		                                    </ul>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		                
		            </div>
		        </div>
		    </div>
		</div>
		        </div>
		        <div class="footerwrap">
		            <div class="footer">
		                <div class="footlnk">
		                    <div class="incontainer tc">
		                        <a href="http://www.provin.gangwon.kr/gw/portal/sub09_01" target="_blank" class="graybtn">개인정보처리방침</a>
		                        <a href="http://www.provin.gangwon.kr/gw/portal/sub09_03" target="_blank" class="graybtn">저작권 정책</a>
		                        <a href="http://privacy.kisa.or.kr/kor/main.jsp" target="_blank" class="graybtn">개인정보 침해 신고</a>
		                    </div>
		                </div>
		                <div class="address">
		                    <div class="incontainer tc">
		                        주소 : 강원도 춘천시 동면 소양강로 110(강원도사회복지회관) 304호   전화번호 : 033-249-2631~4 <br/>
		                        Copyright © 2016 강원농촌융복합산업지원센터. All right reserved
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
