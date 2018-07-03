<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>	
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
		function regionalEduUpdate(){
			editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var title = $("#r_edu_title").val();
			var start_date = $("#r_edu_start").val();
			var end_date = $("#r_edu_end").val();
			var contents = $("#contents").val();
			var file = $("#fileUploader").val();
			if(title == "" || typeof title == "undefined"){
				alert("제목을 입력해 주세요");
				$("#r_edu_title").focus();
				return false
			}
			if( contents == ""  || contents == null || contents == '&nbsp;' || contents == '<p>&nbsp;</p>'){
				alert("내용을 입력해 주세요");
				$("#contents").focus();
				return false
			}
			
			if( start_date == "" || typeof start_date == "undefined" ){
				alert("시작일을 선택해 주세요");
				$("#r_edu_start").focus();
				return false
			}
			
			if( end_date == "" || typeof end_date == "undefined" ){
				alert("종료일을 선택해 주세요");
				$("#r_edu_end").focus();
				return false
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
				url : "/site/edu/regionalEduUpdate.do",
				data: formData,
				async   : false,
				processData: false,
				contentType : false,
				success : function(data) {
					if (data.count >= 1) {
						alert("수정 되었습니다.");
						document.frm.method = "post";
						document.frm.action = "<c:url value='/site/edu/cityEdu_view.do'/>";
						document.frm.submit();
					}else{
						alert("수정에 실패 하였습니다.")
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
            <p class="subdep2-tit">시군별 교육</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="basicboard-wrap">
            <form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
            	<input type="hidden" name="writer" value="${loginVO.id}"/>
            	<input type="hidden" name="display_yn" id="display_yn" value="${result.display_yn}"/>
            	<input type="hidden" name="r_edu_no" id="r_edu_no" value="${result.r_edu_no}"/>
                <fieldset>
                    <legend class="screen_out">글쓰기</legend>
                    <table class="basicboard-tbl write no-thead">
                        <caption>글쓰기</caption>
                        <colgroup>
                            <col style="width:15%;"/>
                            <col style="width:35%;"/>
                            <col style="width:15%;"/>
                            <col style="width:35%;"/>
                        </colgroup>
                        <tbody>
                        <tr>                            
                            <th scope="row"><label for="r_edu_title">교육명</label></th>
                            <td colspan="3" class="tl">
                                <input type="text" id="r_edu_title" name="r_edu_title" class="wid60" value="${result.r_edu_title}"/>
                                <div class="incheckwrap">
                                    <input type="checkbox" id="display_check" name="display_check" class="chkbtnjs" <c:if test="${result.display_yn eq 'Y' }">checked="checked"</c:if>/><label for="display_check">선택 시 이달의 교육에 나타납니다.</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="region_code">지역</label></th>
                            <td class="tl">
                                <select name="region_code" id="region_code" class="wid30">
                                    <c:forEach var="regionResult" items="${regionCombo}" varStatus="regionStatus">
					                	<option label="" value="<c:out value='${regionResult.region_code }'/>" <c:if test="${regionResult.region_code eq result.region_code }">selected="selected"</c:if> ><c:out value="${regionResult.region_name }"/></option>
					            	</c:forEach>
                                </select>
                            </td>
                            <th scope="row"><label for="r_edu_place">교육장소</label></th>
                            <td class="tl">
                            	<input type="text" id="r_edu_place" name="r_edu_place" class="wid100" value="${result.r_edu_place}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="inp-eduperiod">교육기간</label></th>
                            <td class="tl">
                            	<input type="text" id="r_edu_start" name="r_edu_start" class="wid40 js-datepicker" title="기간선택" value="${result.r_edu_start}"/> <span style="padding: 0 8px; font-weight: 700;">~</span> 
                            	<input type="text" id="r_edu_end" name="r_edu_end" class="wid40 js-datepicker" title="기간선택" value="${result.r_edu_end}"/>
                            </td>
                            <th scope="row"><label for="inp-eduperiod">전화번호</label></th>
                            <td class="tl">
                            	<input type="text" id="r_edu_tel" name="r_edu_tel" class="wid100" value="${result.r_edu_tel }"}/>
                            </td>
                        </tr>
                        <c:if test="${result.attached_file_id ne null}"> 
	                        <tr>
	 	                        <th scope="row"><label for="inp-file">첨부파일 목록</label></th>
	                            <td class="tl" colspan="3">
	                            	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="updateFlag" value="Y" />
										<c:param name="returnUrl" value="/site/edu/cityEdu_action.do?type=update&r_edu_no=${result.r_edu_no}"/>
									</c:import>
	                            </td>                      
	                        </tr>
                        </c:if>
                        <tr>
 	                        <th scope="row"><label for="inp-file">첨부파일</label></th>
                            <td class="tl" colspan="3">
                            	<input name="file" id="fileUploader" type="file" title="첨부파일입력" />
                            </td>
                        </tr>
                        <tr class="chkhidejs-wrap">
                            <th scope="row"><label for="r_edu_summary">교육내용</label></th>
                            <td class="tl" colspan="3"><textarea name="r_edu_summary" id="r_edu_summary" cols="30" rows="10" class="wid100"><c:out value="${result.r_edu_summary}"/></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                            	<textarea name="r_edu_contents" id="contents" cols="100" rows="15" class="wid100 inptxt"><c:out value="${result.r_edu_contents}"/></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="clearfix twobtnwrap tc">
                        <a href="#" class="commonbtns black" onclick="javascript:regionalEduUpdate();">수정하기</a>
                        <a href="#" class="commonbtns borderblack" onclick="javascript:history.back();">취소</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
