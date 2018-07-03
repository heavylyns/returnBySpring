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
				//document.frm.pageIndex.value = pageNo;
				//$("#pageIndex").val(pageNo);
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/comunity/news.do'/>";
				document.frm.submit();
			}
			function boardArticleGo(boardNo, boardCode){
				document.frm.boardNo.value = boardNo;
				document.frm.boardCode.value = boardCode;
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/comunity/news_view.do'/>";
				document.frm.submit();
			}
			function boardUpdateGo(){
				document.frm.method = "post";
				document.frm.action = "<c:url value='/site/comunity/news_action.do?type=update'/>";
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
								document.frm.action = "<c:url value='/site/comunity/news.do'/>";
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
            <p class="subdep2-tit">강원 귀농귀촌 뉴스</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <form id="frm" name="frm" method="post" action="">
        <input type="hidden" name="boardNo" value="${result.board_no}"/>
        <input type="hidden" name="boardCode" value="06"/>
        <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
        <div class="basicboard-wrap">
            <table class="basicboard-tbl view no-thead">
                <caption>글보기</caption>
                <colgroup>
                    <col style="width:20%;"/>
                    <col style="width:80%;"/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">제목</th>
                    <td class="tl">${result.title}</td>
                </tr>
                <tr>
                    <td colspan="2" class="tl">
                        <c:out value="${result.contents}" escapeXml="false" />
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="clearfix tr">
            	<c:if test="${user.login_type eq 'admin'}">
                	<a href="#lnk" class="commonbtns black onebtn" onclick="javascript:boardUpdateGo();">수정</a>
                	<a href="#lnk" class="commonbtns black onebtn" onclick="javascript:boardDelete();">삭제</a>
                </c:if>
                <a href="#" onclick="javascript:boardListGo();" class="commonbtns borderblack onebtn">목록</a>
            </div>
            <div class="board-nav">
                <dl>
                    <dt class="prev">이전글</dt>
                    <c:if test="${result.prev_title ne null }">
					    <a href="#"  onclick="boardArticleGo('${result.prev_no}','${result.board_code}');">
					    	<c:out value="${result.prev_title}"/>
					    </a>
			        </c:if>
                    <c:if test="${result.prev_title eq null }">
			        	<dd>이전글이 없습니다.</dd>
			        </c:if>
                </dl>
                <dl>
                    <dt class="next">다음글</dt>
                     <c:if test="${result.next_title ne null }">
					    <a href="#"  onclick="boardArticleGo('${result.next_no}','${result.board_code}');">
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
