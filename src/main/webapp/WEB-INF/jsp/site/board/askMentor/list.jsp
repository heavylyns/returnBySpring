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
			document.frm.action = "<c:url value='/site/instance/askMentor_view.do'/>";
			document.frm.submit();
		}
		function askMentorAddGo(){
			document.frm.action = "<c:url value='/site/instance/askMentor_action.do?type=insert'/>";
			document.frm.submit();				
		}
	</script>
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">멘토에게 물어봐</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="cirborder-wrap askmentor">
        	<div class="cirtit">
        		<ul>
                	<li>『멘토에게 물어봐』 및 강원도 귀농귀촌 지원센터 <em>모든 게시판은 실명제로 운영</em>하고 있습니다.</li>
                    <li><span>게시판 취지에 맞지 않는 상업적 광고, 욕설 등의 글은 삭제</span>됨을 알려드립니다.</li>
                    <li>특정인비방, 명예훼손에 해당하는 경우 『정보통신망이용촉진 및 정보보호등에관한법률 제44조』에 의해 처벌받게 됩니다.   </li>
               </ul>
       		</div>
        </div>
        <div class="basicboard-wrap">
            <p class="numinfo">총게시물 <span>${resultCnt}건</span></p>
            <table class="basicboard-tbl">
                <caption>글 리스트</caption>
                <colgroup>
                    <col style="width:5%;"/>
                    <col style="width:65%;"/>
                    <col style="width:10%;"/>
                    <col style="width:10%;"/>
                    <col style="width:10%;"/>
                </colgroup>
	            <thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">처리상태</th>
						<th scope="col">글쓴이</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
                <tbody>
                <c:forEach var="row" items="${resultList}" varStatus="status">
	                <tr>
	                    <td>${row.rownum}</td>
	                    <td class="tit">
	                    	<c:if test="${row.lock_yn eq 'Y'}"> <span class="secret">비공개</span> </c:if>
	                    	<c:choose>	
	                    		<c:when test="${sessionScope.loginVO.login_type eq 'admin' || sessionScope.loginVO.id eq row.writer || row.lock_yn ne 'Y'}">
	                    			<a href="#" onclick="javascript:selectArticle('${row.board_no}');" class="dotline">${row.title}</a>                    		
		                    	</c:when>
		                    	<c:otherwise>
		                    		${row.title}
		                    	</c:otherwise>
		                    </c:choose>
	                    </td>
	                    <td>
							<c:if test="${row.status eq 'Y'}">
								<span class="post-complete">답변완료</span>
							</c:if>
							<c:if test="${row.status eq 'N'}">
								<span class="post-ing">접수중</span>
							</c:if>
	                    </td>
	                    <c:if test="${loginVO.login_type ne 'admin'}">
	                    	<td>${fn:substring(row.name,0,1)}<c:forEach begin="2" end="${fn:length(row.name)}" step="1"><c:out value="*"/></c:forEach></td>
	                    </c:if>
	                    <c:if test="${loginVO.login_type eq 'admin'}">
	                    	<td>${row.name}</td>
	                    </c:if>
	                    <td>${row.reg_date }</td>
	                </tr>
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
	            	<tr>
	                	<td class="tc" colspan="5">등록된 게시물이 없습니다.</td>
	                </tr>
	 			</c:if>
                </tbody>
            </table>
            <div class="tr">
	        	<a href="javascript:askMentorAddGo();"  class="commonbtns black onebtn">글쓰기</a>
            </div>
            
            <form name="frm" action ="<c:url value='/site/instance/askMentor.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" id="boardNo" name="boardNo"/>
				<input type="hidden" name="boardCode" value="05"/>
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
	                        <select name="searchCnd" id="searchCnd" title="검색필터 선택">
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
