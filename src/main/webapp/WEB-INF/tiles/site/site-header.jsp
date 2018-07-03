<%@ page import="org.springframework.web.util.UrlPathHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="returnProject.site.main.service.SiteMemberVO"%>
<%
	UrlPathHelper urlPathHelper = new UrlPathHelper();
	String originalURL = urlPathHelper.getOriginatingRequestUri(request);
	String url[] = originalURL.split("/");
	String depth1 = "";
	String depth2 = "";
	depth1 = url[url.length-2];
	depth2 = url[url.length-1];
	depth2 = depth2.split("[\\_\\.]")[0];
	
	SiteMemberVO user = (SiteMemberVO) request.getSession().getAttribute("loginVO");
%>
		<script type="text/javascript">
			console.log("depth1:::<%=depth1%>");
			console.log("depth2:::<%=depth2%>");
			
			function changeDepth1(){
				var depth1 = $("#bread1 option:selected").val();
				var url = '';
				if(depth1 == 'member'){
					<%if(user == null){%>
					url = '/site/member/login.do';
					<%}else if(user != null && user.getLogin_type().equals("admin")){%>
					url = '/site/main.do';
					alert("관리자 모드에서는 정보변경이 불가능 합니다.\n관리자페이지를 이용해 주세요.")
					<%}else if(user != null && user.getLogin_type().equals("user")){%>
					url = '/site/member/updateMember.do';
					<%}%>
				}
				else if(depth1 == 'intro') url = '/site/intro/greeting.do';
				else if(depth1 == 'policy') url = '/site/policy/gangwondo.do';
				else if(depth1 == 'counsel') url = '/site/counsel/ready.do';	
				else if(depth1 == 'edu') url = '/site/edu/monthlyEdu.do';
				else if(depth1 == 'instance') url = '/site/instance/instance.do';
				else if(depth1 == 'comunity') url = '/site/comunity/news.do';
				location.href = url;
				return false;
			}			
			
			function changeDepth2(){
				var url = '/site/'+$("#bread1 option:selected").val()+'/'+$("#bread2 option:selected").val()+'.do';
				location.href = url;
				return false;
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
                <%if(user == null){%>
                <!--로그인 전-->
                <ul class="header-topmenu clearfix">
                    <li><a href="/site/member/login.do">로그인</a></li>
                    <li><a href="/site/member/join_01.do">회원가입</a></li>
                    <li><a href="/site/member/find_01.do">아이디 찾기</a></li>
                    <li><a href="/site/member/reset_01.do">비밀번호 초기화</a></li>
                </ul>
                <!-- //로그인 전-->
				<%}else{%>
                <!--로그인후 -->
                <ul class="header-topmenu clearfix">
                	<c:if test="${loginVO.login_type eq 'admin'}"><li><a>관리자 모드</a></li></c:if>
                    <li><a href="/site/member/logout.do">로그아웃</a></li>
         		    <%--이용자 로그인 시에만 회원정보 수정 가능 --%>
		            <%if(user.getLogin_type().equals("user")){%>
                    	<li><a href="/site/member/updateMember.do">회원정보수정</a></li>
             		<%}%>
                </ul>
                <!-- //로그인후 -->
                <%} %>
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
    
<%if (depth1.equals("member")){ %>
	<div class="subconwrap utility">
<%}else if(depth1.equals("intro")){%>
	<div class="subconwrap introduce">
<%}else if(depth1.equals("policy")){%>
	<div class="subconwrap support">
<%}else if(depth1.equals("counsel")){%>
	<div class="subconwrap counseling">
<%}else if(depth1.equals("edu")){%>
	<div class="subconwrap eduinfo">
<%}else if(depth1.equals("instance")){%>
	<div class="subconwrap instance">
<%}else if(depth1.equals("comunity")){%>
	<div class="subconwrap community">
<%}%>    

    <div class="subgnbwrap">
        <div class="incontainer">
        	<%if(depth1.equals("member")){ //login 등%>
        		<p class="subtit">회원안내 <span>Member Ship</span></p>
        	<%}else if(depth1.equals("intro")){%>
        		<p class="subtit">센터소개 <span>Center Introduce</span></p>
        	<%}else if(depth1.equals("policy")){%>
            	<p class="subtit">지원정책 <span>Supporting Policy</span></p>
        	<%}else if(depth1.equals("counsel")){%>
        		<p class="subtit">귀농귀촌상담 <span>Farming Counsel</span></p>
        	<%}else if(depth1.equals("edu")){%>
        		<p class="subtit">교육정보 <span>Education Information</span></p>
        	<%}else if(depth1.equals("instance")){%>
        		<p class="subtit">귀농귀촌 사례 <span>Farming Instance</span></p>
        	<%}else if(depth1.equals("comunity")){%>
        		<p class="subtit">커뮤니티 <span>Community</span></p>
        	<%}%>
        </div>
    </div>
    <div class="breadwrap">
        <div class="incontainer">
            <ul class="breadcrumb clearfix">
                <li class="home"><a href="/site/main.do">HOME</a></li>
                <li>
                    <select name="bread1" id="bread1"  title="이동페이지 선택" onchange="javascript:changeDepth1();">
                        	<option value="member" <%if(depth1.equals("member")){ out.print("selected='selected'");}%>>회원안내</option>
                        	<option value="intro" <%if(depth1.equals("intro")){ out.print("selected='selected'");}%>>센터소개</option>
                        	<option value="policy" <%if(depth1.equals("policy")){ out.print("selected='selected'");}%>>지원정책</option>
                        	<option value="counsel" <%if(depth1.equals("counsel")){ out.print("selected='selected'");}%>>귀농귀촌 상담</option>
                        	<option value="edu" <%if(depth1.equals("edu")){ out.print("selected='selected'");}%>>교육정보</option>
                        	<option value="instance" <%if(depth1.equals("instance")){ out.print("selected='selected'");}%>>귀농귀촌 사례</option>
                        	<option value="comunity" <%if(depth1.equals("comunity")){ out.print("selected='selected'");}%>>커뮤니티</option>
                    </select>
                </li>
                <li>
                    <select name="bread2" id="bread2" title="이동페이지 선택" onchange="javascript:changeDepth2();"> 
                        <%if(depth1.equals("member")){%>
	                        <c:if test="${loginVO eq null}">
	                        	<option value="login" <%if(depth2.equals("login")){ out.print("selected='selected'");}%>>로그인</option>
	                        	<option value="join_01" <%if(depth2.equals("join")){ out.print("selected='selected'");}%>>회원가입</option>
	                        	<option value="find_01" <%if(depth2.equals("find")){ out.print("selected='selected'");}%>>아이디 찾기</option>
	                        	<option value="reset_01" <%if(depth2.equals("reset")){ out.print("selected='selected'");}%>>비밀번호 초기화</option>
	                    	</c:if>
	                    	<%-- 로그인중일 때 --%>
	                    	<c:if test="${loginVO ne null}">
	                    		<option value="logout">로그아웃</option>
	                    		<%-- 유저로 로그인 했을시에만 회원정보/수정 탈퇴 가능 --%>
	                    		<c:if test="${loginVO.login_type eq 'user'}">
		                    		<option value="updateMember" <%if(depth2.equals("updateMember")){ out.print("selected='selected'");}%>>회원정보 수정</option>
		                        	<option value="memBreak" <%if(depth2.equals("memBreak")){ out.print("selected='selected'");}%>>회원탈퇴</option>
	                    		</c:if>
	                    	</c:if>
                    	<%}else if(depth1.equals("intro")){%>
                    		<option value="greeting" <%if(depth2.equals("greeting")){ out.print("selected='selected'");}%>>인사말</option>
                    		<option value="introduce" <%if(depth2.equals("introduce")){ out.print("selected='selected'");}%>>센터안내</option>
                    		<option value="directions" <%if(depth2.equals("directions")){ out.print("selected='selected'");}%>>오시는길</option>
                    	<%}else if(depth1.equals("policy")){%>
                    		<option value="gangwondo" <%if(depth2.equals("gangwondo")){ out.print("selected='selected'");}%>>강원도 지원정책</option>
                    		<option value="city" <%if(depth2.equals("city")){ out.print("selected='selected'");}%>>시군 지원정책</option>
                    		<option value="house" <%if(depth2.equals("house")){ out.print("selected='selected'");}%>>귀농인의 집</option>
                    		<option value="fcenter" <%if(depth2.equals("fcenter")){ out.print("selected='selected'");}%>>체류형 농업창업지원센터</option>
                    		<option value="reference" <%if(depth2.equals("reference")){ out.print("selected='selected'");}%>>자료실</option>
                    	<%}else if(depth1.equals("counsel")){%>
                    		<option value="ready" <%if(depth2.equals("ready")){ out.print("selected='selected'");}%>>준비절차</option>
                    		<option value="info" <%if(depth2.equals("info")){ out.print("selected='selected'");}%>>상담안내</option>
                    		<option value="onlineCounsel" <%if(depth2.equals("onlineCounsel")){ out.print("selected='selected'");}%>>온라인 상담안내</option>
                    		<option value="cityCenter" <%if(depth2.equals("cityCenter")){ out.print("selected='selected'");}%>>시군별 상담센터</option>
                    		<option value="mentor" <%if(depth2.equals("mentor")){ out.print("selected='selected'");}%>>강원 귀농귀촌 멘토단</option>
                    	<%}else if(depth1.equals("edu")){%>
                    		<option value="monthlyEdu" <%if(depth2.equals("monthlyEdu")){ out.print("selected='selected'");}%>>이달의 교육</option>
                    		<option value="cityEdu" <%if(depth2.equals("cityEdu")){ out.print("selected='selected'");}%>>시군별 교육</option>
                    		<%-- <option value="onlineEdu" <%if(depth2.equals("onlineEdu")){ out.print("selected='selected'");}%>>온라인 교육과정</option> --%>
                    	<%}else if(depth1.equals("instance")){%>
                    		<option value="instance" <%if(depth2.equals("instance")){ out.print("selected='selected'");}%>>귀농귀촌 사례</option>
                    		<option value="story" <%if(depth2.equals("story")){ out.print("selected='selected'");}%>>나의 귀농귀촌 이야기</option>
                    		<option value="askMentor" <%if(depth2.equals("askMentor")){ out.print("selected='selected'");}%>>멘토에게 물어봐</option>
                    	<%}else if(depth1.equals("comunity")){%>
                    		<option value="news" <%if(depth2.equals("news")){ out.print("selected='selected'");}%>>강원 귀농귀촌 뉴스</option>
                    		<option value="webzine" <%if(depth2.equals("webzine")){ out.print("selected='selected'");}%>>웹진</option>
                    		<option value="gallery" <%if(depth2.equals("gallery")){ out.print("selected='selected'");}%>>갤러리</option>
                    		<option value="freeBoard" <%if(depth2.equals("freeBoard")){ out.print("selected='selected'");}%>>자유게시판</option>
                    	<%}%>
                    </select>
                </li>
            </ul>
        </div>
    </div>
    