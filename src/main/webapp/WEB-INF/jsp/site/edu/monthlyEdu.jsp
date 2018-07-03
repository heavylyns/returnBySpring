<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   	
	
<script type="text/javascript">

	var calendarArray = new Array();
	
	<c:forEach items="${eduList}" var="makeCalendar" varStatus="statusCal">
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
        var $calwrap = $('.monthcal-js');
        $calwrap.fullCalendar({
            lang : "ko",
            height: "auto",
            fixedWeekCount : false,
            events: calendarJson
        });

        
        init();
        /* //레이어팝업 스크립트*/
    });
    /*레이어팝업 스크립트*/
    function init() {
    	var $calwrap = $('.monthcal-js');
        var $layer, clickLayer, $evtbtn;

        function calinit() {

            addEvt();
            $(".fc-button-group > button").on("click", moveCalFn);

            function addEvt() {
                $evtbtn = $(".evtbtn");
                var $closebtn = $(".closebtnjs");
                $layer = $(".overlayerjs");
                clickLayer = $(".clicklayerjs");
                $evtbtn.on("click", overFn);
                $layer.find("td > a").on("click", infoLayerOpen);
                $closebtn.on("click", infoLayerClose);

                $layer.find("tr:last-child > td:last-child > a").on("keydown", lastKeydownFn);
            }


            function moveCalFn() {
                $layer.removeClass("active");
                clickLayer.removeClass("active");
                $calwrap.append($layer);
                $calwrap.append(clickLayer); 
                addEvt();
            }

            function overFn() { //mouseover 1차 레이어팝업 show
                var $this = $(this);
                var date = $this.text();
                var resultString ="";
                var param = "standard_date="+date;
               
				$.ajax({
					url : "/site/edu/regionalEduDataByDate.do"
					, dataType : 'json'
					, data : param
					, contentType: "application/json; charset=utf-8"
					, async : false
					, success : function(data) {
						$("#eduTitleTable").remove();
						$("#eduInfoLayer").remove();
						resultString += '<table class="basicboard-tbl no-thead" id="eduTitleTable">';
						resultString += '<caption>이달의 교육정보</caption>';
						resultString += '<colgroup>';
						resultString += '<col style="width:100%;"/>';
						resultString += '</colgroup>';
						resultString += '<tbody>';
						$.each(data.resultList, function (index, item) {
							resultString += '<tr>';
							//resultString += '<td><a href="javascript:infoLayerOpen('+item.educationNo+')" value="'+item.educationNo+'">'+item.educationName+'</a></td>';
							resultString += '<td><a href="#lnk" id="eduInfoGo_'+index+'" value="'+item.educationNo+'">'+item.educationName+'</a></td>';
							resultString += '</tr>';
						});
						resultString += '</tbody>';
						resultString += '</table>';
						resultString += '<div class="clicklayer clicklayerjs"  tabindex="0" id="eduInfoLayer" >';
						resultString += '</div>';
						$("#eduTitleLayer").append(resultString);
						
					}
					, error : function(xhr, status, err) {
	    				alert('통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.'+status+"=="+err);
					}
				});
                
                $layer = $(".overlayerjs");
                clickLayer = $(".clicklayerjs");
                $layer.find("td > a").on("click", infoLayerOpen);
                
                
                
				
                $this.closest("td").append($layer);
                $layer.addClass("active");
                $layer.on("mouseleave", leaveFn);
            }

            function leaveFn() { //mouseleave 1차 레이어팝업 hide
                var $this = $(this);
                $this.removeClass("active");
                //clickLayer.removeClass("active");
                $("#eduInfoLayer").removeClass("active");
            }


            function infoLayerClose() { // click 2차 레이어팝업 hide
                clickLayer.removeClass("active");
            }

            function lastKeydownFn(e) {
	            if(e.keyCode == 9 && !e.shiftKey) {
	                $layer.removeClass("active");
	                clickLayer.removeClass("active");
	            }
            }
            
            function infoLayerOpen(e) {  // click 2차 레이어팝업 show
            	var $this = $(this);
            	var resultString ="";
            	var targetId = e.target.id;
            	var eduNo = $("#"+targetId).attr('value');
         	   var param = "education_no="+eduNo;
                
         		$.ajax({
         			url : "/site/edu/regionalEduDataByDateInfo.do"
         			, dataType : 'json'
         			, data : param
         			, contentType: "application/json; charset=utf-8"
         			, async : false
         			, success : function(data) {
         				$("#eduInfoTable").remove();
         				
         				resultString += '<table class="basicboard-tbl no-thead" id="eduInfoTable">';
         				resultString += '<caption>이달의 교육정보</caption>';
         				resultString += '<colgroup>';
         				resultString += '<col style="width:30%;"/>';
         				resultString += '<col style="width:70%;"/>';
         				resultString += '</colgroup>';
         				resultString += '<tbody>';
         				$.each(data.resultList, function (index, item) {
         					resultString += '<tr>';
         					resultString += '<th scope="row">교육명</th>';
         					resultString += '<td>'+item.educationName+'</a></td>';
         					resultString += '</tr>';
         					resultString += '<tr>';
         					resultString += '<th scope="row">교육기간</th>';
         					resultString += '<td>'+item.educationStart+' ~ '+item.educationEnd+'</a></td>';
         					resultString += '</tr>';
         					resultString += '<tr>';
         					resultString += '<th scope="row">문의</th>';
         					resultString += '<td>'+item.rEduTel+'</a></td>';
         					resultString += '</tr>';
         					resultString += '<tr>';
         					resultString += '<th scope="row">교육내용</th>';
         					resultString += '<td>'+item.rEduSummary+'</a></td>';
         					resultString += '</tr>';
         				});
         				resultString += '</tbody>';
         				resultString += '</table>';
         				resultString += '<a href="#lnk" class="layerclose-btn closebtnjs"><span class="screen_out">닫기</span></a>';
         				//resultString += '</div>';
         				$("#eduInfoLayer").append(resultString);
         				//$this.closest("td").append(resultString);
         			}
         			, error : function(xhr, status, err) {
         				alert('통신 오류가 발생했습니다. 잠시후 다시 시도해 주십시요.'+status+"=="+err);
         			}
         		});
         		

                $layer.find("tr:last-child > td:last-child > a").on("keydown", lastKeydownFn); 
         		
                 $this.closest("td").append($("#eduInfoLayer"));
                 clickLayer.addClass("active");
                 
             } 
            
        }
   
        calinit();
    }
  
</script>

	
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">이달의 교육</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="month-calwrap">
            <div class="calendarwrap">
                <div class="monthcal-js ">
                </div>
                <p class="caldesc"><span>클릭 시 상세 교육일정이 조회됩니다.</span></p>
            </div>
            <!--클릭시 레이어 팝업-->
            <div class="overlayer overlayerjs" tabindex="0" id="eduTitleLayer">
            </div>
        </div>
    </div>
