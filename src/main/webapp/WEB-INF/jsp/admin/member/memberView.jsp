<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%	
	// update or insert 구분값
	String s_type = request.getParameter("type");
%>
		
		<script type="text/javascript">

			function member_save(v_type){
				if($("#type").val() != "update"){
					if($("#id").val() == ""){
						alert("아이디를 입력해 주세요.");			
						$("#id").focus();
						return;
					}
					if($("#idCheck").val() == ""){
						alert("아이디를 확인해 주세요");
						return false;
					}
					if($("#idCheck").val() == "N"){
						alert("사용 가능한 아이디를 입력해 주세요");
						return false;
					}
					if($("#idCheck").val() != $("#id").val()){
						alert("아이디를 확인해 주세요");
						return false;
					}
				}
				
				
				if($("#password").val() == ""){
					alert("비밀번호를 입력해 주세요.");			
					$("#password").focus();
					return;
				}
				if($("#rePassword").val() == ""){
					alert("비밀번호재입력을 입력해 주세요.");			
					$("#rePassword").focus();
					return;
				}
				if($("#password").val() != $("#rePassword").val()){
					alert("비밀번호와 비밀번호 재입력은 같아야 합니다.");			
					$("#password").focus();
					return;
				}
				if($("#name").val() == ""){
					alert("이름을 입력해 주세요.");			
					$("#name").focus();
					return;
				}
				if($("#regionCode").val() == ""){
					alert("선호지역을 선택해 주세요.");			
					$("#regionCode").focus();
					return;
				}
				var url = "";
				if(v_type == "insert"){
					url = '/admin/member/member_insert.do';
				}else{
					url = '/admin/member/member_update.do';
				}
				
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				//document.frm.submit();
				$.ajax({
					type : "post",
					cache : false,
					url : url,
					data: formData,
					async   : false,
					processData: false,
					contentType : false,
					success : function(data) {
						if (data.count >= 1) {
							alert("등록했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/member/member_list.do'/>";
							document.frm.submit();
						}else{
							alert("등록하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
			}

			

			function idCheckFnc(){
				var id = $("#id").val();
				if(id == ""){
					alert("아이드를 입력해 주세요");
					return false;
				}
				var param = "id="+id;
				var url = '/admin/member/idCheck.do';
				$.ajax({
					url : url
						, dataType : 'json'
						, data : param
						, contentType: "application/json; charset=utf-8"
						, async : false
					    , success : function(data) {
						if (data.count >= 1) {
							alert("해당 아이디는 이미 등로된 아이디 입니다.");
							$("#idCheck").val("N");
							$("#id").val("");
							return false;
						}else{
							alert("등록 가능한 아이디 입니다.")
							$("#idCheck").val(id);
							
							return false;
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
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
			
				
	            <form action="#" name="frm" id="frm" method="post" enctype="multipart/form-data">
	            	<input type="hidden" id="idCheck" name="idCheck" value=""/>
	                <input type="hidden" id="type" name="type" value="${type }"/>
	                <fieldset>
	                    <legend class="screen_out">인포존 관리</legend>
	                    <table class="tbl no-thead write">
	                        <caption>인포존 입력표</caption>
	                        <colgroup>
	                            <col style="width:45%;"/>
	                            <col style="width:55%;"/>
	                        </colgroup>
	                        <tbody>
	                        <tr>
	                            <th><label for="title">아이디(E-Mail)</label></th>
	                            <td>
	                            	<%if(s_type.equals("update")){ %>
	                            		<input type="text" id="idDisabled" name="idDisabled" class="form-inputbox" style="width:40%" value="${result.id }" disabled="disabled"/>
	                            		<input type="hidden" id="id" name="id" class="form-inputbox" style="width:40%" value="${result.id }"/>
	                            	<%}else{ %>
	                            		<input type="text" id="id" name="id" class="form-inputbox" style="width:40%" value="${result.id }"/><button type="button" class="message form-line-btn defbtn pink fr" onclick="javascript:idCheckFnc();">ID Check</button>
	                            	<%} %>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="password">비밀번호</label></th>
	                            <td>
	                            	<input type="password" id="password" name="password" value="${result.password }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="password">비밀번호 재입력</label></th>
	                            <td>
	                            	<input type="password" id="rePassword" name="rePassword" value="${result.password }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="link">이름</label></th>
	                            <td><input type="text" id="name" name="name" class="form-inputbox" value="${result.name }"/></td>
	                        </tr>
	                       
	                        <tr>
	                            <th><label for="contents">선호지역</label></th>
	                            <td>
	                            	<div class="subselect-jqList sel-basic">
		                            	<select id="regionCode" name="regionCode">
						            		<option label="" value="" <c:if test="${result.region_code == ''}">selected="selected"</c:if>>전체</option>
								        	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
								            	<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test="${result.region_code == regionResult.region_code}">selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
								            </c:forEach>
							            </select>
						            </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>귀농귀촌 여부</th>
	                            <td>
	                                <div class="clearfix wid100 sel-table">
	                                    
	                                        <input type="radio" id="member_type" name="member_type" value="01" <c:if test="${result.member_type eq '01' || result.member_type eq null}">checked</c:if>/>
	                                        <label for="sel-new">나는 귀농귀촌을 준비 중입니다.</label>
	                                    	<br/>
	                                        <input type="radio" id="member_type" name="member_type" value="02" <c:if test="${result.member_type eq '02' }">checked</c:if>/>
	                                        <label for="sel-self">나는 이미 귀농귀촌을 했습니다.</label>
	                                    
	                                </div>
	                            </td>
	                        </tr>
	                       
	                        </tbody>
	                    </table>
	                    <div class="defbtn-wrap">
	                    	<%if(s_type.equals("update")){ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:member_save('update')">수정</button>
		                        <button type="button" class="defbtn white" onclick="javascript:history.back();">취소</button>
	                        <%}else{ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:member_save('insert')">등록</button>
		                        <button type="button" class="defbtn white" onclick="javascript:history.back();">취소</button>
	                        <%} %>
	                    </div>
	                </fieldset>

	            </form>
	            
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



