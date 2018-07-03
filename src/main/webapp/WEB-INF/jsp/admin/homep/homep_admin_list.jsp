<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
			});

			function select_adminList(){
				if($("#searchWrd").val() == ""){
					alert("검색어를 입력해 주세요.");			
					$("#searchWrd").focus();
					return;
				}
				document.frm.action = "<c:url value='/admin/homep/homep_admin_list.do'/>";
				document.frm.submit();
			}
			function admin_delete(v_id){
				if(confirm("정말로 삭제하시겠습니까?")){
					location.href = "/admin/homep/admin_delete.do?id="+v_id;
				}
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">홈페이지 관리</a></li>
			        <li class="active">관리자 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">관리자 관리</h3>
			
			<div class="contents">
			
					
	            <table class="tbl tc">
	                <caption>관리자 관리 표</caption>
	                <colgroup>
	                    <col style="width:5.1%"/>
	                    <col style="width:11.1%"/>
	                    <col style="width:11.1%"/>
	                    <col style="width:11.1%"/>
	                    <%-- <col style="width:13.1%"/> --%>
	                    <col style="width:12.1%"/>
	                    <col style="width:13.1%"/>
	                    <col style="width:14.1%"/>
	                    <col style="width:8.1%"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No</th>
	                        <th>아이디</th>
	                        <th>비밀번호</th>
	                        <th>이름</th>
	                        <!-- <th>기관명</th> -->
	                        <th>부서명</th>
	                        <th>전화번호</th>
	                        <th>구분</th>
	                        <th>삭제</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	
	 					<c:forEach var="result" items="${resultList}" varStatus="status">
		                    <tr>
		                        <td>${result.rownum}</td>
		                        <td><a href="/admin/homep/homep_admin_view.do?id=${result.id}&type=update">${result.id}</a></td>
		                        <td>${result.password}</td>
		                        <td>${result.name}</td>
		                        <%-- <td>${result.organ_name}</td> --%>
		                        <td>${result.depart_name}</td>
		                        <td>${result.phone_no1}-${result.phone_no2}-${result.phone_no3}</td>
		                        <td>
		                        	<c:if test="${result.roleId eq '1' }">전체관리자</c:if>
		                        	<c:if test="${result.roleId eq '2' }">부관리자</c:if>
		                        </td>
		                        <td class="table-btn">
		                            <button type="button" class="defbtn pink" onclick="javascript:admin_delete('${result.id}');">삭제</button>
		                        </td>
		                    </tr>
	                    </c:forEach>
		 				<c:if test="${fn:length(resultList) == 0}">
		                    <tr>
		                        <td colspan="9">등록된 관리자가 없습니다.</td>
		                    </tr>
		 				</c:if>
	                    
	                </tbody>
	            </table>
				<a href="/admin/homep/homep_admin_view.do?type=insert" class="message form-line-btn defbtn pink fr">관리자등록</a>
				
	            <div class="pager">
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
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_reqList" />
			        </div>
	            </div>
				
				<form name="frm" method="post" action="">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					
				    <div class="tbl-search">
				        <div class="subselect-jqList">
				            <div class="subselect-jqListbox jqListbox-adapt">
				                <select name="searchCnd" id="searchCnd" title="검색 필터">
				                	<option value="" <c:if test="${boardVO.searchCnd eq ''}">selected="selected"</c:if>>전체</option>
				                    <option value="id" <c:if test="${boardVO.searchCnd eq 'id'}">selected="selected"</c:if>>아이디</option>
				                    <option value="name" <c:if test="${boardVO.searchCnd eq 'name' }">selected="selected"</c:if>>이름</option>
				                    <%-- <option value="organ_name" <c:if test="${boardVO.searchCnd eq 'organ_name' }">selected="selected"</c:if>>기관명</option> --%>
				                </select>
				            </div>
				        </div>
				        <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" value="${boardVO.searchWrd }">
				        <button type="button" onclick="select_adminList();" class="tbl-search-btn"><span class="screen_out">검색</span></button>
				    </div>
		
			    </form>
			
			
			
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



