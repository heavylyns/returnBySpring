<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
			});
			function memberDelete(id){
				if(confirm("삭제 하시겠습니까?")){
					var param = "id="+id;
					var url = '/admin/member/member_delete.do';
					$.ajax({
						url : url
							, dataType : 'json'
							, data : param
							, contentType: "application/json; charset=utf-8"
							, async : false
						    , success : function(data) {
							if (data.count >= 1) {
								alert("삭제했습니다.");
								location.href = '/admin/member/member_list.do';
								
							}else{
								alert("등록 가능한 아이디 입니다.");
								
								return false;
							}
						},
						error : function(xhr, status, err) {
							alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
						}
					}); 
				}
			}
			function memberListGo(pageIndex){
				document.frm.pageIndex.value = pageIndex;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/member/member_list.do'/>";
				document.frm.submit();
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <!-- <li><a href="#lnk">홈페이지 관리</a></li> -->
			        <li class="active">회원 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">회원 관리</h3>
			
			<div class="contents">
				<div style="width: 100%;";>
					<ul style="padding-left:25%;font-size:x-large;">
						<li style="float:left;list-style: disc;padding-right:50px;">전체 인원수 : <c:out value="${resultCnt }"/> 명 </li>
						<li style="float:left;list-style: disc;padding-right:50px;">예비 귀농귀촌인 : <c:out value="${preReturnCnt }"/> 명 </li>
						<li style="float:left;list-style: disc;padding-right:50px;">귀농귀촌인 : <c:out value="${returnedCnt }"/> 명 </li>
					</ul>
				</div>
	            <table class="tbl image" style="width:78%;float:left;">
	                <caption>회원관리 표</caption>
	                <colgroup>
	                    <col style="width:7.28%;"/>
	                    <col style="width:25.28%;"/>
	                    <col style="width:14.28%;"/>
	                    <col style="width:14.28%;"/>
	                    <col style="width:14.28%;"/>
	                    <col style="width:14.28%;"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No</th>
	                        <th>회원구분</th>
	                        <th>아이디</th>
	                        <th>이름</th>
	                        <th>선호지역</th>
	                        <th>삭제</th>
	                    </tr>
	                </thead>
	                <tbody class="tc">
						<c:forEach var="result" items="${resultList}" varStatus="status">
		                    <tr>
		                        <td>${result.rownum }</td>
		                        <td>
		                        	<%-- <a href="/admin/webzine/webzine_view.do?popup_no=${result.popup_no }&type=update">${result.title }</a> --%>
		                        	<c:if test = "${result.member_type eq '01'}">
		                        		예비 귀농 귀촌인
		                        	</c:if>
		                        	<c:if test = "${result.member_type eq '02'}">
		                        		귀농귀촌인
		                        	</c:if>
		                        </td>
		                        <td>
		                        	<a href="/admin/member/member_view.do?id=${result.id }&type=update"><c:out value="${result.id }"/></a>
		                        </td>
		                        <td>
									<c:out value="${result.name }"/>
		                        </td>
		                        <td>
									<c:out value="${result.region_name }"/>
		                        </td>
		                        <td>
									<button type="button" class="message form-line-btn defbtn white fr" onclick="javascript:memberDelete('${result.id }');">삭제</button>
		                        </td>
		                    </tr>
	                    </c:forEach>
		 				<c:if test="${fn:length(resultList) == 0}">
		                    <tr>
		                        <td colspan="7">등록된 회원이 없습니다.</td>
		                    </tr>
		 				</c:if>
	                </tbody>
	            </table>
	            
	            <div class="tbl image"style="width:20%;float:right;text-align: center;">
	            [선호지역]
	            <table class="tbl image"style="width:100%;">
	            	<c:forEach var="regionStat" items="${regionStatisticsList}" varStatus="status">
	            		<tr>
	            			<td>
	            				<c:out value="${status.count }"/>.<c:out value="${regionStat.region_name }"/>
	            			</td>
	            			<td>
	            				<c:out value="${regionStat.region_cnt }"/>명
	            			</td>
	            		</tr>
	            	</c:forEach>
	            </table>
	            </div>
	            
	            <div class="clearfix">
	                <a href="/admin/member/member_view.do?type=insert" class="message form-line-btn defbtn pink fr">등록</a>
	            </div>
	            
	            <div class="pager">
			        <div class="tabletshow">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_reqList" />
			        </div>
	            </div>
	            
			    <form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="pageIndex" value="<c:out value='${AdminMemberVO.pageIndex}'/>"/> 
				        <div class="tbl-search">
				            <div class="subselect-jqList sel-basic">
				                <select name="searchCnd" id="searchCnd" title="검색 필터" class="wid100">
				                    <option value="all" <c:if test="${AdminMemberVO.searchCnd == 'all' || AdminMemberVO.searchCnd == ''}">selected="selected"</c:if>>전체</option>
				                    <option value="01" <c:if test="${AdminMemberVO.searchCnd == '01'}">selected="selected"</c:if>>아이디</option>
				                    <option value="02" <c:if test="${AdminMemberVO.searchCnd == '02'}">selected="selected"</c:if>>이름</option>
				                </select>
				            </div>
				            <input type="text" id="searchWrd" name="searchWrd" class="form-inputbox" value="${AdminMemberVO.searchWrd}">
				           	<button type="button" class="tbl-search-btn" onclick="javascript:memberListGo('1');"><span class="screen_out">검색</span></button>
				            
				        </div>
			        </form>

			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



