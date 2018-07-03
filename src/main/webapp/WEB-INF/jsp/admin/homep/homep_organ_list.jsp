<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
			});
			
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">홈페이지 관리</a></li>
			        <li class="active">관련기관 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">관련기관 관리</h3>
			
			<div class="contents">
			
				
				<table class="tbl">
				    <caption>관련기관 관리 표</caption>
				<colgroup>
					<col style="width:10%;"/>
					<col style="width:50%;"/>
					<col style="width:10%;"/>
					<col style="width:30%;"/>
				</colgroup>
				     <thead>
				         <tr>
				             <th>No</th>
				             <th>기관명</th>
				             <th>출력구분</th>
				             <th>등록일</th>
				         </tr>
				     </thead>
				     <tbody class="tc">
				     	
						<c:forEach var="result" items="${resultList}" varStatus="status">
					        <tr>
					            <td>${result.rownum }</td>
					            <td><a href="/admin/homep/homep_organ_view.do?popup_no=${result.popup_no }&type=update">${result.title }</a></td>
					            <td>${result.view_flag }</td>
					            <td>${result.reg_date }</td>
					        </tr>
						</c:forEach>
		 				<c:if test="${fn:length(resultList) == 0}">
		                    <tr>
		                        <td colspan="4">등록된 관련기관이 없습니다.</td>
		                    </tr>
		 				</c:if>
				     </tbody>
				</table>
				<div class="clearfix">
				    <a href="/admin/homep/homep_organ_view.do?type=insert" class="message form-line-btn defbtn pink fr">등록</a>
				</div>
				
				<div class="pager">
			        <div class="tabletshow">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_reqList" />
			        </div>
				</div>
				
				<div class="tbl-search">
				    <div class="subselect-jqList sel-basic">
				        <select name="sel-search" id="sel-search" title="검색 필터" class="wid100">
				            <option value="">전체</option>
				            <option value="">아이디</option>
				            <option value="">이름</option>
				            <option value="">기관명</option>
				        </select>
				    </div>
				    <input type="text" id="inp-password" name="inp-password" class="form-inputbox">
				    <button type="button" class="tbl-search-btn"><span class="screen_out">검색</span></button>
				</div>


			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



