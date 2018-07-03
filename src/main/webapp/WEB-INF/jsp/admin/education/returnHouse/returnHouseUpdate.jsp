<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%	
	// update or insert 구분값
	String s_type = request.getParameter("type");
%>
		
		<script type="text/javascript">

			function returnHouseUpdate(){
				if($("#education_name").val() == ""){
					alert("제목을 입력해 주세요.");			
					$("#education_name").focus();
					return;
				}
				if($("#education_start").val() == ""){
					alert("시작일을 선택해 주세요.");			
					$("#start_date").focus();
					return;
				}
				if($("#education_end").val() == ""){
					alert("종료일을 선택해 주세요.");			
					$("#end_date").focus();
					return;
				}
				if($("#education_start").val() > $("#education_end").val()){
					alert("종료일은 시작일 이전이  될 수 없습니다.");
					$("#education_end").focus();
					return;
				}
				var url="/admin/education/returnHouseUpdate.do";
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				
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
							alert("수정했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/education/selectReturnHouse.do'/>";
							document.frm.submit();
						}else{
							alert("수정하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
				
				
			}
			function returnHouseDelete(){
				

				var url="/admin/education/returnHouseDelete.do";
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				
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
							alert("수정했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/education/selectReturnHouse.do'/>";
							document.frm.submit();
						}else{
							alert("수정하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
				
				
				/* document.frm.action = "<c:url value='/admin/education/returnHouseDelete.do'/>";
				document.frm.submit(); */
			}
			/* function info_delete(){
				if(confirm("정말로 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/homep/info_delete.do'/>";
					document.frm.submit();
				}
			}

			function info_file_delete(){
				if(confirm("정말로 첨부파일을 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/homep/info_file_delete.do'/>";
					document.frm.submit();
				}
			} */
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">교육 관리</a></li>
			        <li class="active">귀농인의 집</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">귀농인의 집</h3>
			
			<div class="contents">
				
				
	            <form action="#" name="frm" id="frm" method="post" enctype="multipart/form-data">
	            	<input type="hidden" id="writer" name="writer" value="<c:out value='${curAdmin.name }'/>"/>
	            	<input type="hidden" id="education_no" name="education_no" value="<c:out value='${result.education_no }'/>"/>
	            	<div class="newfran-firbox sel-author clearfix">
			            <div class="search-box fl sel-basic">
			            	<select name="house_code" id="house_code" class="fl">
						    	<option value="01" <c:if test="${result.house_code eq '01'}">selected="selected"</c:if>>귀농인의 집1</option>
			                    <option value="02" <c:if test="${result.house_code eq '02'}">selected="selected"</c:if>>귀농인의 집2</option>
						    </select>
						 </div>
					</div>    
	                <fieldset>
	                    <legend class="screen_out">귀농인의 집</legend>
	                    <table class="tbl no-thead write">
	                        <caption>귀농인의 집 입력</caption>
	                        <colgroup>
	                            <col style="width:25%;"/>
	                            <col style="width:55%;"/>
	                            <col style="width:20%;"/>
	                        </colgroup>
	                        <tbody>
	                        <tr>
	                            <th><label for="title">교육명</label></th>
	                            <td colspan="2"><input type="text" id="education_name" name="education_name" class="form-inputbox" value="<c:out value='${result.education_name }'/>"/></td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육기간</label></th>
	                            <td colspan="2">
	                                <div class="form-input" style="width:45%;float:left;">
	                                    <input type="text" id="education_start" name="education_start" class="form-inputbox white js-datepicker" value="<c:out value='${result.education_start }'/>">
	                                </div>
	                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                <div class="form-input" style="width:45%;float:right;">
	                                    <input type="text" id="education_end" name="education_end" class="form-inputbox white js-datepicker" value="<c:out value='${result.education_end }'/>">
	                                </div>
	                            </td>
	                        </tr>
	                        <!-- <tr>
	                            <th><label for="end_date">종료일</label></th>
	                            <td colspan="2">
	                                <div class="form-input">
	                                    <input type="text" id="end_date" name="end_date" class="form-inputbox white js-datepicker" value="">
	                                </div>
	                            </td>
	                        </tr> -->
	                        </tbody>
	                    </table>
	                    <div class="defbtn-wrap">
	                    	<button type="button" class="defbtn pink" onclick="javascript:returnHouseUpdate()">수정</button>
	                    	<button type="button" class="defbtn white" onclick="javascript:returnHouseDelete()">삭제</button>
		                    <button type="button" class="defbtn pink" onclick="javascript:history.back();">취소</button>
	                    </div>
	                </fieldset>

	            </form>
	            
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



