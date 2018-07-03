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
								document.frm.action = "<c:url value='/site/instance/instance.do'/>";
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
							document.frm.action = "<c:url value='/site/instance/instance.do'/>";
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
            <p class="subdep2-tit">귀농귀촌 사례</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="basicboard-wrap">
            <form name="frm" id="frm" action="#" enctype="multipart/form-data">
   	        	<input type="hidden" name="writer" value="${loginVO.id}"/>
				<input type="hidden" name="boardCode" value="03"/>
				<input type="hidden" name="boardNo" value="${result.board_no}"/>
                <fieldset>
                    <legend class="screen_out">수정</legend>
                    <table class="basicboard-tbl write no-thead">
                        <caption>수정</caption>
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
                            <th><label for="region">지역</label></th>
                            <td class="tl">
                            	<select id="region_code" name="region_code" class="wid10">
                            		<option label="" value="" <c:if test="${searchVO.regionCode == ''}">selected="selected"</c:if>>전체</option>
					                <c:forEach var="regionResult" items="${regionCombo }" varStatus="regionStatus">
					                	<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test='${result.region_code == regionResult.region_code }'>selected="selected"</c:if>><c:out value="${regionResult.region_name }"/></option>
					                </c:forEach>
				            	</select>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="inp-thumb">등록된 썸네일 이미지</label></th>
                            <td class="tl">
                            	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.attached_file_id}" />
									<c:param name="updateFlag" value="Y" />
									<c:param name="returnUrl" value="/site/board/boardUpdatePage.do?boardCode=${result.board_code}&boardNo=${result.board_no}" />
									<c:param name="boardCode" value="${result.board_code}" />
								</c:import>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="inp-thumb">대표이미지 (썸네일 430*347px)</label></th>
                            <td class="tl">
                            	<input name="file_1" id="fileUploader" type="file" title="첨부파일입력" class="wid30"/>
                            	<span class="smalltxt">※ 대표이미지로 등록한 사진은 리스트 항목에만 노출됩니다. 동일한 사진을 내용에서 보시려면 에디터에 추가해 주세요.</span>
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
                        <a href="#lnk" class="commonbtns black" onclick="javascript:boardUpdate();">수정하기</a>
                        <a href="#lnk" class="commonbtns borderblack" onclick="javascript:history.back();">취소</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
