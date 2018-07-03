<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />"></script>
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
		var size = "<c:out value='${replySize}'/>";
		for(var i=0; i< 4; i++){
			eval("var editor_object_"+i+" = [];");
			
		}
		"<c:forEach items='${replyList }' var='replyObject'>"
			var replyNo = "${replyObject.reply_no}";
			eval("var editor_object_"+replyNo+" = [];");
		"</c:forEach>"
		$(document).ready(function() {
			var size = $("#replySize").val();
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), 3 );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
			
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: editor_object,
		        elPlaceHolder: "replyContents",
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
		    "<c:forEach items='${replyList }' var='replyEditor'>"
		    var replyNoEditor = ${replyEditor.reply_no}
		    	nhn.husky.EZCreator.createInIFrame({
			        oAppRef: eval("editor_object_"+replyNoEditor),
			        elPlaceHolder: eval("replyContents_"+replyNoEditor),
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
		    "</c:forEach>"
		});
			function onloading() {
				if ("<c:out value='${msg}'/>" != "") {
					alert("<c:out value='${msg}'/>");
				}
			}
			function boardListGo(boardCode, pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.method = "post";
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}
			function boardArticleGo(boardNo, boardCode){
				document.frm.boardNo.value = boardNo;
				document.frm.boardCode.value = boardCode;
				document.frm.method = "post";
				document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
				document.frm.submit();
			}
			function boardUpdateGo(){
				document.frm.method = "post";
				document.frm.action = "<c:url value='/admin/board/boardUpdatePage.do'/>";
				document.frm.submit();
			}

			function boardDelete(){
				
				var frm = $("#frm").serialize();
				if(confirm("삭제 하시겠습니까?")){
					$.ajax({
						type : "post",
						cache : false,
						url : "/admin/board/boardDelete.do",
						data: frm,
						async   : false,
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded",
						success : function(data) {
							if (data.count >= 1) {
								document.frm.method = "post";
								document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
								document.frm.submit();
							}else{
								alert("삭제 하지 못했습니다.")
							}
						},
						error : function(xhr, status, err) {
							alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
						}
					});
				}else{
					return false;
				}
				
			}
			
			function replyInsertView(){
				$("#replyInsert").css('display', 'block');
			}
			function replyInsertHidden(){
				$("#replyInsert").css('display', 'none');
			}
			function replyInsert(){
				editor_object.getById["replyContents"].exec("UPDATE_CONTENTS_FIELD", []);
				
				var contents = $("#replyContents").val();
				if( contents == ""  || contents == null || contents == '&nbsp;' || contents == '<p>&nbsp;</p>'){
					alert("내용을 입력해 주세요");
					$("#replyContents").focus();
					return false
				}
				var url="/admin/board/replyInsert.do";
				var frm = $("#replyFrm")[0];
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
							alert("답변을 등록했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
							document.frm.submit();
						}else{
							alert("답변을 등록하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				}); 
				
			}
			function replyUpdateView(updateDivId, viewDivId){
				$("#"+viewDivId).css('display', 'none');
				$("#"+updateDivId).css('display', 'block');
			}
			function replyUpdateViewHidden(updateDivId, viewDivId){
				$("#"+viewDivId).css('display', 'block');
				$("#"+updateDivId).css('display', 'none');
			}
			function replyUpdate(replyUpFrm, contentsId, replyNo){
				var formName = replyUpFrm;
				var editor_object = eval("editor_object_"+replyNo);
				editor_object.getById[contentsId].exec("UPDATE_CONTENTS_FIELD", []);
				/* document.formName.action = "<c:url value='/admin/board/replyUpdate.do'/>";
				document.formName.submit(); */
				
				var url="/admin/board/replyUpdate.do";
				var frm = $("#"+formName)[0];
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
							alert("답변을 수정했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
							document.frm.submit();
						}else{
							alert("답변을 수정하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				});
				
				//$("#"+formName).attr({action:"<c:url value='/admin/board/replyUpdate.do'/>"}).submit();
			}
			function replyDelete(replyUpFrm, contentsId, replyNo){
				var formName = replyUpFrm;
				
				var url="/admin/board/replyDelete.do";
				var frm = $("#"+formName)[0];
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
							alert("답변을 삭제했습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/board/selectBoardArticle.do'/>";
							document.frm.submit();
						}else{
							alert("답변을 삭제하지 못했습니다.")
						}
					},
					error : function(xhr, status, err) {
						alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
					}
				});
				//$("#"+formName).attr({action:"<c:url value='/admin/board/replyDelete.do'/>"}).submit();
			}//
			
		</script>
		<!-- 온라인상담 뷰 -->
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">게시판 관리</a></li>
			        <li class="active">온라인상담</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">온라인상담</h3>
			<div class="contents">
			<form name="frmGet">
				<input type="hidden" name="boardCode" value='${result.board_code }'/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			</form>
				<form name="frm" id="frm" method="post" action="">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
					<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
					<input type="hidden" name="boardCode" value='${result.board_code }'/>
					<input type="hidden" id="boardNo" name="boardNo" value='${result.board_no }'/>
					<input type="hidden" id="replySize"  value="<c:out value='${replySize }'/>"/>
					
			        <fieldset>
			            <legend class="screen_out">온라인상담 상세</legend>
			            <table class="tbl tc no-thead write">
			                <caption>온라인상담 상세</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:75%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th><label for="inp-title">제목</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.title}'/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.name}'/>
			                    </td>
			                </tr>
			                <tr>
			                    <th>등록일</th>
			                    <td class="tl">${result.reg_date}</td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일</label></th>
			                    <td class="tl">
				                    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
									</c:import> 
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl">
			                    		<c:out value='${result.contents}' escapeXml="false"/>
			                    </td>
			                </tr>
			               <tr>
			                    <th><label for="inp-writer">이전글</label></th>
			                    <td class="tl">
			                    	<c:if test="${result.prev_title ne null }">
				                    	<a href="#"  onclick="boardArticleGo('${result.prev_no}','${result.board_code}', '${searchVO.pageIndex }');">
				                    		<c:out value='${result.prev_title}'/>
				                    	</a>
			                    	</c:if>
			                    	<c:if test="${result.prev_title eq null }">
			                    		이전글이 없습니다.
			                    	</c:if>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">다음글</label></th>
			                    <td class="tl">
			                    	<c:if test="${result.next_title ne null }">
				                    	<a href="#"  onclick="boardArticleGo('${result.next_no}','${result.board_code}', '${searchVO.pageIndex }');">
				                    		<c:out value='${result.next_title}'/>
				                    	</a>
			                    	</c:if>
			                    	<c:if test="${result.next_title eq null }">
			                    		다음 글이 없습니다.
			                    	</c:if>
			                    </td>
			                </tr>
			                </tbody>
			            </table>
			            <div class="defbtn-wrap">
			            	<c:if test="${fn:contains(curAdmin.menuIds, '[323]')}">
					        	<button type="button" class="defbtn white" onclick="javascript:boardUpdateGo('${result.board_code}','${result.board_no}','${searchVO.pageIndex}');">수정</button>
					            <button type="button" class="defbtn pink" onclick="javascript:boardDelete();">삭제</button>
					            <c:if test="${result.status eq 'N' }">
					            	<button type="button" class="defbtn white" onclick="javascript:replyInsertView();">답변</button>
					            </c:if>
					        </c:if>
			                <button type="button" class="defbtn pink" onclick="javascript:boardListGo('${result.board_code}', '${searchVO.pageIndex}');">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
			<!-- 온라인상담 뷰 끝-->
			
			<!-- 온라인상담 뷰에 댓글이 있는 경우  -->
			<c:if test="${result.status eq 'Y' }">
			<!-- 댓글 뷰 -->
			<c:forEach items="${replyList }" var="replyView" varStatus="replyViewStatus">
				<div class="contents" id="replyView_<c:out value='${replyView.reply_no }'/>">
				
					<form name="replyViewFrm_<c:out value='${replyView.reply_no }'/>" id="replyViewFrm_<c:out value='${replyView.reply_no }'/>" method="post" action="">
						
						<input type="hidden" name="boardCode" value='${result.board_code }'/>
						<input type="hidden" name="boardNo" value='${replyView.board_no }'/>
						<input type="hidden" name="replyNo" value='${replyView.reply_no }'/>
				        <fieldset>
				            <legend class="screen_out">온라인상담댓글 상세</legend>
				            
				            <input type="hidden" value="<c:out value='${replyView.reply_no }'/>"/>
				            <table class="tbl tc no-thead write">
				                <caption>온라인상담 댓글 상세</caption>
				                <colgroup>
				                    <col style="width:25%;"/>
				                    <col style="width:75%;"/>
				                </colgroup>
				                <tbody>
				                <tr>
				                    <th colspan="2"><label for="inp-title">답변</label></th>
				                    
				                </tr>
				                <tr>
				                    <th><label for="inp-writer">작성자</label></th>
				                    <td class="tl">
				                    	<c:out value='${replyView.name}'/>
				                    </td>
				                </tr>
				                <tr>
				                    <th>등록일</th>
				                    <td class="tl">${replyView.reg_date}</td>
				                </tr>
				                <tr>
				                    <th><label for="inp-file">첨부파일</label></th>
				                    <td class="tl">
					                    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${replyView.attached_file_id}" />
										</c:import> 
				                    </td>
				                </tr>
				                <tr>
				                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
				                    <td class="tl">
				                    		<c:out value='${replyView.contents}' escapeXml="false"/>
				                    		
				                    </td>
				                </tr>
				               
				                </tbody>
				            </table>
				            
				            <div class="defbtn-wrap">
						       <button type="button" class="defbtn white" onclick="javascript:replyUpdateView('replyUpdate_${replyView.reply_no }', 'replyView_${replyView.reply_no }');">수정</button>
						       <button type="button" class="defbtn pink" onclick="javascript:replyDelete('replyViewFrm_${replyView.reply_no }', ${replyView.reply_no });">삭제</button>
					            	
				            </div>
				        </fieldset>
				    </form>
				</div>
				
				<div class="contents" id="replyUpdate_<c:out value='${replyView.reply_no }'/>" style="display: none;">
				<form name="replyUpdateFrm_<c:out value='${replyView.reply_no }'/>" id="replyUpdateFrm_<c:out value='${replyView.reply_no }'/>" method="post" action="" enctype="multipart/form-data">
				
					<input type="hidden" name="boardCode" value='${result.board_code }'/>
					<input type="hidden" id="boardNo_<c:out value='${replyView.reply_no }'/>" name="boardNo" value='${replyView.board_no }'/>
					<input type="hidden" id="replyNo_<c:out value='${replyView.reply_no }'/>" name="replyNo" value='${replyView.reply_no }'/>
			        <fieldset>
			            <legend class="screen_out">온라인상담댓글 상세</legend>
			            
			            <input type="hidden" value="<c:out value='${replyView.reply_no }'/>"/>
			            <table class="tbl tc no-thead write">
			                <caption>온라인상담 댓글 상세</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:75%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th colspan="2"><label for="inp-title">답변</label></th>
			                    
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value='${curAdmin.name}'/>
			                    	<input type="hidden" id="replyWriter" name="writer" value="<c:out value='${curAdmin.id}'/>"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th>등록일</th>
			                    <td class="tl">${replyView.reg_date}</td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일목록</label></th>
			                    <td class="tl">
						   	        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${replyView.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl" value="/admin/board/selectBoardArticle.do?boardCode=${result.board_code }&boardNo=${result.board_no }" />
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
			                    <th ><label for="inp-txt">내용</label></th>
			                    <td class="tl">
			                    	<textarea name="contents" id="replyContents_<c:out value='${replyView.reply_no }'/>" cols="50" rows="15" class="wid100 inptxt" style="width:100%">
			                    		<c:out value='${replyView.contents}' escapeXml="false"/>
			                    	</textarea>	
			                    </td>
			                </tr>
			               
			                </tbody>
			            </table>
			            
			            <div class="defbtn-wrap">
					       <button type="button" class="defbtn white" onclick="javascript:replyUpdate('replyUpdateFrm_${replyView.reply_no }', 'replyContents_${replyView.reply_no }', ${replyView.reply_no });">수정</button>
					       <button type="button" class="defbtn pink" onclick="javascript:replyUpdateViewHidden('replyUpdate_${replyView.reply_no }', 'replyView_${replyView.reply_no }');">취소</button>
				            	
			            </div>
			        </fieldset>
			    </form>
			</div>
			</c:forEach>
			
			<!-- 댓글 수정 -->
			<%-- <c:forEach items="${replyList }" var="replyUpdate" varStatus="updateStatus">
			<div class="contents" id="replyUpdate_<c:out value='${replyUpdate.reply_no }'/>" style="display: none;">
				<form name="replyUpdateFrm_<c:out value='${replyUpdate.reply_no }'/>" method="post" action="">
					<input type="hidden" id="boardNo_<c:out value='${replyUpdate.reply_no }'/>" name="boardNo" value='${result.board_no }'/>
			        <fieldset>
			            <legend class="screen_out">온라인상담댓글 상세</legend>
			            
			            <input type="hidden" value="<c:out value='${replyUpdate.reply_no }'/>"/>
			            <table class="tbl tc no-thead write">
			                <caption>온라인상담 댓글 상세</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:75%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th colspan="2"><label for="inp-title">답변</label></th>
			                    
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<input type="text" value="<c:out value='${curAdmin.name}'/>" disabled="disabled"/>
			                    	<input type="hidden" id="replyWriter" name="writer" value="<c:out value='${curAdmin.name}'/>"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th>등록일</th>
			                    <td class="tl">${replyUpdate.reg_date}</td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일목록</label></th>
			                    <td class="tl">
						   	        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl" value="/admin/board/boardUpdatePage.do" />
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
			                    <th ><label for="inp-txt">내용</label></th>
			                    <td class="tl">
			                    	<textarea name="contents" id="replyContents_<c:out value='${updateStatus.index }'/>" cols="50" rows="15" class="wid100 inptxt">
			                    		<c:out value='${replyUpdate.contents}' escapeXml="false"/>
			                    	</textarea>	
			                    </td>
			                </tr>
			               
			                </tbody>
			            </table>
			            
			            <div class="defbtn-wrap">
					       <button type="button" class="defbtn white" onclick="javascript:;">수정</button>
					       <button type="button" class="defbtn pink" onclick="javascript:boardDelete();">삭제</button>
				            	
			            </div>
			        </fieldset>
			    </form>
			</div>
			</c:forEach> --%>
			<!-- 댓글 수정 끝-->
			</c:if>
			<!-- 온라인상담 뷰에 댓글이 있는 경우  끝-->
			
			<!-- 댓글 입력 및 수정 -->
			<div class="contents" id="replyInsert" style="display: none;">
				<form name="replyFrm" id="replyFrm" method="post" enctype="multipart/form-data">
					
					<input type="hidden" id="ReplyBoardNo" name="boardNo" value="<c:out value='${result.board_no}'/>"/>
					<input type="hidden" id="ReplyBoardCode" name="boardCode" value="<c:out value='${result.board_code }'/>"/>
					
					
			        <fieldset>
			            <legend class="screen_out">댓글 입력</legend>
			            <table class="tbl tc no-thead write">
			                <caption>댓글 입력</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:75%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th colspan="2"><label for="inp-title">답변</label></th>
			                    
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<%-- <input type="text" id="inp-writer" name="inp-writer" class="form-inputbox" value="${result.ntcrNm}" readonly="readonly"/> --%>
			                    	<c:out value='${curAdmin.name}'/>
			                    	<input type="hidden" id="replyWriter" name="writer" value="<c:out value='${curAdmin.id}'/>"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일목록</label></th>
			                    <td class="tl">
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
			                    <td class="tl">
			                    	<textarea name="contents" id="replyContents" cols="50" rows="15" class="wid100 inptxt" style="width:100%"><c:out value='${reply.contents}' escapeXml="false"/></textarea> 
			                    	
			                    </td>
			                </tr>
			                </tbody>
			            </table>
			            <div class="defbtn-wrap">
				        	
					                <c:if test="${result.status ne 'Y' }">
					                <button type="button" class="defbtn white" onclick="javascript:replyInsert();">입력</button>
					                </c:if>
					                <c:if test="${result.status eq 'Y' }">
					                <button type="button" class="defbtn white" onclick="javascript:replyUpdate();">수정</button>
					                </c:if>
			                <button type="button" class="defbtn pink" onclick="javascript:replyInsertHidden();">취소</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
			<!-- 댓글 입력 및 수정 끝-->
			
			
			
						
			
			
			
			
			
		</div>
					