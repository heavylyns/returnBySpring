<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%	
	// update or insert 구분값
	String s_type = request.getParameter("type");
%>
		
		<script type="text/javascript">
			console.log("<%=s_type%>");
			
			$(document).ready(function() {
				
			});

			function admin_agree(v_type){
				if($("#id").val() == ""){
					alert("아이디를 입력해 주세요.");			
					$("#id").focus();
					return;
				}
				if($("#password").val() == ""){
					alert("비밀번호를 입력해 주세요.");			
					$("#password").focus();
					return;
				}
				if($("#name").val() == ""){
					alert("이름을 입력해 주세요.");			
					$("#name").focus();
					return;
				}
				if($("#organ_name").val() == ""){
					alert("기관명을 입력해 주세요.");			
					$("#organ_name").focus();
					return;
				}
				if($("#depart_name").val() == ""){
					alert("부서를 입력해 주세요.");			
					$("#depart_name").focus();
					return;
				}
				if($("#phone_no1").val() == "" || $("#phone_no2").val() == "" || $("#phone_no3").val() == ""){
					alert("전화번호를 입력해 주세요.");
					$("#phone_no1").focus();
					return;
				}
				if(v_type == "insert"){
					document.frm.action = "<c:url value='/admin/homep/admin_join.do'/>";
				}else{
					document.frm.action = "<c:url value='/admin/homep/admin_update.do'/>";
				}
				document.frm.submit();
			}

			// maxlength 체크
			function maxLengthCheck(object){
				if (object.value.length > object.maxLength){
					object.value = object.value.slice(0, object.maxLength);
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
			
				
	            <form action="#" name="frm" id="frm" method="post">
	            <input type="hidden" id="roleId" name="roleId" value="2"/>
	                <fieldset>
	                    <legend class="tbl-tit">
	                    	<%if(s_type.equals("update")){ %>
								부관리자 관리
							<%}else{ %>
								부관리자 등록
							<%} %>
						</legend>
	                    <table class="tbl no-thead write">
	                        <caption>관리자 등록 테이블</caption>
	                        <colgroup>
	                            <col style="width:25%;"/>
	                            <col style="width:75%;"/>
	                        </colgroup>
	                        <tbody>
	                        <tr>
	                            <th><label for="id">아이디</label></th>
	                            <td>
	                    			<%if(s_type.equals("update")){ %>
	                            		<input type="text" id="id" name="id" class="form-inputbox" value="${homep_adminVO.id }" readonly="readonly"/>
	                            	<%}else{ %>
	                            		<input type="text" id="id" name="id" class="form-inputbox"/>
	                            	<%} %>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="password">비밀번호</label></th>
	                            <td><input type="text" id="password" name="password" class="form-inputbox" value="${homep_adminVO.password }"/></td>
	                        </tr>
	                        <tr>
	                            <th><label for="name">이름</label></th>
	                            <td><input type="text" id="name" name="name" class="form-inputbox" value="${homep_adminVO.name }"/></td>
	                        </tr>
	                        <%-- <tr>
	                            <th><label for="organ_name">기관명</label></th>
	                            <td><input type="text" id="organ_name" name="organ_name" class="form-inputbox" value="${homep_adminVO.organ_name }"/></td>
	                        </tr> --%>
	                        <tr>
	                            <th><label for="depart_name">부서</label></th>
	                            <td><input type="text" id="depart_name" name="depart_name" class="form-inputbox" value="${homep_adminVO.depart_name }"/></td>
	                        </tr>
	                        <tr>
	                            <th><label for="phone_no1">전화번호</label></th>
	                            <td>
	                                <div class="form-input col3">
	                                    <input type="number" id="phone_no1" name="phone_no1" class="form-inputbox" value="${homep_adminVO.phone_no1 }" maxlength="4" oninput="maxLengthCheck(this)">
	                                    <span class="input-hyphen">-</span>
	                                    <input type="number" id="phone_no2" name="phone_no2" class="form-inputbox" value="${homep_adminVO.phone_no2 }" maxlength="4" oninput="maxLengthCheck(this)">
	                                    <span class="input-hyphen">-</span>
	                                    <input type="number" id="phone_no3" name="phone_no3" class="form-inputbox" value="${homep_adminVO.phone_no3 }" maxlength="4" oninput="maxLengthCheck(this)">
	                                </div>
	                            </td>
	                        </tr>
	                        <%-- <tr>
	                            <th><label for="roleId">권한</label></th>
	                            <td class="sel-basic">
	                                <select name="roleId" id="roleId" class="wid100" title="권한 관리자 선택">
	                                    <option value="1" <c:if test="${homep_adminVO.roleId eq '1' }">selected="selected"</c:if>>전체관리자</option>
	                                    <option value="2" <c:if test="${homep_adminVO.roleId eq '2' }">selected="selected"</c:if>>부관리자</option>
	                                </select>
	                            </td>
	                        </tr> --%>
	                        </tbody>
	                    </table>
	                    <div class="defbtn-wrap">
	                    	<%if(s_type.equals("update")){ %>
	                        	<button type="button" class="defbtn pink" onclick="javascript:admin_agree('update')">수정</button>
	                        <%}else{ %>
	                        	<button type="button" class="defbtn pink" onclick="javascript:admin_agree('insert')">등록</button>
	                        <%} %>
	                        <button type="button" class="defbtn white" onclick="javascript:history.back();">취소</button>
	                    </div>
	                </fieldset>
	            </form>
	            
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



