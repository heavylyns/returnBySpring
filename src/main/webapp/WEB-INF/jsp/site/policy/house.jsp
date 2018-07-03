<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    

	<script type="text/javascript">
		var calendarArray = new Array();
		
		<c:forEach items="${houseDateData}" var="makeCalendar" varStatus="statusCal">
			var calendarInfo = new Object();
			calendarInfo.education_no = "${makeCalendar.education_no}";
			calendarInfo.title = "${makeCalendar.education_name}";
			calendarInfo.start = "${makeCalendar.education_start}";
			calendarInfo.end = "${makeCalendar.education_end}";
			calendarArray.push(calendarInfo);
		</c:forEach>
		
		var calendarJson = [];
		for (var i = 0; i < calendarArray.length; i++) {
			calendarJson.push({
				id : calendarArray[i].education_no,
				title : calendarArray[i].title,
				start : calendarArray[i].start,
				end : calendarArray[i].end
			})
		}
		
		$(document).ready(function() {
	        $('.housecalendar-js').fullCalendar({
	            lang : "ko",
	            height: "auto",
	            fixedWeekCount : false,
	            events: calendarJson
	        });
	    })

	</script>
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">귀농인의 집</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="housewrap">
            <div class="greentab-wrap">
                <ul class="greentab">
                    <li <c:if test="${param.houseNo eq '01'}">class="active"</c:if>><a href="/site/policy/house.do?houseNo=01">현북면 명지리 귀농인의 집</a></li>
                    <li <c:if test="${param.houseNo eq '02'}">class="active"</c:if>><a href="/site/policy/house.do?houseNo=02">강현면 방축리 귀농인의 집</a></li>
                </ul>
            </div>
            <div class="housecon-wrap">
            	<%-- 귀농인의집 1 --%>
            	<c:if test="${param.houseNo eq '01'}">
	                <div class="housecon">
	                    <div class="imgarea">
	                       	<img src="/image/support/farmhouse-img1.gif" alt=""/>
	                    </div>
	                    <div class="houseinfo-wrap">
	                        <p class="housedesc">
	                            현북면 명지리 귀농인의 집
	                            <span>산좋고 물맑은 강원도 춘천시에 위치한 전원주택입니다. </span>
	                            <span>나무로 만들어진 주택으로 계단옆에 멋지게 자란 소나무가 있고 주택을 새롭게 리모델링해서 편안하게 이용 가능하십니다.
	                            주변에 홍천강이 흐르고 있고 여름엔 물놀이와 낚시가 가능하 시고 다슬기도 채취가능해서 가족단위로도 놀러오시기 딱 좋습니다.</span>
	                        </p>
	                        <div class="houseinfo">
	                            <p class="infotxt"><span>전화번호</span> 000-0000-0000</p>
	                            <p class="infotxt"><span>주소</span> 강원 양양군 현북면 송이로 588-36 (명지리 236번지)</p>
	                        </div>
	                    </div>
	                </div>
	            </c:if>
	            <%-- 귀농인의집 1 끝 --%>
	            <%-- 귀농인의집 2 --%>
	            <c:if test="${param.houseNo eq '02'}">
		            <div class="housecon">
	                    <div class="imgarea">
	                        <img src="/image/support/farmhouse-img1.gif" alt=""/>
	                    </div>
	                    <div class="houseinfo-wrap">
	                        <p class="housedesc">
	                            강현면 방축리 귀농인의 집
	                            <span>산좋고 물맑은 강원도 춘천시에 위치한 전원주택입니다. </span>
	                        <span>나무로 만들어진 주택으로 계단옆에 멋지게 자란 소나무가 있고 주택을 새롭게 리모델링해서 편안하게 이용 가능하십니다.
	                            주변에 홍천강이 흐르고 있고 여름엔 물놀이와 낚시가 가능하 시고 다슬기도 채취가능해서 가족단위로도 놀러오시기 딱 좋습니다.</span>
	                        </p>
	                        <div class="houseinfo">
	                            <p class="infotxt"><span>전화번호</span> 000-0000-0000</p>
	                            <p class="infotxt"><span>주소</span> 강원 양양군 강현면 안골로 237 (방축리 154번지)</p>
	                        </div>
	                    </div>
	                </div>
	            </c:if>
	            <%-- 귀농인의집 2 끝 --%> 
                <div class="calendarwrap">
                    <div class="housecalendar-js ">
                    </div>
                    <p class="caldesc"><span>표시된 날짜에 교육이 진행됩니다.</span></p>
                </div>
            </div>
        </div>
    </div>
