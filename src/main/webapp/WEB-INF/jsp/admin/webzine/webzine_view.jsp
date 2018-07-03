<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%	
	// update or insert 구분값
	String s_type = request.getParameter("type");
%>
		
		<script type="text/javascript">

			function webzine_agree(v_type){
				if($("#title").val() == ""){
					alert("제목을 입력해 주세요.");			
					$("#title").focus();
					return;
				}
				if($("#link").val() == ""){
					alert("링크를 입력해 주세요.");			
					$("#link").focus();
					return;
				}
				
				if(v_type == "insert"){
					document.frm.action = "<c:url value='/admin/webzine/webzine_insert.do'/>";
				}else{
					document.frm.action = "<c:url value='/admin/webzine/webzine_update.do'/>";
				}
				document.frm.submit();
			}

			function webzine_delete(){
				if(confirm("정말로 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/webzine/webzine_delete.do'/>";
					document.frm.submit();
				}
			}

			function info_file_delete(){
				if(confirm("정말로 첨부파일을 삭제하시겠습니까?")){
					document.frm.action = "<c:url value='/admin/homep/info_file_delete.do'/>";
					document.frm.submit();
				}
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <!-- <li><a href="#lnk">홈페이지 관리</a></li> -->
			        <li class="active">웹진 관리</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">웹진 관리</h3>
			
			<div class="contents">
			
				
	            <form action="#" name="frm" id="frm" method="post" enctype="multipart/form-data">
	            	<input type="hidden" name="popup_no" value="${popupVO.popup_no }" />
	                
	                <fieldset>
	                    <legend class="screen_out">인포존 관리</legend>
	                    <table class="tbl no-thead write">
	                        <caption>인포존 입력표</caption>
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
	                            	<input type="file" id="info_file" name="info_file" class="wid100"/>
	                            	<c:if test="${file.atchFileId ne '' && file.atchFileId ne null}">
	         	                   		<img src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${file.atchFileId}"/>&fileSn=<c:out value="${file.fileSn}"/>' alt="${file.orignlFileNm}" style="width:140px;"/>
	                            	</c:if>
	                            </td>
	                            <td class="table-btn"><button type="button" class="defbtn pink valdel-btn" onclick="javascript:info_file_delete();">첨부파일 삭제</button></td>
	                        </tr>
	                        <tr>
	                            <th><label for="link">링크</label></th>
	                            <td><input type="text" id="link" name="link" class="form-inputbox" value="${popupVO.link }"/></td>
	                            <td>Http를 포함해서 넣어주세요.</td>
	                        </tr>
	                       
	                        <tr>
	                            <th><label for="contents">대체텍스트</label></th>
	                            <td colspan="2"><input type="text" id="contents" name="contents" class="form-inputbox" value="${popupVO.contents }"/></td>
	                        </tr>
	                        <tr>
	                            <th>타겟</th>
	                            <td colspan="2">
	                                <div class="clearfix wid100 sel-table">
	                                    <div class="fl">
	                                        <input type="radio" id="target" name="target" value="_blank" <c:if test="${popupVO.target eq '_blank' || popupVO.target eq null}">checked</c:if>/>
	                                        <label for="sel-new">새창</label>
	                                    </div>
	                                    <div class="fl">
	                                        <input type="radio" id="target" name="target" value="_self" <c:if test="${popupVO.target eq '_self' }">checked</c:if>/>
	                                        <label for="sel-self">현재 페이지에서 이동</label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                       
	                        </tbody>
	                    </table>
	                    <div class="defbtn-wrap">
	                    	<%if(s_type.equals("update")){ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:webzine_agree('update')">수정</button>
		                        <button type="button" class="defbtn white" onclick="javascript:webzine_delete();">삭제</button>
	                        <%}else{ %>
		                        <button type="button" class="defbtn pink" onclick="javascript:webzine_agree('insert')">등록</button>
		                        <button type="button" class="defbtn white" onclick="javascript:history.back();">취소</button>
	                        <%} %>
	                    </div>
	                </fieldset>

	            </form>
	            
			
			</div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



