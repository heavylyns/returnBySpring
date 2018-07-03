<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js'/>" ></script>
	
	<script type="text/javascript">
		var editor_object = [];
		$(document).ready(function() {
			var size = $("#replySize").val();
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
		});
		function onloading() {
			if ("<c:out value='${msg}'/>" != "") {
				alert("<c:out value='${msg}'/>");
			}
		}
		function boardListGo(boardCode, pageNo) {
			document.frm.pageIndex.value = pageNo;
			document.frm.method = "post";
			document.frm.action = "<c:url value='/site/counsel/onlineCounsel.do'/>";
			document.frm.submit();
		}
		function boardUpdateGo(){
			document.frm.method = "post";
			document.frm.action = "<c:url value='/site/counsel/onlineCounsel_action.do?type=update'/>";
			document.frm.submit();
		}
		function boardDelete(){
			var frm = $("#frm").serialize();
			if(confirm("삭제 하시겠습니까?")){
				$.ajax({
					type : "post",
					cache : false,
					url : "/site/board/boardDelete.do",
					data: frm,
					async   : false,
					dataType : 'json',
					contentType : "application/x-www-form-urlencoded",
					success : function(data) {
						if (data.count >= 1) {
							document.frm.method = "post";
							document.frm.action = "<c:url value='/site/counsel/onlineCounsel.do'/>";
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
			var url="/site/board/replyInsert.do";
			var frm = $("#insert_form")[0];
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
						document.frm.action = "<c:url value='/site/counsel/onlineCounsel_view.do'/>";
						document.frm.submit();
					}else{
						alert("답변을 등록하지 못했습니다.")
					}
				},
				error : function(xhr, status, err) {
					alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
				}
			}); 
			/* document.replyFrm.action = "<c:url value='/admin/board/replyInsert.do'/>";
			document.replyFrm.submit(); */
		}
		function replyUpdateView(){
			$("#replyUpdate").css('display', 'block');
			$("#replyView").css('display', 'none');
		}
		function replyUpdateViewHidden(){
			$("#replyUpdate").css('display', 'none');
			$("#replyView").css('display', 'block');
		}
		function replyUpdate(replyUpFrm, contentsId){
			var formName = replyUpFrm;
			editor_object.getById[contentsId].exec("UPDATE_CONTENTS_FIELD", []);
			
			var url="/site/board/replyUpdate.do";
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
						alert("답변이 수정 되었습니다.");
						document.frm.method = "post";
						document.frm.action = "<c:url value='/site/counsel/onlineCounsel_view.do'/>";
						document.frm.submit();
					}else{
						alert("답변을 수정하지 못했습니다.")
					}
				},
				error : function(xhr, status, err) {
					alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
				}
			});
		}
		function replyDelete(replyUpFrm, replyNo){
			var formName = replyUpFrm;
			var url="/site/board/replyDelete.do";
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
						document.frm.action = "<c:url value='/site/counsel/onlineCounsel_view.do'/>";
						document.frm.submit();
					}else{
						alert("답변을 삭제하지 못했습니다.")
					}
				},
				error : function(xhr, status, err) {
					alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
				}
			});
		}
	</script>
	
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">온라인 상담안내</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
	        <div class="basicboard-wrap">
	        	<!-- 본문 시작 -->
	        	<form name="frm" id="frm" method="post" action="">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" name="boardCode" value='${result.board_code }'/>
					<input type="hidden" id="boardNo" name="boardNo" value='${result.board_no }'/>
					<input type="hidden" id="replySize"  value="<c:out value='${replySize}'/>"/>
		            <table class="basicboard-tbl view no-thead">
		                <caption>글보기</caption>
		                <colgroup>
		                    <col style="width:15%;"/>
		                    <col style="width:35%;"/>
		                    <col style="width:15%;"/>
		                    <col style="width:35%;"/>
		                </colgroup>
		                <tbody>
		                <tr>
		                    <th scope="row">제목</th>
		                    <td colspan="3" class="tl">${result.title}</td>
		                </tr>
		                <tr>
		                    <th scope="row">작성자</th>
			                <c:if test="${loginVO.login_type ne 'admin'}">
		                    	<td class="tl">${fn:substring(result.name,0,1)}<c:forEach begin="2" end="${fn:length(result.name)}" step="1"><c:out value="*"/></c:forEach></td>
		                    </c:if>
		                    <c:if test="${loginVO.login_type eq 'admin'}">
		                    	<td class="tl">${result.name}</td>
		                    </c:if>
		                    <th scope="row">등록일</th>
		                    <td class="tl">${result.reg_date}</td>
		                </tr>
		                <tr>
		                    <th scope="row">첨부파일</th>
		                    <td colspan="3" class="tl">
		                    	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.attached_file_id}" />
									<c:param name="returnUrl" value="/site/counsel/onlineCounsel_view.do?boardNo=${result.board_no}&boardCode=02" />
								</c:import>
								<c:if test="${result.attached_file_id eq null}">등록된 첨부파일이 없습니다.</c:if>
		                    </td>
		                </tr>
		                <tr>
		                    <th scope="row">내용</th>
		                    <td colspan="3" class="tl" style="height:300px;">
		                    	<c:out value="${result.contents}" escapeXml="false"/>
							</td>
		                </tr>
		                </tbody>
		            </table>
	            </form>
	            <div class="clearfix twobtnwrap tc"> 
	            	<c:if test="${loginVO.login_type eq 'admin' || loginVO.id eq result.writer}">
		                <a href="#lnk" class="commonbtns black" onclick="javascript:boardUpdateGo();">수정</a>
		                <a href="#lnk" class="commonbtns black" onclick="javascript:boardDelete();">삭제</a>
	                </c:if>
	                <c:if test="${result.status eq 'N' && loginVO.login_type eq 'admin'}">
						<a href="#lnk" class="commonbtns borderblack" onclick="javascript:replyInsertView();">답변</a>
					</c:if>
	                <a href="#lnk" class="commonbtns borderblack" onclick="javascript:boardListGo('${result.board_code }', '${searchVO.pageIndex}');">목록</a>
	            </div>
	            <!-- 본문 종료 -->
	            <!-- 답변 view -->
		        <c:if test="${result.status eq 'Y' }">
		            <div class="contents" id="replyView">
		            <c:forEach items="${replyList}" var="replyView" varStatus="replyViewStatus">
		            <form name="replyViewFrm" id="replyViewFrm" method="post" action="">
						<input type="hidden" name="boardCode" value='${result.board_code }'/>
						<input type="hidden" name="boardNo" value='${replyView.board_no }'/>
						<input type="hidden" name="replyNo" value='${replyView.reply_no }'/>
			            <table class="basicboard-tbl write no-thead" style="margin-top:100px;">
			                <caption>글쓰기</caption>
			                <colgroup>
			                    <col style="width:15%;"/>
			                    <col style="width:35%;"/>
			                    <col style="width:15%;"/>
			                    <col style="width:35%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th colspan="4" scope="col">답변</th>
			                </tr>
			                <tr>
			                    <th scope="row"><label for="inp-writer">작성자</label></th>
			                    <td class="tl">${replyView.name}</td>
			                    <th scope="row">등록일</th>
			                    <td class="tl">${replyView.reg_date}</td>
			                </tr>
			                <tr>
			                    <th scope="row">첨부파일</th>
			                    <td colspan="3" class="tl">
			                    	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${replyView.attached_file_id}" />
										<c:param name="returnUrl" value="/site/counsel/onlineCounsel_view.do?boardNo=${result.board_no}&boardCode=02" />
									</c:import> 
									<c:if test="${replyView.attached_file_id eq null}">등록된 첨부파일이 없습니다.</c:if>
			                    </td>
			                </tr>
			                <tr>
			                    <th scope="row" style="height:300px;">내용</th>
			                    <td colspan="3" class="tl" >
			                    	<c:out value='${replyView.contents}' escapeXml="false"/>
			                    </td>
			                </tr>
			                </tbody>
			            </table>
		            </form>
		            <div class="clearfix twobtnwrap tc">
		            	<c:if test="${loginVO.login_type eq 'admin'}">
		           			<a href="#lnk" class="commonbtns black" onclick="javascript:replyUpdateView();">수정</a>
		           			<a href="#lnk" class="commonbtns borderblack" onclick="javascript:replyDelete('replyViewFrm', ${replyView.reply_no });">삭제</a>
	           			</c:if>
	           		</div>
	           		</c:forEach>
	           		</div>
		        </c:if>
	        	<!-- 답변 view 종료 -->
	  		  	<!-- 답변 수정 시작 -->
	        	<div class="contents" id="replyUpdate" style="display: none;">
		        	<c:forEach items="${replyList}" var="replyView" varStatus="replyViewStatus">
		            <form id="replyUpdateFrm" name="replyUpdateFrm" action="#" method="post" enctype="multipart/form-data">
			            <input type="hidden" name="writer" value="${loginVO.id}"/>
			            <input type="hidden" id="boardNo" name="boardNo" value='${replyView.board_no }'/>
						<input type="hidden" id="replyNo" name="replyNo" value='${replyView.reply_no }'/>
		                <fieldset>
		                    <legend class="screen_out">글쓰기</legend>
		                    <table class="basicboard-tbl write no-thead" style="margin-top:100px;">
		                        <caption>글쓰기</caption>
		                        <colgroup>
		                            <col style="width:15%;"/>
		                            <col style="width:35%;"/>
		                            <col style="width:15%;"/>
		                            <col style="width:35%;"/>
		                        </colgroup>
		                        <tbody>
		                        <tr>
		                            <th colspan="4" scope="col">답변</th>
		                        </tr>
		                        <tr>
		                            <th scope="row"><label for="inp-writer">작성자</label></th>
		                            <td class="tl">
		                            	<c:if test="${result.status eq 'Y'}">
		                            		${replyView.name}
		                            	</c:if>
		                            	<c:if test="${result.status eq 'N' }">
		                            		${loginVO.name}
		                            	</c:if>
		                            </td>
		                            <th scope="row">등록일</th>
		                            <td class="tl">${replyView.reg_date}</td>
		                        </tr>
		                        <c:if test="${replyView.attached_file_id ne null}">
			                        <tr>
					                    <th><label for="inp-file">첨부파일목록</label></th>
					                    <td class="tl">
								   	        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${replyView.attached_file_id}" />
												<c:param name="updateFlag" value="Y" />
												<c:param name="returnUrl" value="/site/counsel/onlineCounsel_view.do?boardNo=${result.board_no}&boardCode=02" />
											</c:import>
					                    </td>
					                </tr>
				                </c:if>
		                        <tr>
		                            <th scope="row">첨부파일</th>
		                            <td colspan="3" class="tl">
		                            	<input type="file" id="inp-file" name="inp-file" class="wid100"/>
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th scope="row" style="height:300px;">내용</th>
		                            <td colspan="3">
		                            	<textarea name="contents" id="replyContents" cols="50" rows="15" style="width:100%" class="wid100 inptxt"><c:out value='${replyView.contents}' escapeXml="false"/></textarea> 
		                            </td>
		                        </tr>
		                        </tbody>
		                    </table>
		                    <c:if test="${result.status ne 'Y'}">
			                    <div class="clearfix tr">
			                        <button type="button" class="commonbtns black onebtn" onclick="javascript:replyInsert();">등록하기</button>
			                    </div>
		                    </c:if>
			                <div class="clearfix twobtnwrap tc">
					        	<a href="#lnk" class="commonbtns black" onclick="javascript:replyUpdate('replyUpdateFrm', 'replyContents');">수정</a>
					            <a href="#lnk" class="commonbtns borderblack" onclick="replyUpdateViewHidden();">취소</a>
			            	</div>
		                </fieldset>
		            </form>
		            </c:forEach>
	            </div>
	            <!-- 답변수정 끝 -->
	            <!-- 답변입력 -->
	            <div class="contents" id="replyInsert" style="display: none;">
		            <form id="insert_form" name="insert_form" action="#" method="post" enctype="multipart/form-data">
		            	<input type="hidden" name="boardNo" value="${result.board_no}"/>
		            	<input type="hidden" name="boardCode" value="02"/>
		            	<input type="hidden" name="writer" value="${loginVO.id}"/>
		                <fieldset>
		                    <legend class="screen_out">글쓰기</legend>
		                    <table class="basicboard-tbl write no-thead" style="margin-top:100px;">
		                        <caption>글쓰기</caption>
		                        <colgroup>
		                            <col style="width:15%;"/>
		                            <col style="width:85%;"/>
		                        </colgroup>
		                        <tbody>
		                        <tr>
		                            <th colspan="2" scope="col">답변 등록</th>
		                        </tr>
		                        <tr>
		                            <th scope="row"><label for="inp-writer">작성자</label></th>
		                            <td class="tl">
		                            	${loginVO.name}
		                            </td>
		                        </tr>
		                        <tr>
		                            <th scope="row">첨부파일</th>
		                            <td class="tl">
		                            	<input type="file" id="inp-file" name="inp-file" class="wid100"/>
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th scope="row" style="height:300px;">내용</th>
		                            <td class="tl">
		                            	<textarea name="contents" id="replyContents" cols="50" rows="15" style="width:100%" class="wid100 inptxt"></textarea> 
		                            </td>
		                        </tr>
		                        </tbody>
		                    </table>
			                <div class="clearfix tr">
			                	<button type="button" class="commonbtns black onebtn" onclick="javascript:replyInsert();">등록하기</button>
			                </div>
		                </fieldset>
		            </form>
	            </div>
	        </div>
    </div>
    