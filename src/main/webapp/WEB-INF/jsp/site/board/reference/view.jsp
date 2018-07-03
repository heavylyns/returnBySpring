<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
   		<script type="text/javascript">
			function onloading() {
				if ("<c:out value='${msg}'/>" != "") {
					alert("<c:out value='${msg}'/>");
				}
			}
			function boardListGo() {
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/policy/reference.do'/>";
				document.frm.submit();
			}
			function boardArticleGo(boardNo){
				document.frm.boardNo.value = boardNo;
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/policy/reference_view.do'/>";
				document.frm.submit();
			}
			function boardUpdateGo(){
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/policy/reference_action.do?type=update'/>";
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
								document.frm.action = "<c:url value='/site/policy/reference.do'/>";
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
		
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">자료실</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <form id="frm" name="frm" method="post" action="">
        <input type="hidden" name="boardNo" value="${result.board_no}"/>
        <input type="hidden" name="boardCode" value="01"/>
        <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
        <div class="basicboard-wrap">
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
                    <th>제목</th>
                    <td colspan="3" class="tl">${result.title}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td class="tl">
                    <!-- 임시로 써둠 -->
                    	<c:choose>
	                    	<c:when test="${result.name eq null || result.name eq ''}">
	                    		<c:out value="${result.writer}"/>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<c:out value="${result.name}"/> 
	                    	</c:otherwise>
                    	</c:choose>
                    	<!-- // -->
                    </td>
                    <th>조회수</th>
                    <td class="tl">${result.view_cnt}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td colspan="3" class="tl">${result.reg_date}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3" class="tl">
                    	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.attached_file_id}" />
						</c:import>
                    </td>
                </tr>
                <tr>
                   	<td colspan="4" class="tl">
                   		<c:out value="${result.contents}" escapeXml="false"/>
					</td>
                </tr>
                </tbody>
            </table>
            <div class="clearfix twobtnwrap tc">
            	<c:if test="${user.login_type eq 'admin'}">
                	<a href="#lnk" class="commonbtns black" onclick="javascript:boardUpdateGo();">수정</a>
                	<a href="#lnk" class="commonbtns black" onclick="javascript:boardDelete();">삭제</a>
                </c:if>
                <a href="#" onclick="javascript:boardListGo();" class="commonbtns borderblack">목록</a>
            </div>
            <div class="board-nav">
                <dl>
                    <dt class="prev">이전글</dt>
                    <c:if test="${result.prev_title ne null }">
					    <a href="#"  onclick="boardArticleGo('${result.prev_no}');">
					    	<c:out value='${result.prev_title}'/>
					    </a>
			        </c:if>
                    <c:if test="${result.prev_title eq null }">
			        	<dd>이전글이 없습니다.</dd>
			        </c:if>
                </dl>
                <dl>
                    <dt class="next">다음글</dt>
                     <c:if test="${result.next_title ne null }">
					    <a href="#"  onclick="boardArticleGo('${result.next_no}');">
					    	<c:out value='${result.next_title}'/>
					    </a>
			        </c:if>
                    <c:if test="${result.next_title eq null }">
			        	<dd>다음글이 없습니다.</dd>
			        </c:if>
                </dl>
            </div>
        </div>
        </form>
    </div>