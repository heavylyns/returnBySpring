<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
				$("#id").change(function(){
					var admin_id = $(this).val()
					location.href = "/admin/homep/homep_author.do?id=" + admin_id;
				});
				
			});
			
			function author_agree(){
				var checkMenus = "";
				var count = $("#menu_id:checked").length;
				if (count <= 0) {
					alert("권한을 하나이상 선택하세요.");
					$("#menu_id:first").focus();
					return;
				}
				var i = 1;
				$("#menu_id:checked").each(function(){
					if (i >= count)
						checkMenus += $(this).val();
					else
						checkMenus += $(this).val() + ":";
					i++;
				})
				$("#menuItems").val(checkMenus);
				$("#admin_form").submit();
			}
			function valueCheckFnc(checkVal){
				
				$("input:checkbox[name=menu_id]").each(function(idx, val){
					var sValue = val.value;
					if(val.value == checkVal){
						if(val.value.length == 1){
							if(val.checked){
								$("input:checkbox[name=menu_id]").each(function(i, eachVal){
									if(sValue == eachVal.value.substring(0, 1)){
										eachVal.checked = true;
									}
								});
							}else{
								$("input:checkbox[name=menu_id]").each(function(i, eachVal){
									if(sValue == eachVal.value.substring(0, 1)){
										eachVal.checked = false;
									}
								});
							}
						}else if(val.value.length == 2){
							if(val.checked){
								$("input:checkbox[name=menu_id]").each(function(j, v){
									if(v.value.length == 3){
										if(v.value.substring(0,2) == val.value){
											if(!v.checked){
												v.checked = true;
											}
										}
									}else if(v.value == val.value.substring(0,1)){
										if(!v.checked){
											v.checked = true;	
										}	
									}
								});
							}else{
								var checkedVal;
								var checkedVal2;
								$("input:checkbox[name=menu_id]").each(function(i, eachVal){
									if(eachVal.value.length == 2){
										if(sValue.substring(0,1) == eachVal.value.substring(0, 1)){
											checkedVal = eachVal.checked;
											if(checkedVal){
												return false;
											}
										}
									}
								});
								if(!checkedVal){
									$("input:checkbox[name=menu_id]").each(function(j, v){
										if(v.value == val.value.substring(0,1)){
											v.checked = false;	
										}
									});
									
								}
								
								$("input:checkbox[name=menu_id]").each(function(jj, vv){
									if(vv.value.length == 3){
										if(vv.value.substring(0,2) == val.value){
											vv.checked = false;
										}	
									}																				
								});
								
							}
						}else if(val.value.length == 3){
							if(val.checked){
								$("input:checkbox[name=menu_id]").each(function(j, v){
									if(v.value == val.value.substring(0,1)){
										if(!v.checked){
											v.checked = true;	
										}	
									}
									if(v.value == val.value.substring(0,2)){
										if(!v.checked){
											v.checked = true;	
										}	
									}
								});
							}else{
								var checkedVal1;
								var checkedVal2;
								$("input:checkbox[name=menu_id]").each(function(i, eachVal){
									if(eachVal.value.length == 3){
										if(sValue.substring(0,2) == eachVal.value.substring(0,2)){
											checkedVal1 = eachVal.checked;
											if(checkedVal1){
												return false;
											}
										}
									}
								});
								if(!checkedVal1){
									$("input:checkbox[name=menu_id]").each(function(j, v){
										if(v.value.length == 2){
											if(v.value == val.value.substring(0, 2)){
												if(v.checked){
													v.checked = false;
													
													$("input:checkbox[name=menu_id]").each(function(jj, vv){
														if(vv.value.length == 2){
															if(sValue.substring(0,1) == vv.value.substring(0, 1)){
																checkedVal2 = vv.checked;
																if(checkedVal2){
																	return false;
																}
															}
														}
													});
													if(!checkedVal2){
														$("input:checkbox[name=menu_id]").each(function(jjj, vvv){
															if(vvv.value == val.value.substring(0,1)){
																vvv.checked = false;	
															}
														});
														
													}
												}
											}
										}
									});
								}
								/* $("input:checkbox[name=menu_id]").each(function(i, eachVal){
									if(eachVal.value.length == 2){
										if(sValue.substring(0,1) == eachVal.value.substring(0, 1)){
											checkedVal = eachVal.checked;
											if(checkedVal){
												return false;
											}
										}
									}else if(eachVal.value.length == 3){
										if(sValue.substring(0,2) == eachVal.value.substring(0, 2)){
											checkedVal1 = eachVal.checked;
											if(checkedVal1){
												return false;
											}
										}
									}
								});
								if(!checkedVal){
									$("input:checkbox[name=menu_id]").each(function(j, v){
										if(v.value == val.value.substring(0,1)){
											v.checked = false;	
										}
									});
								}
								if(!checkedVal1){
									$("input:checkbox[name=menu_id]").each(function(jj, vv){
										if(vv.value == val.value.substring(0,2)){
											vv.checked = false;	
										}
									});
								} */
							}
						}
					}
				});
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">홈페이지 관리</a></li>
			        <li class="active">권한 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">권한 관리</h3>
			
			<div class="contents">
			
				
	            <form name="admin_form" id="admin_form" method="post" action="/admin/homep/author_agree.do">
					<input type="hidden" name="menuItems" id="menuItems" value="">
	            
			        <div class="newfran-firbox sel-author clearfix">
			            <div class="search-box fl sel-basic">
			                <label for="sel-admin" class="fl">관리자 선택</label>
			                <select name="id" id="id" class="fl">
		 						<c:forEach var="result" items="${resultList}" varStatus="status">
			                    	<option value="${result.id }" <c:if test="${result.id eq admin_id}">selected="selected"</c:if>>${result.id }</option>
			                    </c:forEach>
			                </select>
			            </div>
			            <div class="btn-wrap fl tr">
			                <button type="button" class="defbtn navy all-chk">전체선택</button>
			                <button type="button" class="defbtn navy all-nchk">전체해제</button>
			                <button type="button" class="defbtn navy" onclick="javascript:author_agree();">적용</button>
			            </div>
			        </div>
			        <table class="tbl author-table">
			            <caption>권한관리 표</caption>  
			            <colgroup>
			                <col style="width:10%"/>
			                <col style="width:30%"/>
			                <col style="width:30%"/>
			                <col style="width:30%"/>
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>선택</th>
			                    <th>대메뉴</th>
			                    <th>중메뉴</th>
			                    <th>소메뉴</th>
			                </tr>
			            </thead>
			            <tbody class="tc">
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="1"<c:if test="${fn:contains(menuIds, '[1]')}"> checked="checked"</c:if> /></td>
			                    <td>교육 관리</td>
			                    <td></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="11"<c:if test="${fn:contains(menuIds, '[11]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>귀농인의 집</td>
			                    <td></td>
			                </tr>
			                <%-- <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" value="12"<c:if test="${fn:contains(menuIds, '[12]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>이달의 교육</td>
			                </tr> --%>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="12"<c:if test="${fn:contains(menuIds, '[12]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>시군별 교육</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="2"<c:if test="${fn:contains(menuIds, '[2]')}"> checked="checked"</c:if> /></td>
			                    <td>홈페이지 관리</td>
			                    <td></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="21"<c:if test="${fn:contains(menuIds, '[21]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>관리자 관리</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="22"<c:if test="${fn:contains(menuIds, '[22]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>권한 관리</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="23"<c:if test="${fn:contains(menuIds, '[23]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>인포존 관리</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="24"<c:if test="${fn:contains(menuIds, '[24]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>팝업 관리</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="3"<c:if test="${fn:contains(menuIds, '[3]')}"> checked="checked"</c:if> /></td>
			                    <td>게시판 관리</td>
			                    <td></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="31"<c:if test="${fn:contains(menuIds, '[31]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>자료실</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="311"<c:if test="${fn:contains(menuIds, '[311]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자료실 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="312"<c:if test="${fn:contains(menuIds, '[312]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자료실 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="313"<c:if test="${fn:contains(menuIds, '[313]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자료실 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="32"<c:if test="${fn:contains(menuIds, '[32]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>온라인상담안내</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="321"<c:if test="${fn:contains(menuIds, '[321]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>온라인상담안내 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="322"<c:if test="${fn:contains(menuIds, '[322]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>온라인상담안내 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="323"<c:if test="${fn:contains(menuIds, '[323]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>온라인상담안내 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="33"<c:if test="${fn:contains(menuIds, '[33]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>귀농귀촌 사례</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="331"<c:if test="${fn:contains(menuIds, '[331]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>귀농귀촌 사례 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="332"<c:if test="${fn:contains(menuIds, '[332]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>귀농귀촌 사례 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="333"<c:if test="${fn:contains(menuIds, '[333]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>귀농귀촌 사례 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="34"<c:if test="${fn:contains(menuIds, '[34]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>나의 귀농귀촌 이야기</td>
			                    <td></td>
			                </tr> 
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="341"<c:if test="${fn:contains(menuIds, '[341]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>나의 귀농귀촌 이야기 - 읽기</td>
			                </tr> 
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="342"<c:if test="${fn:contains(menuIds, '[342]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>나의 귀농귀촌 이야기 - 쓰기</td>
			                </tr> 
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="343"<c:if test="${fn:contains(menuIds, '[343]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>나의 귀농귀촌 이야기 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="35"<c:if test="${fn:contains(menuIds, '[35]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>멘토에게 물어봐</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="351"<c:if test="${fn:contains(menuIds, '[351]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>멘토에게 물어봐 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="352"<c:if test="${fn:contains(menuIds, '[352]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>멘토에게 물어봐 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="353"<c:if test="${fn:contains(menuIds, '[353]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>멘토에게 물어봐 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="36"<c:if test="${fn:contains(menuIds, '[36]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>강원귀농귀촌뉴스</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="361"<c:if test="${fn:contains(menuIds, '[361]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>강원귀농귀촌뉴스 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="362"<c:if test="${fn:contains(menuIds, '[362]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>강원귀농귀촌뉴스 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="363"<c:if test="${fn:contains(menuIds, '[363]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>강원귀농귀촌뉴스 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="37"<c:if test="${fn:contains(menuIds, '[37]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>갤러리</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="371"<c:if test="${fn:contains(menuIds, '[371]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>갤러리 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="372"<c:if test="${fn:contains(menuIds, '[372]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>갤러리 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="373"<c:if test="${fn:contains(menuIds, '[373]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>갤러리 - 수정/삭제</td>
			                </tr>
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="38"<c:if test="${fn:contains(menuIds, '[38]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td>자유게시판</td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="381"<c:if test="${fn:contains(menuIds, '[381]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자유게시판 - 읽기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="382"<c:if test="${fn:contains(menuIds, '[382]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자유게시판 - 쓰기</td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="383"<c:if test="${fn:contains(menuIds, '[383]')}"> checked="checked"</c:if> /></td>
			                    <td></td>
			                    <td></td>
			                    <td>자유게시판 - 수정/삭제</td>
			                </tr>
			                
			                
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="4"<c:if test="${fn:contains(menuIds, '[4]')}"> checked="checked"</c:if> /></td>
			                    <td>웹진관리</td>
			                    <td></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td><input type="checkbox" name="menu_id" id="menu_id" onchange="javascript:valueCheckFnc(this.value);" value="5"<c:if test="${fn:contains(menuIds, '[5]')}"> checked="checked"</c:if> /></td>
			                    <td>회원관리</td>
			                    <td></td>
			                    <td></td>
			                </tr>
			                
			            </tbody>
			        </table>
			        
				</form>

			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



