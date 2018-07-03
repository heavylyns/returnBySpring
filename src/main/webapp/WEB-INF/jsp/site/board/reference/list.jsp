<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="returnProject.site.main.service.SiteMemberVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<script type="text/javascript">
		function fn_egov_select_noticeList(pageNo) {
			document.frm.action = location.href.split("?")[0]+"<c:url value='?pageIndex='/>"+pageNo;
			document.frm.pageIndex.value = pageNo;
			document.frm.submit();
		}
		function selectArticle(boardNo){
			document.frm.boardNo.value = boardNo;
			document.frm.action = "<c:url value='/site/policy/reference_view.do'/>";
			document.frm.submit();
		}
		function referenceAddGo(){
			document.frm.action = "<c:url value='/site/policy/reference_action.do?type=insert'/>";
			document.frm.submit();				
		}
	</script>
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">자료실</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="basicboard-wrap">
            <p class="numinfo">총게시물 <span>${resultCnt}건</span></p>
            <table class="basicboard-tbl">
                <caption>글 리스트</caption>
                <colgroup>
                    <col style="width:8%;"/>
                    <col style="width:70%;"/>
                    <col style="width:10%;"/>
                    <col style="width:12%;"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">NO</th>
                    <th scope="col">제목</th>
                    <th scope="col">첨부</th>
                    <th scope="col">등록일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${resultList}" varStatus="status">
	                <tr>
	                    <td>${row.rownum}</td>
	                    <td class="tl"><strong class="notice"></strong> <a href="#" onclick="javascript:selectArticle(${row.board_no});">${row.title}</a></td>
	                    <td>
	                    	<c:if test="${row.attached_file_yn eq 'Y' }">
	                        	<img src="/image/common/file.png" alt="file">
	                        </c:if>
	                        <c:if test="${row.attached_file_yn ne 'Y' }">
	                        	<!-- N -->
	                        </c:if>
	                    </td>
	                    <td>${row.reg_date }</td>
	                </tr>
                </c:forEach>
                	<c:if test="${fn:length(resultList) == 0}">
	                    <tr>
	                        <td class="tc" colspan="4">등록된 게시물이 없습니다.</td>
	                    </tr>
	 				</c:if>
                </tbody>
            </table>
            <div class="tr">
            	<c:if test="${sessionScope.loginVO.login_type eq 'admin' }">
	        		<a href="javascript:referenceAddGo();"  class="commonbtns black onebtn">글쓰기</a>
            	</c:if>
            </div>
            
            <form name="frm" action ="<c:url value='/site/policy/reference.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" id="boardNo" name="boardNo"/>
				<input type="hidden" name="boardCode" value="01"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
            <c:if test="${resultCnt > 0 }">
            <div class="pgwrap">
            	<!-- 전체페이지 구하기 -->
	    		<fmt:formatNumber var="totalpage" value="${resultCnt / 10}"/>
	    		<fmt:formatNumber value="${totalpage+(1-totalpage%1)%1}" type="number" var="v_totalpage"/>
	    		<!-- //전체페이지 구하기 -->
				<div class="pageinfo-wrap">
					<c:choose>
						<c:when test="${searchVO.pageIndex != 1}">
							<a href="#lnk" onclick="fn_egov_select_noticeList('1')"
								class="pagebtn first"><span class="screen_out">처음</span></a>
							<a href="#lnk"
								onclick="fn_egov_select_noticeList('${searchVO.pageIndex - 1}')"
								class="pagebtn prev"><span class="screen_out">이전</span></a>
						</c:when>
						<c:otherwise>
							<a href="#lnk" onclick="javascript:alert('첫 페이지입니다.');"
								class="pagebtn first"><span class="screen_out">처음</span></a>
							<a href="#lnk" onclick="javascript:alert('첫 페이지입니다.');"
								class="pagebtn prev"><span class="screen_out">이전</span></a>
						</c:otherwise>
					</c:choose>
					<div class="pageinfo">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
					</div>
					<c:choose>
						<c:when test="${searchVO.pageIndex != v_totalpage}">
							<a href="#lnk"
								onclick="fn_egov_select_noticeList('${searchVO.pageIndex + 1}')"
								class="pagebtn next"><span class="screen_out">다음</span></a>
							<a href="#lnk"
								onclick="fn_egov_select_noticeList('${v_totalpage}')"
								class="pagebtn last"><span class="screen_out">마지막</span></a>
						</c:when>
						<c:otherwise>
							<a href="#lnk" onclick="javascript:alert('마지막 페이지입니다.');"
								class="pagebtn next"><span class="screen_out">다음</span></a>
							<a href="#lnk" onclick="javascript:alert('마지막 페이지입니다.');"
								class="pagebtn last"><span class="screen_out">마지막</span></a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
            </c:if>
	            <div class="search-wrap">
	                <div class="seacharea">
	                    <div class="inpsearch-wrap">
	                        <select name="searchCnd" id="searchCnd" class="검색필터 선택">
	                            <option value="3" <c:if test="${searchVO.searchCnd == '3' || searchVO.searchCnd == ''}">selected="selected"</c:if>>전체</option>
				                <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
				                <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
	                        </select>
	                        <div class="posr">
	                            <label for="inp-search" class="js-label-hide"><c:if test="${searchVO.searchWrd eq null || searchVO.searchWrd eq ''}">검색어를 입력하세요.</c:if></label>
	                            <input type="text" id="searchWrd" name="searchWrd" value="${searchVO.searchWrd}"/>
	                        </div>
	                    </div>
	                    <button type="button" class="searchbtn" onclick="javascript:fn_egov_select_noticeList('1');">검색</button>
	                </div>
	            </div>
            </form>
        </div>
    </div>
