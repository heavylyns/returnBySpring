<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			document.frm.action = "<c:url value='/site/instance/instance_view.do'/>";
			document.frm.submit();
		}
		function newsAddGo(){
			document.frm.action = "<c:url value='/site/instance/instance_action.do?type=insert'/>";
			document.frm.submit();				
		}
	</script>
	
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">강원 귀농귀촌 뉴스</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="basicboard-wrap">
            <div class="photoborad-wrap">
	            <c:forEach var="row" items="${resultList}" varStatus="status">
    	            <a href="#" class="photobox" onclick="javascript:selectArticle('${row.board_no}');">       	
	                   	<c:choose>
	                    	<c:when test="${row.attached_file_url eq null || row.attached_file_url eq ''}">
	                    		<img src="/image/common/photo-noimg.gif"/>
    	                	</c:when>
    	                	<c:otherwise>
    	                		<img src="${row.attached_file_url }" width="429px" height="346px"/>
    	                	</c:otherwise>
    	                </c:choose>
    	                <p class="phtotxt dotline">${row.title}</p>
	                </a>
	           	</c:forEach>
            </div>
            <div class="tr">
	            <c:if test="${sessionScope.loginVO.login_type eq 'admin' }">
    	            <a href="javascript:newsAddGo();" class="commonbtns black onebtn">글쓰기</a>
        		</c:if>
            </div>
            
            <form name="frm" action ="<c:url value='/site/comunity/news.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" id="boardNo" name="boardNo"/>
				<input type="hidden" name="boardCode" value="06"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
            
            <c:if test="${resultCnt > 0 }">   
            <div class="pgwrap">
            	<!-- 전체페이지 구하기 -->
	    		<fmt:formatNumber var="totalpage" value="${resultCnt / 9}"/>
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
