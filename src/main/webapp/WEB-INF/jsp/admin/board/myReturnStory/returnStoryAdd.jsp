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
		
			function fn_egov_moveUpdt_notice() {
				/* 
				if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
					alert('등록시 사용한 패스워드를 입력해 주세요.');
					document.frm.password.focus();
					return;
				}
		 		*/
				document.frm.action = "<c:url value='/admin/board/forUpdateBoardArticle.do'/>";
				document.frm.submit();
			}
		
			function fn_egov_addReply() {
				document.frm.action = "<c:url value='/cop/bbs${prefix}/addReplyBoardArticle.do'/>";
				document.frm.submit();
			}
			
			
			function boardListGo(boardCode, pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.method = "post";
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}

			function boardInsert(){
				editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				
				var title = $("#title").val();
				var contents = $("#contents").val();
				var file = $("#fileUploader").val();				
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
				if(file == "" || typeof file == "undefined"){
					alert("파일을 입력해 주세요");
					$("#fileUploader").focus();
					return false
				}
				

				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				
				$.ajax({
					type : "post",
					cache : false,
					url : "/admin/board/boardInsert.do",
					data: formData,
					async   : false,
					processData: false,
					contentType : false,
					success : function(data) {
						if (data.count >= 1) {
							alert("등록했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
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
			        <li class="active">나의 귀농귀촌 이야기</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">나의 귀농귀촌 이야기</h3>
			<div class="contents">
				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" name="boardCode" value="<c:out value='${searchVO.boardCode }'/>"/>
					
			        <fieldset>
			            <legend class="screen_out">귀농귀촌 사례 입력</legend>
			            <table class="tbl tc no-thead write">
			                <caption>귀농귀촌 사례 입력</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:75%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th><label for="inp-title">제목</label></th>
			                    <td class="tl">
			                    	<%-- <input type="text" id="inp-title" name="inp-title" class="form-inputbox" value="${result.nttSj}"/> --%>
			                    	<input type="text" id="title" name="title"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value="${curAdmin.name}"/>
			                    	<input type="hidden" id="writer" name="writer" value="<c:out value='${curAdmin.id }'/>"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">대표이미지</label></th>
			                    <td class="tl">
				                   <%--  <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import> --%>
			                    	<!-- <input type="file" id="inp-file" name="inp-file" class="wid100"/> --> 
			                    			
								   <input name="file_1" id="fileUploader" type="file" title="첨부파일입력"/><br/>
								  ※ 대표이미지로 등록한 사진은 리스트 항목에만 노출됩니다. 동일한 사진을 내용에서 보시려면 에디터에 추가해 주세요.
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl">
			                    	<textarea name="contents" id="contents" cols="30" rows="15" class="wid100 inptxt" style="width:100%"></textarea> 
			                    	
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
					                <button type="button" class="defbtn pink" onclick="javascript:boardInsert();">입력</button>
				            	<%-- </c:if>
				            <%} %> --%>
			                <button type="button" class="defbtn white" onclick="javascript:boardListGo('${searchVO.boardCode }', '${searchVO.pageIndex}');">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					