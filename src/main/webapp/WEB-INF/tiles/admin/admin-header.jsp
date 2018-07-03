<%@page import="returnProject.admin.service.AdminVO"%>
<%@ page import="org.springframework.web.util.UrlPathHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	UrlPathHelper urlPathHelper = new UrlPathHelper();
	String originalURL = urlPathHelper.getOriginatingRequestUri(request);
	String url[] = originalURL.split("/");
	String depth1 = "";
	String depth2 = "";
	depth1 = url[url.length-2];
	depth2 = url[url.length-1];
	AdminVO user = (AdminVO) request.getSession().getAttribute("adminVO");

	String s_flag = "";		// 사용점관리 > 사용점 통계 > stat flag(new, app)
	if(request.getParameter("stat_flag") != null && request.getParameter("stat_flag") != ""){
		s_flag = request.getParameter("stat_flag");
	}
	String s_bbsId = "";	// 게시판관리 > 게시판ID
	String boardCode = "";
	if(request.getParameter("bbsId") != null && request.getParameter("bbsId") != ""){
		s_bbsId = request.getParameter("bbsId");
	}
	if(request.getParameter("boardCode") != null && request.getParameter("boardCode") != ""){
		boardCode = request.getParameter("boardCode");
	}
%>
	<script type="text/javascript">
		console.log("<%=s_bbsId%>");
		function headerBoardListGo(boardCode){
			document.adminHeaderFrm.boardCode.value = boardCode;
			//$("#pageIndex").val(pageNo);
			document.adminHeaderFrm.method = "post";
			document.adminHeaderFrm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
			document.adminHeaderFrm.submit();
		}
	</script>

	<div class="skip"><a href="#container">본문바로가기</a></div>
	<div class="header">
	<form id="adminHeaderFrm" name="adminHeaderFrm">
		<input type="hidden" id="boardCode" name="boardCode"/>
	</form>
	    <div class="header-container">
	        <h1 class="fl"><a href="/admin/login.do"><img src="/admin/images/common/header-logo.png" alt="강원도 로고"/><span>귀농귀촌 홈페이지 관리자</span></a></h1>
            <%
				if (user != null) {
			%>
	        <ul class="util-list clearfix">
	            <li><em><%=user.getName() %></em>님</li>
	            <li><a href="/admin/adminLogout.do">로그아웃</a></li>
	        </ul>
	        <ul class="gnb tc clearfix">
	        	<c:if test="${fn:contains(curAdmin.menuIds, '[1]') && (fn:contains(curAdmin.menuIds, '[11]') || fn:contains(curAdmin.menuIds, '[12]'))}">
	            	<li><a href="/admin/education/selectReturnHouse.do">교육관리</a></li>
	            </c:if>
	        	<c:if test="${fn:contains(curAdmin.menuIds, '[2]') && (fn:contains(curAdmin.menuIds, '[21]') || fn:contains(curAdmin.menuIds, '[22]') || fn:contains(curAdmin.menuIds, '[23]') || fn:contains(curAdmin.menuIds, '[24]'))}">
	            	<li><a href="/admin/homep/homep_admin_list.do">홈페이지 관리</a></li>
	            </c:if>
	            <c:if test="${fn:contains(curAdmin.menuIds, '[3]') && (fn:contains(curAdmin.menuIds, '[31]') || fn:contains(curAdmin.menuIds, '[32]') || fn:contains(curAdmin.menuIds, '[33]') || fn:contains(curAdmin.menuIds, '[34]') || fn:contains(curAdmin.menuIds, '[35]') || fn:contains(curAdmin.menuIds, '[36]') || fn:contains(curAdmin.menuIds, '[37]') || fn:contains(curAdmin.menuIds, '[38]'))}">
	            	<!-- <li><a href="/admin/board/selectBoardList.do?bbsId=BBSMSTR_000000000001">게시판 관리</a></li> -->
	            	<li><a href="javascript:headerBoardListGo('01')">게시판 관리</a></li>
	            </c:if>
	            <c:if test="${fn:contains(curAdmin.menuIds, '[4]')}">
	            	<li><a href="/admin/webzine/webzine_list.do">웹진관리</a></li>
	            </c:if>
	            <c:if test="${fn:contains(curAdmin.menuIds, '[5]')}">
	            	<li><a href="/admin/member/member_list.do">회원관리</a></li>
	            </c:if>
	        </ul>
	        <%
				} 
			%>
	    </div>
	</div>
	
	<div class="wrapper adminwrapper">
		 <header>
	        <div class="menu-header">
	        	<div class="menu-header-wrap">
	        		<%
						if (user != null) {
							// 사용점 관리
							if(depth1.equals("education")){
	        		%>
								<%-- <h2 class="page-tit">
					            	사용점 관리//<%=depth1 %>//<%=depth2 %>
					            </h2> --%>
					            <ul class="dep2-list">
									<c:if test="${fn:contains(curAdmin.menuIds, '[11]')}">
						                <li <%if(depth2.equals("selectReturnHouse.do") || depth2.equals("returnHouseUpdatePage.do") || depth2.equals("returnHouseAddPage.do")){ %>class="active"<%} %>>
						                	<a href="/admin/education/selectReturnHouse.do"><div class="layout-table"><div class="layout-tablecell">귀농인의 집</div></div></a>
						                	<%-- <ul class="dep3-list">
					                            <li <%if(depth2.equals("franchise_new_list.do") || depth2.equals("franchise_new_view.do")){  %>class="active"<%} %>><a href="/admin/fran/franchise_new_list.do"><div class="layout-table"><div class="layout-tablecell">신규 사용점 수리</div></div></a></li>
					                            <li <%if(depth2.equals("franchise_update_list.do") || depth2.equals("franchise_update_view.do")){  %>class="active"<%} %>><a href="/admin/fran/franchise_update_list.do"><div class="layout-table"><div class="layout-tablecell">사용점 변경</div></div></a></li>
					                            <li <%if(depth2.equals("franchise_out_list.do") || depth2.equals("franchise_out_view.do")){  %>class="active"<%} %>><a href="/admin/fran/franchise_out_list.do"><div class="layout-table"><div class="layout-tablecell">사용점 철회</div></div></a></li>
					                        </ul> --%>
						                </li>
					                </c:if>
									<%-- <c:if test="${fn:contains(curAdmin.menuIds, '[12]')}">
						                <li <%if(depth2.equals("franchise_app_list.do") || depth2.equals("franchise_app_view.do")){ %>class="active"<%} %>>
						                	<a href="/admin/fran/franchise_app_list.do"><div class="layout-table"><div class="layout-tablecell">이달의 교육</div></div></a>
						                </li>
					                </c:if> --%>
									<c:if test="${fn:contains(curAdmin.menuIds, '[12]')}">
						                <li <%if(depth2.equals("selectRegionalEduList.do") || depth2.equals("regionalEduAddPage.do") || depth2.equals("regionalEduUpdatePage.do") || depth2.equals("selectRegionalEduArticle.do")){ %>class="active"<%} %>>
						                	<a href="/admin/education/selectRegionalEduList.do"><div class="layout-table"><div class="layout-tablecell">시군별 교육</div></div></a>
					                        <%-- <ul class="dep3-list">
					                            <li <%if(s_flag.equals("new")){ %>class="active"<%} %>><a href="/admin/fran/franchise_stat.do?stat_flag=new"><div class="layout-table"><div class="layout-tablecell">신규 사용점 통계</div></div></a></li>
					                            <li <%if(s_flag.equals("app")){ %>class="active"<%} %>><a href="/admin/fran/franchise_stat.do?stat_flag=app"><div class="layout-table"><div class="layout-tablecell">사용점 현황 통계</div></div></a></li>
					                        </ul> --%>
						                </li>
					                </c:if>
					            </ul>
		            <%
		            		// 홈페이지 관리
							}else if(depth1.equals("homep")){
					%>
					
								<%-- <h2 class="page-tit">
									홈페이지 관리//<%=depth1 %>//<%=depth2 %>
								</h2> --%>
								<ul class="dep2-list six">
									<c:if test="${fn:contains(curAdmin.menuIds, '[21]')}">
										<li <%if(depth2.equals("homep_admin_list.do") || depth2.equals("homep_admin_view.do")){ %>class="active"<%} %>>
											<a href="/admin/homep/homep_admin_list.do"><div class="layout-table"><div class="layout-tablecell">관리자 관리</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[22]')}">
										<li <%if(depth2.equals("homep_author.do") || depth2.equals("author_agree.do")){ %>class="active"<%} %>>
											<a href="/admin/homep/homep_author.do"><div class="layout-table"><div class="layout-tablecell">권한 관리</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[23]')}">
										<li <%if(depth2.equals("homep_info_list.do") || depth2.equals("homep_info_view.do")){ %>class="active"<%} %>>
											<a href="/admin/homep/homep_info_list.do"><div class="layout-table"><div class="layout-tablecell">인포존 관리</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[24]')}">
										<li <%if(depth2.equals("homep_popup_list.do") || depth2.equals("homep_popup_view.do")){ %>class="active"<%} %>>
											<a href="/admin/homep/homep_popup_list.do"><div class="layout-table"><div class="layout-tablecell">팝업 관리</div></div></a>
										</li>
									</c:if>
								</ul>
					<%		
		            		// 게시판 관리
							}else if(depth1.equals("board")){
					%>
								<%-- <h2 class="page-tit">
									게시판 관리//<%=depth1 %>//<%=depth2 %>
								</h2> --%>
								<ul class="dep2-list six">
									<c:if test="${fn:contains(curAdmin.menuIds, '[31]')}">
										<li <%if(boardCode.equals("01")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=01"><div class="layout-table"><div class="layout-tablecell">자료실</div></div></a> -->
											<a href="javascript:headerBoardListGo('01')"><div class="layout-table"><div class="layout-tablecell">자료실</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[32]')}">
										<li <%if(boardCode.equals("02")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=02"><div class="layout-table"><div class="layout-tablecell">온라인 상담안내</div></div></a> -->
											<a href="javascript:headerBoardListGo('02')"><div class="layout-table"><div class="layout-tablecell">온라인 상담안내</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[33]')}">
										<li <%if(boardCode.equals("03")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=03"><div class="layout-table"><div class="layout-tablecell">귀농귀촌 사례</div></div></a> -->
											<a href="javascript:headerBoardListGo('03')"><div class="layout-table"><div class="layout-tablecell">귀농귀촌 사례</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[34]')}">
										<li <%if(boardCode.equals("04")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=04"><div class="layout-table"><div class="layout-tablecell">나의 귀농귀촌 이야기</div></div></a> -->
											<a href="javascript:headerBoardListGo('04')"><div class="layout-table"><div class="layout-tablecell">나의 귀농귀촌 이야기</div></div></a>
										</li>
									</c:if>
									</ul>
									<ul class="dep2-list six">
									<c:if test="${fn:contains(curAdmin.menuIds, '[35]')}">
										<li <%if(boardCode.equals("05")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=05"><div class="layout-table"><div class="layout-tablecell">멘토에게 물어봐</div></div></a> -->
											<a href="javascript:headerBoardListGo('05')"><div class="layout-table"><div class="layout-tablecell">멘토에게 물어봐</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[36]')}">
										<li <%if(boardCode.equals("06")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=06"><div class="layout-table"><div class="layout-tablecell">강원 귀농귀촌 뉴스</div></div></a> -->
											<a href="javascript:headerBoardListGo('06')"><div class="layout-table"><div class="layout-tablecell">강원 귀농귀촌 뉴스</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[37]')}">
										<li <%if(boardCode.equals("07")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=07"><div class="layout-table"><div class="layout-tablecell">갤러리</div></div></a> -->
											<a href="javascript:headerBoardListGo('07')"><div class="layout-table"><div class="layout-tablecell">갤러리</div></div></a>
										</li>
									</c:if>
									<c:if test="${fn:contains(curAdmin.menuIds, '[38]')}">
										<li <%if(boardCode.equals("08")){ %>class="active"<%} %>>
											<!-- <a href="/admin/board/selectBoardList.do?boardCode=08"><div class="layout-table"><div class="layout-tablecell">자유게시판</div></div></a> -->
											<a href="javascript:headerBoardListGo('08')"><div class="layout-table"><div class="layout-tablecell">자유게시판</div></div></a>
										</li>
									</c:if>
								</ul>
					
					<%
							}
		            	}else {
	        		%>
						<h2 class="page-tit">
			            	로그인
			            </h2>
	        		<%
		            	}
	        		%>
	            </div>
	        </div>
	    </header>


