<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
			
			});
			function boardListGo(pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}
			function boardArticleGo(boardNo, boardCode){
				document.frm.boardNo.value = boardNo;
				document.frm.boardCode.value = boardCode;
				//document.subForm.pageIndex.value = pageNo;
				document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
				document.frm.submit();
			}
			function boardAddGo(boardCode){
				document.subForm.boardCode.value = boardCode;
				//document.subForm.pageIndex.value = pageNo;
				document.subForm.action = "<c:url value='/admin/board/boardAddPage.do'/>";
				document.subForm.submit();				
			}
		</script>





        <div class="breadcrumb">
		    <ul class="">
		        <li class="home"><a href="#lnk">HOME</a></li>
		        <li><a href="#lnk">게시판 관리</a></li>
		        <li class="active">귀농귀촌 사례</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">귀농귀촌 사례</h3>
		
		<div class="contents">
		<form name="subForm" id="subForm" method="post">
			<input type="hidden" id="subFormBoardNo" name="boardNo"/>
			<input type="hidden" id="subFormBoardCode" name="boardCode"/>
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form>
		    <table class="tbl">
		        <colgroup>
		            <col style="width:10%;"/>
		            <col style="width:25%;"/>
		            <col style="width:25%;"/>
		            <col style="width:15%;"/>
		            <col style="width:25%;"/>
		        </colgroup>
		        <thead>
		        <tr>
		            <th scope="col">No</th>
		            <th scope="col">제목</th>
		            <th scope="col">이미지</th>
		            <th scope="col">지역</th>
		            <th scope="col">등록일</th>
		        </tr>
		        </thead>
		        <tbody>
	 				<c:forEach var="result" items="${resultList}" varStatus="status">
	                    <tr>
	                        <td class="tc"><c:out value="${result.rownum }"/></td>
	                        <%-- <td class="tc"><a href="/admin/fran/franchise_app_view.do?mberId=<c:out value="${result.mberId}"/>"><c:out value="${result.store_name}"/></a></td> --%>
	                        <td class="tc">
	                        	<a href="#"  onclick="boardArticleGo('${result.board_no}','${result.board_code}');"><c:out value="${result.title }"/></a>
	                        </td>
	                        <td class="tc">
	                        	<img src="<c:out value='${result.attached_file_url }'/>" style="width:100px;height: 50px" />
	                        </td>
	                        <td class="tc">
	                        	<c:out value="${result.region_name }"/>
	                        </td>
	                        <td class="tc">${result.reg_date }</td>
	                    </tr>
	 				</c:forEach>
	 				<c:if test="${fn:length(resultList) == 0}">
	                    <tr>
	                        <td class="tc" colspan="5">귀농귀촌 사례가 없습니다.</td>
	                    </tr>
	 				</c:if>
		        </tbody>
		    </table>
		    <div class="clearfix">
					<c:if test="${fn:contains(curAdmin.menuIds, '[322]')}">
		           		<a href="javascript:boardAddGo('<c:out value='${searchVO.boardCode}'/>');" class="message form-line-btn defbtn pink fr">글쓰기</a>
		        	</c:if>
		        </div>
			<div class="pager">
				<div class="tabletshow">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="boardListGo" />
			    </div>
		    </div>
		    <form name="frm" action ="<c:url value='/admin/board/selectBoardList.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="boardCode" value="<c:out value='${searchVO.boardCode}'/>"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input type="hidden" id="boardNo" name="boardNo"/> 
				<!-- <input type="hidden" name="pageIndex" value="1"/> --> 
			        <div class="tbl-search" style="width:400px;">
			        	<div class="subselect-jqList sel-basic" style="width:80px;">
			            	<select id="regionCode" name="regionCode">
			            		<option label="" value="" <c:if test="${searchVO.regionCode == ''}">selected="selected"</c:if>>전체</option>
					        	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					            	<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test="${searchVO.regionCode == regionResult.region_code}">selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
					            </c:forEach>
				            </select>
				        </div>
			            <div class="subselect-jqList sel-basic">
			            	
			                <select name="searchCnd" id="searchCnd" title="검색 필터" class="wid100">
			                    <option value="3" <c:if test="${searchVO.searchCnd == '3' || searchVO.searchCnd == ''}">selected="selected"</c:if>>전체</option>
			                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
			                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
			                    <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
			                </select>
			            </div>
			            <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" style="width: 40%;" value="${searchVO.searchWrd}">
			            <c:if test="${fn:contains(curAdmin.menuIds, '[322]')}">
			            	<button type="button" class="tbl-search-btn" onclick="javascript:boardListGo('1');"><span class="screen_out">검색</span></button>
			            </c:if>
			        </div>
		        </form>
		   <%--  <div class="pager">
		        <div class="mobshow">
		            <a href="#lnk" class="pager-first"><span class="screen_out">처음</span></a>
		            <a href="#lnk" class="pager-prev"><span class="screen_out">이전</span></a>
		                    <span class="pager-numlist">
		                        <span><span class="screen_out">현재 페이지</span>1</span>/
		                        <span><span class="screen_out">전체 페이지 갯수</span>99</span>
		                    </span>
		            <a href="#lnk" class="pager-next"><span class="screen_out">다음</span></a>
		            <a href="#lnk" class="pager-last"><span class="screen_out">마지막</span></a>
		        </div>
		
		        <div class="tabletshow">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_appList" />
		        </div>
            </div> --%>
            <%-- 
			<form name="frm" method="post" action="">
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
				
			    <div class="tbl-search">
			        <div class="subselect-jqList">
			            <div class="subselect-jqListbox jqListbox-adapt">
			                <select name="searchCnd" id="searchCnd" title="검색 필터">
			                    <option value="store" <c:if test="${boardVO.searchCnd eq '' || boardVO.searchCnd eq 'store'}">selected="selected"</c:if>>상호명</option>
			                    <option value="cor" <c:if test="${boardVO.searchCnd eq 'cor' }">selected="selected"</c:if>>사업자번호</option>
			                </select>
			            </div>
			        </div>
			        <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" value="${boardVO.searchWrd }">
			        <button type="button" onclick="select_appList();" class="tbl-search-btn"><span class="screen_out">검색</span></button>
			    </div>

		    </form>
			 --%>
		</div>



