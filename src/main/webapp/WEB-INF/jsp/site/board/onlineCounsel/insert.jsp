<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>

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
			function boardInsert(){
				editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				
				var title = $("#title").val();
				var contents = $("#contents").val();
				var lock_yn = $('#lock_yn');
				
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
				if( $(':radio[name="lock_yn"]:checked').length < 1 ){
					alert("공개여부를 선택해 주세요");
					$("#lock_yn").focus();
					return false
				}
				
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				
				$.ajax({
					type : "post",
					cache : false,
					url : "/site/board/boardInsert.do",
					data: formData,
					async   : false,
					processData: false,
					contentType : false,
					success : function(data) {
						if (data.count >= 1) {
							alert("등록되었습니다.");
							document.frm.method = "post";
							document.frm.action = "<c:url value='/site/counsel/onlineCounsel.do'/>";
							document.frm.submit();
						}else{
							alert("등록에 실패하였습니다.")
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
            <form name="frm" id="frm" action="#" enctype="multipart/form-data">
   	        	<input type="hidden" name="writer" value="${loginVO.id}"/>
				<input type="hidden" name="boardCode" value="02"/>
                <fieldset>
                    <legend class="screen_out">글쓰기</legend>
                    <table class="basicboard-tbl write no-thead">
                        <caption>글쓰기</caption>
                        <colgroup>
                            <col style="width:25%;"/>
                            <col style="width:75%;"/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row"><label for="title">제목</label></th>
                            <td class="tl"><input type="text" id="title" name="title" class="wid100"/></td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="inp-writer">작성자</label></th>
                            <td class="tl">
                            	${loginVO.name}
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="inp-thumb">첨부파일</label></th>
                            <td class="tl">
                            	<input name="file" id="fileUploader" type="file" title="첨부파일입력" class="wid30"/>
                            </td>
                        </tr>
                        <tr>
                        	<th scope="row">공개여부</th>
                        	<td class="tl">
                        		<div class="sel-radio">
                                    <input type="radio" id="lock_yn" name="lock_yn" value="N" checked="checked"/>
                                    <label for="sel-open">공개</label>
                                </div>
                                <div class="sel-radio">
                                    <input type="radio" id="lock_yn" name="lock_yn" value="Y"/>
                                    <label for="sel-secrect">비공개</label>
                                </div>                     
                        	</td>
                        </tr>
                        <tr>
                        	<td colspan="2">
                            	<textarea name="contents" id="contents" cols="100" rows="15" class="wid100 inptxt"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="clearfix twobtnwrap tc">
                        <a href="#" class="commonbtns black" onclick="javascript:boardInsert();" >등록하기</a>
                        <a href="#" class="commonbtns borderblack" onclick="javascript:history.back();">취소</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
