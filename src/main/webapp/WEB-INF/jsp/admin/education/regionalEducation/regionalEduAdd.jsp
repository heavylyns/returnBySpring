<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js'/>" ></script>

<%
	String s_bbsId2 = "";	// 게시판관리 > 게시판ID
	if(request.getParameter("bbsId") != null && request.getParameter("bbsId") != ""){
		s_bbsId2 = request.getParameter("bbsId");
	}
%>

		
		<script type="text/javascript">
		var editor_object = [];
		$(document).ready(function() {
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), 3 );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
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
		    
		    $("#fileUploader").on('change', function(){
		    	var thumbext = document.getElementById('fileUploader').value; //파일을 추가한 input 박스의 값
				thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
				if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp"){ //확장자를 확인합니다.
					alert('썸네일은 이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
					$("#fileUploader").val('');
		    		return;

		    	}
		    });
		    
		});
			function onloading() {
				if ("<c:out value='${msg}'/>" != "") {
					alert("<c:out value='${msg}'/>");
				}
			}
		
			
			
			function regionalEduListGo(pageNo) {
				document.frm.pageIndex.value = pageNo;
				document.frm.region_code.value = null;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
				document.frm.submit();
			}
			
			function regionalEduInsert(){
				editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				
				var title = $("#r_edu_title").val();
				var contents = $("#contents").val();
				var file = $("#fileUploader").val();
				if(title == "" || typeof title == "undefined"){
					alert("제목을 입력해 주세요");
					$("#r_edu_title").focus();
					return false;
				}
				if( contents == ""  || contents == null || contents == '&nbsp;' || contents == '<p>&nbsp;</p>'){
					alert("내용을 입력해 주세요");
					$("#contents").focus();
					return false;
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
				if($("input:checkbox[id='display_check']").is(":checked")){
					$("#display_yn").val("Y");
				}else{
					$("#display_yn").val("N");
				}
				
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				
				$.ajax({
					type : "post",
					cache : false,
					url : "/admin/education/regionalEduInsert.do",
					data: formData,
					async   : false,
					processData: false,
					contentType : false,
					success : function(data) {
						if (data.count >= 1) {
							alert("등록했습니다.");
							document.frm.region_code.value = null;
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
							document.frm.submit();
						}else{
							alert("등록하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
				
				/* document.frm.action = "<c:url value='/admin/education/regionalEduInsert.do'/>";
				document.frm.submit(); */
			}
			
			function makeFileAttachment(){
				var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), 3 );
				multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
			
			}
		</script>
		
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">게시판 관리</a></li>
			        <li class="active">시군별 교육</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">시군별 교육</h3>
			<div class="contents">
				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" id="display_yn" name="display_yn"/>
					
			        <fieldset>
			            <legend class="screen_out">시군별 교육 입력</legend>
			            <table class="tbl tc no-thead write">
			                <caption>시군별 교육 입력</caption>
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
			                    	<input type="text" id="r_edu_title" name="r_edu_title"/>
			                    </td>
			                    <td class="tl" colspan="2">
			                    	<%-- <input type="text" id="inp-title" name="inp-title" class="form-inputbox" value="${result.nttSj}"/> --%>
			                    	<input type="checkbox" id="display_check" name="display_check"/>이달의 교육에 노출
			                    </td>
			                </tr>
			                <tr>
	                            <th><label for="start_date">교육기간</label></th>
	                            <td colspan="3">
	                                <div class="form-input" style="width:45%;float:left;">
	                                    <input type="text" id="r_edu_start" name="r_edu_start" class="form-inputbox white js-datepicker" value="">
	                                </div>
	                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                <div class="form-input" style="width:45%;float:right;">
	                                    <input type="text" id="r_edu_end" name="r_edu_end" class="form-inputbox white js-datepicker" value="">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육장소</label></th>
	                            <td class="tl" colspan="3">
	                                <input type="text" id="r_edu_place" name="r_edu_place"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">전화번호</label></th>
	                            <td class="tl" colspan="3">
	                                <input type="text" id="r_edu_tel" name="r_edu_tel"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육내용</label></th>
	                            <td class="tl" colspan="3">
	                                <textarea name="r_edu_summary" id="r_edu_summary" cols="30" rows="10" class="wid100 inptxt"></textarea>
	                            </td>
	                        </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value="${curAdmin.name }"/>
			                    	<input type="hidden" id="writer" name="writer" value="<c:out value='${curAdmin.id}'/>"/>
			                    </td>
			                    <th><label for="inp-title">지역</label></th>
			                    <td class="tl">
			                    	<div class="subselect-jqList sel-basic" ">
				                    	<select id="region_code" name="region_code">
					                    	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					                    		<option label="" value="<c:out value='${regionResult.region_code }'/>"><c:out value="${regionResult.region_name }"/></option>
					                    	</c:forEach>
				                    	</select>
			                    	</div>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일</label></th>
			                    <td class="tl" colspan="3">
				                 <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
									   	<tr>
									        <td><input name="file_1" id="egovComFileUploader" type="file" title="첨부파일입력"/></td>
									    </tr>
									    <tr>
									        <td>
									        	<div id="egovComFileList"></div>
									        </td>
									    </tr>
						   	        </table>
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl" colspan="3">
			                    	<textarea name="r_edu_contents" id="contents" cols="30" rows="15" class="wid100 inptxt"></textarea> 
			                    	
			                    </td>
			                </tr>
			              
			                </tbody>
			            </table>
			
			
   	        
   	        
			            <div class="defbtn-wrap">
				        	<%-- <%if(s_bbsId2.equals("BBSMSTR_000000000001")){ %>
								<c:if test="${fn:contains(curAdmin.menuIds, '[313]')}">
					                <button type="button" class="defbtn white" onclick="javascript:fn_egov_moveUpdt_notice();">수정</button>
					                <button type="button" class="defbtn pink" onclick="javascript:fn_egov_delete_notice();">삭제</button>
				            	</c:if>
          					<%}else if(s_bbsId2.equals("BBSMSTR_000000000002")){ %>
								<c:if test="${fn:contains(curAdmin.menuIds, '[323]')}">
					                <button type="button" class="defbtn white" onclick="javascript:fn_egov_moveUpdt_notice();">수정</button>
					                <button type="button" class="defbtn pink" onclick="javascript:fn_egov_delete_notice();">삭제</button>
				            	</c:if>
          					<%}else if(s_bbsId2.equals("BBSMSTR_000000000003")){ %>
								<c:if test="${fn:contains(curAdmin.menuIds, '[333]')}">
					                <button type="button" class="defbtn white" onclick="javascript:fn_egov_moveUpdt_notice();">수정</button>
					                <button type="button" class="defbtn pink" onclick="javascript:fn_egov_delete_notice();">삭제</button>
				            	</c:if>
          					<%}else if(s_bbsId2.equals("BBSMSTR_000000000004")){ %>
								<c:if test="${fn:contains(curAdmin.menuIds, '[343]')}">
					                <button type="button" class="defbtn white" onclick="javascript:fn_egov_moveUpdt_notice();">수정</button>
					                <button type="button" class="defbtn pink" onclick="javascript:fn_egov_delete_notice();">삭제</button>
				            	</c:if>
          					<%}else if(s_bbsId2.equals("BBSMSTR_000000000005")){ %>
								<c:if test="${fn:contains(curAdmin.menuIds, '[353]')}"> --%>
					                <button type="button" class="defbtn pink" onclick="javascript:regionalEduInsert();">입력</button>
				            	<%-- </c:if>
				            <%} %> --%>
			                <button type="button" class="defbtn white" onclick="javascript:regionalEduListGo('${searchVO.pageIndex}');;">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					