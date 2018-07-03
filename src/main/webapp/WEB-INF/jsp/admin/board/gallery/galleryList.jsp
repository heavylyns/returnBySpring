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
		        <li class="active">갤러리</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">갤러리</h3>
		
		<div class="contents">
		<form name="subForm" id="subForm" method="post">
			<input type="hidden" id="subFormBoardNo" name="boardNo"/>
			<input type="hidden" id="subFormBoardCode" name="boardCode"/>
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form>
		
		    <div>
		    <table class="tbl">
		    	<colgroup>
		            <col style="width:30%;"/>
		            <col style="width:30%;"/>
		            <col style="width:30%;"/>
		        </colgroup>
		    	<c:forEach var="result" items="${resultList}" varStatus="status">
		    	<tr>
		    		<c:forEach var="result2" items="${resultList}" varStatus="status2">
			    		<c:if test="${result2.group_num eq status.index }">
			    		<td style="text-align: center;">
			    			<a href="#"  onclick="boardArticleGo('${result2.board_no}','${result2.board_code}');">
			    				<img src="<c:out value='${result2.attached_file_url }'/>" style="width:250px;height: 150px" /><br/>
			    				<c:out value="${result2.title }"/>
			    			</a>
			    		</td>
			    		</c:if>
		    		</c:forEach>
		    	</tr>
		    	</c:forEach>
		    </table>
		    </div>
		    <div class="clearfix">
					<c:if test="${fn:contains(curAdmin.menuIds, '[372]')}">
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
			            <button type="button" class="tbl-search-btn" onclick="javascript:boardListGo('1');"><span class="screen_out">검색</span></button>
			        </div>
		        </form>
		 
		</div>


