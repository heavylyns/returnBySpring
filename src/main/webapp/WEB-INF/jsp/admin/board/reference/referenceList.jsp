<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		
		<script type="text/javascript">
		
			$(document).ready(function() {
			
			});
			function referenceListGo(pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}
			function referenceArticleGo(boardNo, boardCode){
				document.frm.boardNo.value = boardNo;
				document.frm.boardCode.value = boardCode;
				//document.subForm.pageIndex.value = pageNo;
				document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
				document.frm.submit();
			}
			function referenceAddGo(boardCode){
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
		        <li class="active">자료실</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">자료실</h3>
		
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
		            <th scope="col">작성자</th>
		            <th scope="col">첨부</th>
		            <th scope="col">등록일</th>
		        </tr>
		        </thead>
		        <tbody>
	 				<c:forEach var="result" items="${resultList}" varStatus="status">
	                    <tr>
	                        <%-- <td class="tc">${result.board_no}</td> --%>
	                        <td class="tc"><c:out value="${result.rownum}"/></td>
	                        <%-- <td class="tc"><a href="/admin/fran/franchise_app_view.do?mberId=<c:out value="${result.mberId}"/>"><c:out value="${result.store_name}"/></a></td> --%>
	                        <td class="tc">
	                        	<a href="#"  onclick="referenceArticleGo('${result.board_no}','${result.board_code}');"><c:out value="${result.title }"/></a>
	                        </td>
	                        <td class="tc">
	                        	${result.name }
	                        </td>
	                        <td class="tc">
	                        	<c:if test="${result.attached_file_yn eq 'Y' }">
	                        		Y
	                        	</c:if>
	                        	<c:if test="${result.attached_file_yn ne 'Y' }">
	                        		N
	                        	</c:if>
	                        </td>
	                        <td class="tc">${result.reg_date }</td>
	                    </tr>
	 				</c:forEach>
	 				<c:if test="${fn:length(resultList) == 0}">
	                    <tr>
	                        <td class="tc" colspan="5">등록된 게시물이 없습니다.</td>
	                    </tr>
	 				</c:if>
		        </tbody>
		    </table>
		    <div class="clearfix">
		    	
					<c:if test="${fn:contains(curAdmin.menuIds, '[312]')}">
		           		<a href="javascript:referenceAddGo('01');" class="message form-line-btn defbtn pink fr">글쓰기</a>
		           	</c:if>
		        </div>
			<div class="pager">
				<div class="tabletshow">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="referenceListGo" />
			    </div>
		    </div>
		    <form name="frm" action ="<c:url value='/admin/board/selectBoardList.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" id="boardNo" name="boardNo"/>
				<input type="hidden" name="boardCode" value="01"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
			        <div class="tbl-search">
			            <div class="subselect-jqList sel-basic">
			                <select name="searchCnd" id="searchCnd" title="검색 필터" class="wid100">
			                    <option value="3" <c:if test="${searchVO.searchCnd == '3' || searchVO.searchCnd == ''}">selected="selected"</c:if>>전체</option>
			                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
			                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
			                    <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
			                </select>
			            </div>
			            <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" value="${searchVO.searchWrd}">
			           	<button type="button" class="tbl-search-btn" onclick="javascript:referenceListGo('1');"><span class="screen_out">검색</span></button>
			            
			        </div>
		        </form>
		</div>



