<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="/js/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%	
	// update or insert 구분값
	String s_type = request.getParameter("type");
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
		    
		    
		    
		    <c:if test="${popupVO.input_type eq 'image' || popupVO.input_type eq null}">
		   		 $("#contentsRow").css('display', 'none');
		    </c:if>
		    <c:if test="${popupVO.input_type eq 'html'}">
		    	$("#contentsRow").css('display', 'table-row');
		    </c:if>
		    
	   		
		    $("#smart_editor2").css('width', '700px');
		});
			function popup_agree(v_type){
				if($("#title").val() == ""){
					alert("제목을 입력해 주세요.");			
					$("#title").focus();
					return;
				}
				if($("#size_width").val() == ""){
					alert("창크기 너비를 입력해 주세요.");			
					$("#size_width").focus();
					return;
				}
				if($("#size_height").val() == ""){
					alert("창크기 높이를 입력해 주세요.");			
					$("#size_height").focus();
					return;
				}
				if($("#view_width").val() == ""){
					alert("창위치 가로를 입력해 주세요.");			
					$("#view_width").focus();
					return;
				}
				if($("#view_height").val() == ""){
					alert("창위치 세로를 입력해 주세요.");			
					$("#view_height").focus();
					return;
				}
				if($("#link").val() == ""){
					alert("링크를 입력해 주세요.");			
					$("#link").focus();
					return;
				}
				if($("#start_date").val() == ""){
					alert("시작일을 선택해 주세요.");			
					$("#start_date").focus();
					return;
				}
				if($("#end_date").val() == ""){
					alert("종료일을 선택해 주세요.");			
					$("#end_date").focus();
					return;
				}
				
				var inputVal = $(":input:radio[name=input_type]:checked").val();
				 if(inputVal == "html"){
					 editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					var contents = $("#contents").val();
					$("#popup_file").val("");
				 }else{
					editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					var contents = $("#contents").val("");
				 }
				
				if(v_type == "insert"){
					document.frm.action = "<c:url value='/admin/homep/popup_join.do'/>";
				}else{
					document.frm.action = "<c:url value='/admin/homep/popup_update.do'/>";
				}
				 
				 
				//return false;
				document.frm.submit();
			}

			function popup_delete(){
				if(confirm("정말로 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/homep/popup_delete.do'/>";
					document.frm.submit();
				}
			}

			function popup_file_delete(){
				if(confirm("정말로 첨부파일을 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/homep/popup_file_delete.do'/>";
					document.frm.submit();
				}
			}
			function inputTypechange(val){
				
				if(val == "html"){
					$("#contentsRow").css('display', 'table-row');
				}else{
					$("#contentsRow").css('display', 'none');
				}
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">홈페이지 관리</a></li>
			        <li class="active">팝업 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">팝업 관리</h3>
			
			<div class="contents">
			
				
	            <form action="#" name="frm" id="frm" method="post" enctype="multipart/form-data">
	            	<input type="hidden" name="popup_no" value="${popupVO.popup_no }" />
	                
	                <fieldset>
	                    <legend class="screen_out">팝업 관리</legend>
	                    <table class="tbl no-thead write">
	                        <caption>팝업 입력표</caption>
	                        <colgroup>
	                            <col style="width:25%;"/>
	                            <col style="width:55%;"/>
	                            <col style="width:20%;"/>
	                        </colgroup>
	                        <tbody>
	                        <tr>
	                            <th><label for="title">제목</label></th>
	                            <td colspan="2"><input type="text" id="title" name="title" class="form-inputbox" value="${popupVO.title }"/></td>
	                        </tr>
	                        <tr>
	                            <th><label for="inp-image">이미지</label></th>
	                            <td>
	                            	<input type="file" id="popup_file" name="popup_file" class="wid100"/>
	                            	<c:if test="${file.atchFileId ne '' && file.atchFileId ne null}">
	         	                   		<img src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${file.atchFileId}"/>&fileSn=<c:out value="${file.fileSn}"/>' alt="${file.orignlFileNm}" style="width:140px;"/>
	                            	</c:if>
	                            </td>
	                            <td class="table-btn"><button type="button" class="defbtn pink valdel-btn" onclick="javascript:popup_file_delete();">첨부파일 삭제</button></td>
	                        </tr>
	                        <tr>
	                            <th>팝업 입력 형식</th>
	                            <td colspan="2">
	                                <div class="clearfix wid100 sel-table">
	                                    <div class="fl">
	                                        <input type="radio" id="input_type" name="input_type" onchange="javascript:inputTypechange('image');" value="image" <c:if test="${popupVO.input_type eq 'image' || popupVO.input_type eq null}">checked</c:if>/>
	                                        <label for="sel-inpimage">이미지</label>
	                                    </div>
	                                    <div class="fl">
	                                        <input type="radio" id="input_type" name="input_type" onchange="javascript:inputTypechange('html');" value="html" <c:if test="${popupVO.input_type eq 'html'}">checked</c:if>/>
	                                        <label for="sel-inphtml">HTML</label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>팝업 출력 형식</th>
	                            <td colspan="2">
	                                <div class="clearfix wid100 sel-table">
	                                    <div class="fl">
	                                        <input type="radio" id="output_type" name="output_type" value="layer" <c:if test="${popupVO.output_type eq 'layer' || popupVO.output_type eq null}">checked</c:if>/>
	                                        <label for="sel-layer">레이어 팝업</label>
	                                    </div>
	                                    <div class="fl">
	                                        <input type="radio" id="output_type" name="output_type" value="window" <c:if test="${popupVO.output_type eq 'window'}">checked</c:if>/>
	                                        <label for="sel-window">윈도우 팝업</label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>창크기</th>
	                            <td colspan="2">
	                                <div class="two-inpwrap clearfix">
	                                    <div class="fl">
	                                        <label for="inp-wid" class="fl">너비 : </label>
	                                        <input type="text" id="size_width" name="size_width" class="form-inputbox fl" value="${popupVO.size_width }"/>
	                                        <span class="fl">pixel</span>
	                                    </div>
	                                    <div class="fl">
	                                        <label for="inp-height" class="fl">높이 : </label>
	                                        <input type="text" id="size_height" name="size_height" class="form-inputbox fl" value="${popupVO.size_height }"/>
	                                        <span class="fl">pixel</span>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>창위치</th>
	                            <td colspan="2">
	                                <div class="two-inpwrap clearfix">
	                                    <div class="fl">
	                                        <label for="inp-posleft" class="fl">가로 : </label>
	                                        <input type="text" id="view_width" name="view_width" class="form-inputbox fl" value="${popupVO.view_width }"/>
	                                        <span class="fl">pixel</span>
	                                    </div>
	                                    <div class="fl">
	                                        <label for="inp-postop" class="fl">세로 : </label>
	                                        <input type="text" id="view_height" name="view_height" class="form-inputbox fl" value="${popupVO.view_height }"/>
	                                        <span class="fl">pixel</span>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="link">링크</label></th>
	                            <td><input type="text" id="link" name="link" class="form-inputbox" value="${popupVO.link }"/></td>
	                            <td>Http를 포함해서 넣어주세요.</td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">시작일</label></th>
	                            <td colspan="2">
	                                <div class="form-input">
	                                    <input type="text" id="start_date" name="start_date" class="form-inputbox white js-datepicker" value="${popupVO.start_date }">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="end_date">종료일</label></th>
	                            <td colspan="2">
	                                <div class="form-input">
	                                    <input type="text" id="end_date" name="end_date" class="form-inputbox white js-datepicker" value="${popupVO.end_date }">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr style="display:none;" id="contentsRow">
	                            <th><label for="end_date"></label></th>
	                            <td colspan="2">
	                                <div>
	                                	<textarea id="contents" name="contents" rows="30" cols="120"><c:out value = "${popupVO.contents }" /></textarea>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>게시여부</th>
	                            <td colspan="2">
	                                <div class="clearfix wid100 sel-table">
	                                    <div class="fl">
	                                        <input type="radio" id="view_flag" name="view_flag" value="Y" <c:if test="${popupVO.view_flag eq 'Y' || popupVO.view_flag eq null}">checked</c:if>/>
	                                        <label for="sel-ypost">예</label>
	                                    </div>
	                                    <div class="fl">
	                                        <input type="radio" id="view_flag" name="view_flag" value="N" <c:if test="${popupVO.view_flag eq 'N' }">checked</c:if>/>
	                                        <label for="sel-npost">아니요</label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        </tbody>
	                    </table>
	                    <div class="defbtn-wrap">
	                    	<%if(s_type.equals("update")){ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:popup_agree('update')">수정</button>
		                        <button type="button" class="defbtn white" onclick="javascript:popup_delete();">삭제</button>
	                        <%}else{ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:popup_agree('insert')">등록</button>
		                        <button type="button" class="defbtn white" onclick="javascript:history.back();">취소</button>
	                        <%} %>
	                    </div>
	                </fieldset>

	            </form>
	            
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



