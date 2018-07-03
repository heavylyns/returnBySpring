<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
			
			});
			function regionalEduListGo(pageNo) {
				//document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
				document.frm.submit();
			}
			function regionalEduArticleGo(eduNo){
				//document.subForm.boardNo.value = boardNo;
				document.subForm.r_edu_no.value = eduNo;
				//document.subForm.pageIndex.value = pageNo;
				document.subForm.action = "<c:url value='/admin/education/selectRegionalEduArticle.do'/>";
				document.subForm.submit();
			}
			function regionalEduAddGo(){
				//document.subForm.boardCode.value = boardCode;
				//document.subForm.pageIndex.value = pageNo;
				document.subForm.r_edu_no.value = 0;
				document.subForm.action = "<c:url value='/admin/education/regionalEduAddPage.do'/>";
				document.subForm.submit();				
			}
		</script>





        <div class="breadcrumb">
		    <ul class="">
		        <li class="home"><a href="#lnk">HOME</a></li>
		        <li><a href="#lnk">교육 관리</a></li>
		        <li class="active">시군별 교육</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">시군별 교육</h3>
		
		<div class="contents">
		<form name="subForm" id="subForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="r_edu_no" id="r_edu_no"/>
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form>
		    <table class="tbl">
		        <colgroup>
		            <col style="width:10%;"/>
		            <col style="width:25%;"/>
		            <col style="width:25%;"/>
		            <col style="width:10%;"/>
		            <col style="width:10%;"/>
		            <col style="width:20%;"/>
		        </colgroup>
		        <thead>
		        <tr>
		            <th scope="col">No</th>
		            <th scope="col">지역</th>
		            <th scope="col">교육명</th>
		            <th scope="col">작성자</th>
		            <th scope="col">첨부</th>
		            <th scope="col">등록일</th>
		        </tr>
		        </thead>
		        <tbody>
	 				<c:forEach var="result" items="${resultList}" varStatus="status">
	                    <tr>
	                        <td class="tc"><c:out value="${result.rownum }"/></td>
	                        <td class="tc">
	                        	<%-- <a href="#"  onclick="referenceArticleGo('${result.board_no}','${result.board_code}');"><c:out value="${result.title }"/></a> --%>
	                        		<c:out value="${result.region_name }"/>
	                        </td>
	                        <td class="tc">
	                        	<a href="#"  onclick="regionalEduArticleGo('${result.r_edu_no}');">
	                        		<c:out value='${result.r_edu_title }'/>
	                        	</a>
	                        </td>
	                        <td class="tc">
	                        	<c:out value="${result.name}"/>
	                        </td>
	                        <td class="tc"><c:out value="${result.attached_file_yn }"/></td>
	                        <td class="tc">${result.reg_date }</td>
	                    </tr>
	 				</c:forEach>
	 				<c:if test="${fn:length(resultList) == 0}">
	                    <tr>
	                        <td class="tc" colspan="6">등록된 시군별 교육이 없습니다.</td>
	                    </tr>
	 				</c:if>
		        </tbody>
		    </table>
		    <div class="clearfix">
		           	<a href="javascript:regionalEduAddGo();" class="message form-line-btn defbtn pink fr">글쓰기</a>
		        </div>
			<div class="pager">
				<div class="tabletshow">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="referenceListGo" />
			    </div>
		    </div>
		    <form name="frm" method="post">
				
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/> 
				 <!-- <input type="hidden" name="pageIndex" value="1"/>   -->
			        <div class="tbl-search" style="width:400px;">
			        	<div class="subselect-jqList sel-basic" style="width:80px;">
			            	<select id="region_code" name="region_code">
			            		<option value="" <c:if test="${searchVO.region_code == ''}">selected="selected"</c:if>>전체</option>
					        	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					            	<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test="${searchVO.region_code == regionResult.region_code}">selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
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
			            <button type="button" class="tbl-search-btn" onclick="javascript:regionalEduListGo('1');"><span class="screen_out">검색</span></button>
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



