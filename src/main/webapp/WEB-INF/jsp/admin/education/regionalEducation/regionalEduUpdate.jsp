<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<%
	String s_bbsId2 = "";	// 게시판관리 > 게시판ID
	if(request.getParameter("bbsId") != null && request.getParameter("bbsId") != ""){
		s_bbsId2 = request.getParameter("bbsId");
	}
%>

		
		<script type="text/javascript">
		var editor_object = [];
		$(document).ready(function() {
			
		     
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: editor_object,
		        elPlaceHolder: "contents",
		        sSkinURI: "/js/smarteditor/SmartEditor2Skin.html", 
		        htParams : {
		            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseToolbar : true,             
		            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseVerticalResizer : true,     
		            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseModeChanger : true, 
		        }
		    });
		    $("#inp-file").on('change', function(){
				var fileCnt = $("#fileListCnt").val();
				if(fileCnt >= 3){
					alert("파일 업로드 수는 3개까지 입니다.");
					$("#inp-file").val('');
					return false;
				}
		    });
		});
			function onloading() {
				if ("<c:out value='${msg}'/>" != "") {
					alert("<c:out value='${msg}'/>");
				}
			}
		
			function fn_egov_select_noticeList(pageNo) {
				document.frm.pageIndex.value = pageNo;
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}
		
			function fn_egov_delete_notice() {
				/* 
				if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
					alert('등록시 사용한 패스워드를 입력해 주세요.');
					document.frm.password.focus();
					return;
				}
				 */
				if (confirm('<spring:message code="common.delete.msg" />')) {
					
					document.frm.action = "<c:url value='/admin/board/deleteBoardArticle.do'/>";
					document.frm.submit();
				}
			}
		
			
			function regionalEduListGo(pageNo) {
				document.frm.pageIndex.value = pageNo;
				document.frm.region_code.value = null;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
				document.frm.submit();
			}
			/* function regionalEduArticleGo(boardNo, boardCode){
				document.subForm.boardNo.value = boardNo;
				document.subForm.boardCode.value = boardCode;
				//document.subForm.pageIndex.value = pageNo;
				document.subForm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
				document.subForm.submit();
			} */
			function regionalEduUpdate(){
				editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				var title = $("#r_edu_title").val();
				var contents = $("#contents").val();
				if(title == "" || typeof title == "undefined"){
					alert("제목을 입력해 주세요");
					$("#title").focus();
					return false
				}
				if( contents == ""  || contents == null || contents == '&nbsp;' || contents == '<p>&nbsp;</p>'){
					alert("내용을 입력해 주세요");
					$("#contents").focus();
					return false
				}
				if($("#r_edu_start").val() == ""){
					alert("시작일을 선택해 주세요.");			
					$("#r_edu_start").focus();
					return;
				}
				if($("#r_edu_end").val() == ""){
					alert("종료일을 선택해 주세요.");			
					$("#r_edu_end").focus();
					return;
				}
				if($("#r_edu_start").val() > $("#r_edu_end").val()){
					alert("종료일은 시작일 이전이  될 수 없습니다.");
					$("#r_edu_end").focus();
					return;
				}
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				$.ajax({
					type : "post",
					cache : false,
					url : "/admin/education/regionalEduUpdate.do",
					data: formData,
					async   : false,
					processData: false,
					contentType : false,
					success : function(data) {
						if (data.count >= 1) {
							alert("수정 했습니다.");
							document.frm.region_code.value = null;
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/education/selectRegionalEduArticle.do'/>";
							document.frm.submit();
						}else{
							alert("수정하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
				
				/* document.frm.action = "<c:url value='/admin/education/regionalEduUpdate.do'/>";
				document.frm.submit(); */
			}
			
		</script>
		
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <!-- <li><a href="#lnk">게시판 관리</a></li> -->
			        <li class="active">시군별 교육</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">시군별 교육</h3>
			<div class="contents">
				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" id="r_edu_no" name="r_edu_no" value='${result.r_edu_no }'/>
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					
					
			        <fieldset>
			            <legend class="screen_out">시군별 교육 수정</legend>
			            <table class="tbl tc no-thead write">
			                <caption>시군별 교육 수정</caption>
			                <colgroup>
			                     <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th><label for="inp-title">제목</label></th>
			                    <td class="tl" >
			                    	<%-- <input type="text" id="inp-title" name="inp-title" class="form-inputbox" value="${result.nttSj}"/> --%>
			                    	<input type="text" id="r_edu_title" name="r_edu_title" value="<c:out value='${result.r_edu_title}'/>"/>
			                    </td>
			                    <td class="tl" colspan="2">
			                    	<c:if test="${result.display_yn eq 'Y' }">
			                    		<input type="checkbox" id="display_check" name="display_check" checked="checked"/>이달의 교육에 노출
			                    	</c:if>
			                    	<c:if test="${result.display_yn ne 'Y' }">
			                    		<input type="checkbox" id="display_check" name="display_check"/>이달의 교육에 노출
			                    	</c:if>
			                    </td>
			                </tr>
			                <tr>
	                            <th><label for="start_date">교육기간</label></th>
	                            <td colspan="3">
	                                <div class="form-input" style="width:45%;float:left;">
	                                    <input type="text" id="r_edu_start" name="r_edu_start" class="form-inputbox white js-datepicker" value=" <c:out value="${result.r_edu_start }"/>">
	                                </div>
	                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                <div class="form-input" style="width:45%;float:right;">
	                                    <input type="text" id="r_edu_end" name="r_edu_end" class="form-inputbox white js-datepicker" value=" <c:out value="${result.r_edu_end }"/>">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육장소</label></th>
	                            <td class="tl" colspan="3">
	                                <input type="text" id="r_edu_place" name="r_edu_place" value="<c:out value='${result.r_edu_place }'/>"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">전화번호</label></th>
	                            <td class="tl" colspan="3">
	                                <input type="text" id="r_edu_tel" name="r_edu_tel" value="<c:out value='${result.r_edu_tel }'/>"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육내용</label></th>
	                            <td class="tl" colspan="3">
	                                <textarea name="r_edu_summary" id="r_edu_summary" cols="30" rows="10" class="wid100 inptxt"><c:out value="${result.r_edu_summary }"/></textarea>
	                            </td>
	                        </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value="${result.name}"/>
			                    	<input type="hidden" id="writer" name="writer" value="<c:out value='${curAdmin.id}'/>"/>
			                    </td>
			                    <th><label for="inp-title">지역</label></th>
			                    <td class="tl">
			                    	<div class="subselect-jqList sel-basic" ">
				                    	<select id="region_code" name="region_code">
					                    	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					                    		<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test="${regionResult.region_code eq result.region_code }">selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
					                    	</c:forEach>
				                    	</select>
			                    	</div>
			                    </td>
			                </tr>
			                
			                <tr>
			                    <th><label for="inp-file">첨부파일목록</label></th>
			                    <td class="tl">
						   	        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl2"  value="/admin/education/regionalEduUpdatePage.do" />
										<c:param name="returnUrl" value="/admin/education/regionalEduUpdatePage.do"/>
									</c:import>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일</label></th>
			                    <td class="tl">
			                    	<input type="file" id="inp-file" name="inp-file" class="wid100"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl" colspan="3">
			                    	<textarea name="r_edu_contents" id="contents" cols="30" rows="15" class="wid100 inptxt"><c:out value="${result.r_edu_contents }"/></textarea> 
			                    	
			                    </td>
			                </tr>
			                </tbody>
			            </table>
			            <div class="defbtn-wrap">
				        	
					                <button type="button" class="defbtn white" onclick="javascript:regionalEduUpdate();">수정</button>
					                
			                <button type="button" class="defbtn white" onclick="javascript:regionalEduListGo('${searchVO.pageIndex}');;">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					