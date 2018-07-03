<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src='/admin/js/libs/highcharts.js'></script>

		<script type="text/javascript">
		var datas =[];
		
		<c:forEach var="recent" items="${recentVisitorResult }" varStatus="recentStatus">
			datas.push(["${recent.visit_date}", Number("${recent.visitor_cnt}")]);
		</c:forEach>
		
		var monthlyVisitor = [];
		<c:forEach var="monthly" items="${monthlyVisitorResult }" varStatus="monthlyStatus">
			monthlyVisitor.push(["${monthly.visit_date}", Number("${monthly.visitor_cnt}")]);
		</c:forEach>
			$(document).ready(function(){

			});
			$(function () {
				   $('#chart1').highcharts({
					   chart: {
				            type: 'column'
				        },
				        title: {
				            text: '홈페이지 최근 방문객 수'
				        },
				        /* subtitle: {
				            text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
				        }, */
				        xAxis: {
				            type: 'category',
				            labels: {
				                //rotation: -45,
				                style: {
				                    fontSize: '13px',
				                    fontFamily: 'Verdana, sans-serif'
				                }
				            }
				        },
				        yAxis: {
				            min: 0,
				            title: {
				                text: 'Visitors (명)'
				            }
				        },
				        legend: {
				            enabled: false
				        },
				        tooltip: {
				            pointFormat: '방문객 수: <b>{point.y} 명</b>'
				        },
				        series: [{
				            name: '방문객',
				            data: datas,
				            dataLabels: {
				                enabled: true,
				                rotation: -90,
				                color: '#FFFFFF',
				                align: 'right',
				                format: '{point.y}', // one decimal
				                y: 10, // 10 pixels down from the top
				                style: {
				                    fontSize: '13px',
				                    fontFamily: 'Verdana, sans-serif'
				                }
				            }
				        }]
				   });
				   $('#chart2').highcharts({
					   chart: {
				            type: 'column'
				        },
				        title: {
				            text: '홈페이지 월별 방문객 수'
				        },
				        /* subtitle: {
				            text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
				        }, */
				        xAxis: {
				            type: 'category',
				            labels: {
				                //rotation: -45,
				                style: {
				                    fontSize: '13px',
				                    fontFamily: 'Verdana, sans-serif'
				                }
				            }
				        },
				        yAxis: {
				            min: 0,
				            title: {
				                text: 'Visitors (명)'
				            }
				        },
				        legend: {
				            enabled: false
				        },
				        tooltip: {
				            pointFormat: '방문객 수: <b>{point.y} 명</b>'
				        },
				        series: [{
				            name: '방문객',
				            data: monthlyVisitor,
				            dataLabels: {
				                enabled: true,
				                rotation: -90,
				                color: '#FFFFFF',
				                align: 'right',
				                format: '{point.y}', // one decimal
				                y: 10, // 10 pixels down from the top
				                style: {
				                    fontSize: '13px',
				                    fontFamily: 'Verdana, sans-serif'
				                }
				            }
				        }]
				   });
			    });
		</script>


		<div class="breadcrumb">
		    <ul>
		        <li class="home"><a href="#lnk">HOME</a></li>
		        <li><a href="#lnk">관리자</a></li>
		        <li class="active">관리자 메인페이지</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">관리자 메인페이지</h3>
		<p class="subcont-titdes tc">관리자 메인페이지입니다. </p>
		
		<div class="contents">
			<p>최근 1주간 게시물 현황</p>
			<table class="tbl no-thead">
				<caption>사업장정보</caption>
	                    <colgroup>
	                        <col style="width:20%;"/>
	                        <col style="width:30%;"/>
	                        <col style="width:20%;"/>
	                        <col style="width:30%;"/>
	                    </colgroup>
	            <tbody>
					<tr>
						<td>
							귀농인의 집
						</td>
						<td>
							
							<c:if test="${houseCnt ne null }">
								<p style="float:left;">
									<c:out value="${houseCnt.board_cnt }"/>
								</p>
								<c:if test="${houseCnt.new_flag == 'Y'}">
									<p style="font-style: italic;color: red;float:left; margin-left:15px">NEW</p>
								</c:if>	
							</c:if>
							<c:if test="${houseCnt eq null }">
								0
							</c:if>
						</td>
						<td>
							멘토에게 물어봐
						</td>
						<td>
							<c:if test="${inqueryCnt ne null }">
								<p style="float:left;">
									<c:out value="${inqueryCnt.board_cnt }"/>
								</p>
								<c:if test="${inqueryCnt.new_flag == 'Y'}">
									<p style="font-style: italic;color: red;float:left; margin-left:15px">NEW</p>
								</c:if>
							</c:if>
							<c:if test="${inqueryCnt eq null }">
								0
							</c:if>
							
						</td>
					</tr>
					<tr>
						<td>
							온라인 상담안내
						</td>
						<td>
							<c:if test="${adviceCnt ne null }">
								<p style="float:left;">
									<c:out value="${adviceCnt.board_cnt }"/>
								</p>
								<c:if test="${adviceCnt.new_flag == 'Y'}">
									<p style="font-style: italic;color: red;float:left; margin-left:15px">NEW</p>
								</c:if>
							</c:if>
							<c:if test="${adviceCnt eq null }">
								0
							</c:if>
							
						</td>
						<td>
							자유게시판
						</td>
						<td>
							<c:if test="${freeCnt ne null }">
								<p style="float:left;">
									<c:out value="${freeCnt.board_cnt }"/>
								</p>
								<c:if test="${freeCnt.new_flag == 'Y'}">
									<p style="font-style: italic;color: red;float:left; margin-left:15px">NEW</p>
								</c:if>
							</c:if>
							<c:if test="${freeCnt eq null }">
								0
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							나의 귀농귀촌이야기
						</td>
						<td>
							<c:if test="${storyCnt ne null }">
								<p style="float:left;">
									<c:out value="${storyCnt.board_cnt }"/>
								</p>
								<c:if test="${storyCnt.new_flag == 'Y'}">
									<p style="font-style: italic;color: red;float:left; margin-left:15px">NEW</p>
								</c:if>
							</c:if>
							<c:if test="${storyCnt eq null }">
								0
							</c:if>
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="chart1" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
			<div id="chart2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
			
		</div>

