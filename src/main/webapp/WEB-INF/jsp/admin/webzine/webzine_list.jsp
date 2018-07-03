<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
			});
			function webzineListGo(pageNo){
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/webzine/webzine_list.do'/>";
				document.frm.submit();
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <!-- <li><a href="#lnk">홈페이지 관리</a></li> -->
			        <li class="active">웹진 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">웹진 관리</h3>
			
			<div class="contents">
			
				
	            <table class="tbl image">
	                <caption>인포존 표</caption>
	                <colgroup>
	                    <col style="width:7.28%;"/>
	                    <col style="width:25.28%;"/>
	                    <col style="width:14.28%;"/>
	                    <col style="width:14.28%;"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No</th>
	                        <th>제목</th>
	                        <th>이미지</th>
	                        <th>등록일</th>
	                    </tr>
	                </thead>
	                <tbody class="tc">
						<c:forEach var="result" items="${resultList}" varStatus="status">
		                    <tr>
		                        <td>${result.rownum }</td>
		                        <td><a href="/admin/webzine/webzine_view.do?popup_no=${result.popup_no }&type=update">${result.title }</a></td>
		                        <td>
		                        	<c:if test="${result.atch_file_id ne null && result.atch_file_id ne '' }">
		                        		<img src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${result.atch_file_id}"/>&fileSn=<c:out value="${result.file_sn}"/>' alt="${result.orignl_file_nm}" style="width:94px;"/>
		                        	</c:if>
		                        </td>
		                        <td>${result.reg_date }</td>
		                    </tr>
	                    </c:forEach>
		 				<c:if test="${fn:length(resultList) == 0}">
		                    <tr>
		                        <td colspan="7">등록된 웹진이 없습니다.</td>
		                    </tr>
		 				</c:if>
	                </tbody>
	            </table>
	            <div class="clearfix">
	                <a href="/admin/webzine/webzine_view.do?type=insert" class="message form-line-btn defbtn pink fr">등록</a>
	            </div>
	            
	            <div class="pager">
			        <div class="tabletshow">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_reqList" />
			        </div>
	            </div>
	            
	            <form name="frm" action ="<c:url value='/admin/webzine/webzine_list.do'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="pageIndex" value="<c:out value='${boardVO.pageIndex}'/>"/> 
				
			        <div class="tbl-search">
			            <div class="subselect-jqList sel-basic">
			                <select name="searchCnd" id="searchCnd" title="검색 필터" class="wid100">
			                    <option value="3" <c:if test="${boardVO.searchCnd == '3' || boardVO.searchCnd == ''}">selected="selected"</c:if>>전체</option>
			                    <option value="0" <c:if test="${boardVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
			                    <%-- <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
			                    <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option> --%>
			                </select>
			            </div>
			            <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" value="${boardVO.searchWrd}">
			            <button type="button" class="tbl-search-btn" onclick="javascript:webzineListGo('1');"><span class="screen_out">검색</span></button>
			        </div>
		        </form>


			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



