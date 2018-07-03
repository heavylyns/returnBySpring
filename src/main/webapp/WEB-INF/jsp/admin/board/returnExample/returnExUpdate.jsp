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
		
			function boardListGo(boardCode, pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.method = "post";
				document.frm.regionCode.value = "";
				document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
				document.frm.submit();
			}
			function boardUpdate(){
				editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				var title = $("#title").val();
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
				var url="/admin/board/boardUpdate.do";
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
							document.frm.regionCode.value = "";
							document.frm.method = "post";
							document.frm.action = "<c:url value='/admin/board/selectBoardList.do'/>";
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
			
		</script>
		
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">게시판 관리</a></li>
			        <li class="active">귀농귀촌 사례</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">귀농귀촌 사례</h3>
			<div class="contents">
				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					
					<input type="hidden" id="boardNo" name="boardNo" value="<c:out value='${result.board_no}'/>"/>
					<input type="hidden" id="boardCode" name="boardCode" value="<c:out value='${result.board_code }'/>"/>
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input name="searchCnd" type="hidden" value="<c:out value='${searchVO.searchCnd}'/>"/>
					<input name="searchWrd" type="hidden" value="<c:out value='${searchVO.searchWrd}'/>"/>
					
			        <fieldset>
			            <legend class="screen_out">귀농귀촌 사례 수정</legend>
			            <table class="tbl tc no-thead write">
			                <caption>귀농귀촌 사례 수정</caption>
			                <colgroup>
			                     <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th><label for="inp-title">제목</label></th>
			                    <td class="tl" colspan="3">
			                    	<%-- <input type="text" id="inp-title" name="inp-title" class="form-inputbox" value="${result.nttSj}"/> --%>
			                    	<input type="text" id="title" name="title" value="<c:out value='${result.title}'/>"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.name}'/>
			                    	<input type="hidden" id="writer" name="writer" value="<c:out value='${curAdmin.id}'/>"/>
			                    </td>
			                    <th><label for="inp-title">지역</label></th>
			                    <td class="tl">
			                    	<div class="subselect-jqList sel-basic">
				                    	<select id="regionCode" name="regionCode">
				                    		<option label="" value="" <c:if test="${searchVO.regionCode == ''}">selected="selected"</c:if>>전체</option>
					                    	<c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					                    		<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test='${result.region_code == regionResult.region_code }'>selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
					                    	</c:forEach>
				                    	</select>
			                    	</div>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일목록</label></th>
			                    <td class="tl" colspan="3">
						   	        <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl" value="/admin/board/boardUpdatePage.do?boardCode=${result.board_code }&boardNo=${result.board_no }" />
										<c:param name="boardCode" value="${result.board_code }" />
									</c:import>
			                    </td>
			                </tr>
			                 <tr>
			                    <th><label for="inp-file">첨부파일</label></th>
			                    <td class="tl" colspan="3">
			                    	<input type="file" id="inp-file" name="inp-file" class="wid100"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl" colspan="3">
			                    	<textarea name="contents" id="contents" cols="30" rows="15" class="wid100 inptxt" style="width:100%"><c:out value='${result.contents}' escapeXml="false"/></textarea> 
			                    	
			                    </td>
			                </tr>
			              
			                </tbody>
			            </table>
			            <div class="defbtn-wrap">
					        <button type="button" class="defbtn white" onclick="javascript:boardUpdate();">수정</button>
			                <button type="button" class="defbtn white" onclick="javascript:boardListGo('${result.board_code }', '${searchVO.pageIndex}');">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					