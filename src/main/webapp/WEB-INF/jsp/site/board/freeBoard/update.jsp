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
				var url="/site/board/boardUpdate.do";
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
							alert("수정되었습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/site/comunity/freeBoard_view.do'/>";
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





	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">자유게시판</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="basicboard-wrap">
            <form name="frm" id="frm" method="post" action="#" enctype="multipart/form-data">
                <input type="hidden" name="writer" value="${loginVO.id}"/>
                <input type="hidden" name="boardCode" value="08"/>
                <input type="hidden" name="boardNo" value="${result.board_no}"/>
                <fieldset>
                    <legend class="screen_out">자유게시판</legend>
                    <table class="basicboard-tbl write no-thead">
                        <caption>자유게시판</caption>
                        <colgroup>
                            <col style="width:25%;"/>
                            <col style="width:75%;"/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th><label for="title">제목</label></th>
                            <td class="tl"><input type="text" id="title" name="title" class="wid100" value="${result.title}"/></td>
                        </tr>
                        <tr>
                            <th><label for="inp-writer">작성자</label></th>
                            <td class="tl">
                            	${loginVO.name}
                            </td>
                        </tr>
                        <c:if test="${result.attached_file_id ne null}">
	                        <tr>
	                            <th><label for="inp-file">등록된 첨부파일</label></th>
	                            <td class="tl">
	                            	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl" value="/site/comunity/freeBoard_action.do?type=update&boardNo=${result.board_no}&boardCode=08"/>
									</c:import>
	                            </td>
	                        </tr>
                        </c:if>
                        <tr>
                            <th><label for="inp-file">첨부파일</label></th>
                             <td class="tl">
								<input name="file_1" id="egovComFileUploader" type="file" title="첨부파일입력" />
							</td>
						</tr>
                        <tr>
                            <td colspan="2">
                            	<textarea name="contents" id="contents" cols="100" rows="15" class="wid100 inptxt"><c:out value="${result.contents}"/></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="clearfix twobtnwrap tc">
                        <a href="#" class="commonbtns black" onclick="javascript:boardUpdate();">수정하기</a>
                        <a href="#" class="commonbtns borderblack" onclick="javascript:history.back();">취소</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
