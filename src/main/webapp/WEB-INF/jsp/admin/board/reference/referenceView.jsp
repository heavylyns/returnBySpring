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
		</script>
		
		<div class="container" id="container">
			<div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">게시판 관리</a></li>
			        <li class="active">자료실</li>
			    </ul>
			</div>
			<h3 class="subcont-tit">자료실</h3>
			<div class="contents">
		
				<form name="frm" id="frm" method="post" action="">
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
					<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
					<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
					<input type="hidden" name="boardCode" value='${result.board_code }'/>
					<input type="hidden" id="boardNo" name="boardNo" value='${result.board_no }'/>
					<input type="hidden" id="writer" name="writer" value='${curAdmin.name }'/>
					
										
			        <fieldset>
			            <legend class="screen_out">자료실 입력</legend>
			            <table class="tbl tc no-thead write">
			                <caption>자료실 입력</caption>
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
			                    	<c:out value='${result.title}'/>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="inp-writer">작성자</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.name}'/>
			                    </td>
			                    <th><label for="inp-writer">조회수</label></th>
			                    <td class="tl">
			                    	<c:out value='${result.view_cnt}'/>
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
									</c:import> 
			                    </td>
			                </tr>
			                <tr>
			                    <th style="height:300px;"><label for="inp-txt">내용</label></th>
			                    <td class="tl" colspan="3">
			                    		<c:out value='${result.contents}' escapeXml="false"/>
			                    </td>
			                </tr>
			               <tr>
			                    <th><label for="inp-writer">이전글</label></th>
			                    <td class="tl" colspan="3">
			                    	<c:if test="${result.prev_title ne null }">
				                    	<a href="#"  onclick="boardArticleGo('${result.prev_no}','${result.board_code}');">
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
			                    <td class="tl" colspan="3">
			                    	<c:if test="${result.next_title ne null }">
				                    	<a href="#"  onclick="boardArticleGo('${result.next_no}','${result.board_code}');">
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
			            	<c:if test="${fn:contains(curAdmin.menuIds, '[313]')}">
						    	<button type="button" class="defbtn white" onclick="javascript:boardUpdateGo();">수정</button>
						        <button type="button" class="defbtn pink" onclick="javascript:boardDelete();">삭제</button>
					        </c:if>
				            <button type="button" class="defbtn white" onclick="javascript:boardListGo('${result.board_code }', '${searchVO.pageIndex}');">목록</button>
			            </div>
			        </fieldset>
			    </form>
			</div>
		</div>
					