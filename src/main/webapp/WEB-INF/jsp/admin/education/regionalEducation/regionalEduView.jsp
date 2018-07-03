<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
	String s_bbsId2 = "";	// 게시판관리 > 게시판ID
	if(request.getParameter("bbsId") != null && request.getParameter("bbsId") != ""){
		s_bbsId2 = request.getParameter("bbsId");
	}
%>

		
		<script type="text/javascript">
			function onloading() {
				if ("<c:out value='${msg}'/>" != "") {
					alert("<c:out value='${msg}'/>");
				}
			}
		

			
			function regionalEduListGo(pageNo) {
				document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
				document.frm.submit();
			}
			function regionalEduArticleGo(eduNo){
				$("#r_edu_no").val(eduNo);
				document.frm.r_edu_no.value = eduNo;
				document.frm.action = "<c:url value='/admin/education/selectRegionalEduArticle.do'/>";
				document.frm.submit();
			}
			function regionalEduUpdateGo(){
				
				document.frm.action = "<c:url value='/admin/education/regionalEduUpdatePage.do'/>";
				document.frm.submit();
			}
			function referenceDelete(){
				var frm = $("#frm")[0];
				var formData = new FormData(frm);
				
				if(confirm("삭제 하시겠습니까?")){
					$.ajax({
						type : "post",
						cache : false,
						url : "/admin/education/regionalEduDelete.do",
						data: formData,
						async   : false,
						processData: false,
						contentType : false,
						success : function(data) {
							if (data.count >= 1) {
								alert("삭제했습니다.");
								
								document.frm.method = "post";
								document.frm.action = "<c:url value='/admin/education/selectRegionalEduList.do'/>";
								document.frm.submit();
							}else{
								alert("삭제하지 못했습니다.")
							}
						},
						error : function(xhr, status, err) {
							alert('아이디 조회시 통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.' + status + "==" + err);
						}
					}); 
				}
				/* document.frm.action = "<c:url value='/admin/education/regionalEduDelete.do'/>";
				document.frm.submit(); */
			}
		</script>
		
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">게시판 관리</a></li>
			        <li class="active">시군별 교육</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">시군별 교육</h3>
			<div class="contents">
			
				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" id="r_edu_no" name="r_edu_no" value='${result.r_edu_no }'/>
					
			        <fieldset>
			            <legend class="screen_out">시군별 교육 상세</legend>
			            <table class="tbl tc no-thead write">
			                <caption>시군별 교육 상세</caption>
			                <colgroup>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                    <col style="width:25%;"/>
			                </colgroup>
			                <tbody>
			                <tr>
			                    <th><label for="inp-title" colspan="2">제목</label></th>
			                    <td class="tl" colspan="3">
			                    	<%-- <input type="text" id="inp-title" name="inp-title" class="form-inputbox" value="${result.nttSj}"/> --%>
			                    	<c:out value='${result.r_edu_title}'/>
			                    </td>
			                </tr>
			                <tr>
	                            <th><label for="start_date">교육기간</label></th>
	                            <td class="tl"  colspan="3">
	                                <c:out value="${result.r_edu_start }"/> ~ <c:out value="${result.r_edu_end }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육장소</label></th>
	                            <td class="tl"  colspan="3">
	                                <c:out value="${result.r_edu_place }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">전화번호</label></th>
	                            <td class="tl"  colspan="3">
	                                <c:out value="${result.r_edu_tel }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="start_date">교육내용</label></th>
	                            <td class="tl"  colspan="3">
	                                <c:out value="${result.r_edu_summary }"/>
	                            </td>
	                        </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.name}'/>
			                    </td>
			                    <th><label for="inp-writer">지역</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.region_name}'/>
			                    </td>
			                </tr>
			                <tr>
			                    <th>등록일</th>
			                    <td class="tl" colspan="3">${result.reg_date}</td>
			                </tr>
			                <tr>
			                    <th><label for="inp-file">첨부파일</label></th>
			                    <td class="tl" colspan="3">
				                    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.attached_file_id}" />
										<c:param name="returnUrl" value="/admin/education/regionalEduUpdatePage.do"/>
									</c:import> 
			                    	<!-- <input type="file" id="inp-file" name="inp-file" class="wid100"/> -->
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;" ><label for="inp-txt">내용</label></th>
			                    <td class="tl" colspan="3">
			                    	<%-- <textarea name="inp-txt" id="inp-txt" cols="30" rows="15" class="wid100 inptxt">${result.nttCn}</textarea> --%>
			                    		<c:out value='${result.r_edu_contents}' escapeXml="false"/>
			                    </td>
			                </tr>
			               <tr>
			                    <th><label for="inp-writer">이전글</label></th>
			                    <td class="tl" colspan="3">
			                    	<c:if test="${result.prev_title ne null }">
				                    	<a href="#"  onclick="javascript:regionalEduArticleGo('${result.prev_no}');">
				                    		<c:out value='${result.prev_title}'/>
				                    	</a>
			                    	</c:if>
			                    	<c:if test="${result.prev_title eq null }">
			                    		이전글이 없습니다.
			                    	</c:if>
			                    </td>
			                </tr>
			                <tr>
			                    <th ><label for="inp-writer">다음글</label></th>
			                    <td class="tl" colspan="3">
			                    	<c:if test="${result.next_title ne null }">
				                    	<a href="#"  onclick="javascript:regionalEduArticleGo('${result.next_no}');">
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
					        <button type="button" class="defbtn white" onclick="javascript:regionalEduUpdateGo();">수정</button>
					        <button type="button" class="defbtn pink" onclick="javascript:referenceDelete();">삭제</button>
			                <button type="button" class="defbtn white" onclick="javascript:regionalEduListGo('${searchVO.pageIndex}');">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					