<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href='/css//fullcalendar/fullcalendar.css' rel='stylesheet' />
<script src='/admin/js/fullCallendar/lib/moment.min.js'></script>
<script src='/admin/js/fullCallendar/fullcalendar.js'></script>
<script src='/admin/js/fullCallendar/fullcalendar.min.js'></script>
<script src="/js/libs/fullcalendar/ko.js"></script>


		
		<script type="text/javascript">
 		var calendarArray = new Array();
		
		<c:forEach items="${resultList }" var="makeCalendar" varStatus="statusCal">
			var calendarInfo = new Object();
			calendarInfo.education_no = "${makeCalendar.education_no}";
			calendarInfo.title = "${makeCalendar.education_name}";
			calendarInfo.start = "${makeCalendar.education_start}";
			calendarInfo.start_year = "${makeCalendar.education_start_year}";
			calendarInfo.start_month = "${makeCalendar.education_start_month}";
			calendarInfo.start_day = "${makeCalendar.education_start_day}";
			calendarInfo.end = "${makeCalendar.education_end2}";
			calendarInfo.end_year = "${makeCalendar.education_end_year}";
			calendarInfo.end_month = "${makeCalendar.education_end_month}";
			calendarInfo.end_day = "${makeCalendar.education_end_day}";
			calendarArray.push(calendarInfo);
		</c:forEach>
		var calendarJson = [];
			for(var i=0; i<calendarArray.length ; i++){
				calendarJson.push({id : calendarArray[i].education_no,
					            title : calendarArray[i].title,
							    start : calendarArray[i].start,
						          end : calendarArray[i].end
				})
			} 

			
		
			$(document).ready(function() {
				
				$("#house_code").change(function(){
					/* var admin_id = $(this).val()
					location.href = "/admin/homep/homep_author.do?id=" + admin_id; */
					$("#admin_form").submit();
				});
				
				
				
				var date = new Date();
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();
				
				$('#calendar').fullCalendar({
					lang : "ko",
					editable : false,
					eventLimit: true,
					events :  calendarJson,
					eventClick: function(calEvent, jsEvent, view) {
				        returnHouseArticleGo(calEvent.id);
				    }
				});

			});
			
			function returnHouseAddGo(){
				document.admin_form.action = "<c:url value='/admin/education/returnHouseAddPage.do'/>";
				document.admin_form.submit();	
			}
			function returnHouseArticleGo(education_no){
				$("#education_no").val(education_no);
				document.frm.action = "<c:url value='/admin/education/returnHouseUpdatePage.do'/>";
				document.frm.submit();
			}
		</script>




		<div class="container" id="container">
	
	        <div class="breadcrumb">
			    <ul class="">
			        <li class="home"><a href="#lnk">HOME</a></li>
			        <li><a href="#lnk">교육관리</a></li>
			        <li class="active">귀농인의 집</li>
			    </ul>
			</div>
			
			<h3 class="subcont-tit">귀농인의 집</h3>
			
			<div class="contents">
			
				
	            <form name="admin_form" id="admin_form" method="post" action="/admin/education/selectReturnHouse.do"  enctype="multipart/form-data">
					
	            
			        <div class="newfran-firbox sel-author clearfix">
			            <div class="search-box fl sel-basic">
			                <!-- <label for="sel-admin" class="fl">관리자 선택</label> -->
			                <select name="house_code" id="house_code" class="fl">
			                    <option value="01" <c:if test="${houseCode eq '01'}">selected="selected"</c:if>>귀농인의 집1</option>
			                    <option value="02" <c:if test="${houseCode eq '02'}">selected="selected"</c:if>>귀농인의 집2</option>
			                </select>
			            </div>
			        </div>
				</form>
				<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
			    <input type="hidden" name="education_no" id="education_no">
			    </form>
			        <table class="tbl author-table">
			            <caption>귀농인의 집</caption>
			            <colgroup>
			                <col style="width:5%"/>
			                <col style="width:30%"/>
			                <col style="width:30%"/>
			                <col style="width:15%"/>
			                <col style="width:20%"/>
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>No.</th>
			                    <th>교육명</th>
			                    <th>교육기간</th>
			                    <th>작성자</th>
			                    <th>등록일</th>
			                </tr>
			            </thead>
			            <tbody class="tc">
			                <c:if test="${resultList ne null }">
			                	<c:forEach items="${resultList }" var="result" varStatus="status">
					                <tr>
					                	<td><c:out value="${result.rownum }"/></td>
					                	<td><a href="javascript:returnHouseArticleGo('${result.education_no }');"><c:out value="${result.education_name }"/></a></td>
					                	<td><c:out value="${result.education_start }"/> ~ <c:out value="${result.education_end }"/></td>
					                	<td><c:out value="${result.name }"/></td>
					                	<td><c:out value="${result.reg_date }"/></td>
					                </tr>
					            </c:forEach>
			                </c:if>
			                <c:if test="${resultList eq null }">
			                	<tr>
			                		<td colspan="5">등록된 귀농인의 집이 없습니다.</td>
			                	</tr>
			                </c:if>
			            </tbody>
			        </table>
			        <div class="pager">
						<div class="tabletshow">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="referenceListGo" />
					    </div>
				    </div>
				<div class="clearfix">
		    		<a href="javascript:returnHouseAddGo();" class="message form-line-btn defbtn pink fr">등록하기</a>
		        </div>
			
			</div>
			
			<div id='calendar' style='margin: 3em 0; font-size: 13px'></div>
			<!-- //contents 종료 -->
		</div>
		<!-- //container 종료 -->



