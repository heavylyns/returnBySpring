/**
 * Created by MA on 2016-11-15.
 */

/*GNB script*/
(function($) {

    $(document).on("ready", gnbInit);

    function gnbInit(){

        var $header = $(".header");
        var $headerBg = $('.gnb-dimed');
        var $gnbDep2 = $('.gnbdep2');
        var gnbdpe_H = [];
        var dep2MaxHeight;
        var $gnb = $('.gnb');
        var $gnbDep1Lnk = $gnb.find('li>a');
        var $openTarget = $('.dep2wrap');
        var moveElemobj = [];
        var moveElemLen;
        var $gnbLastLnk = $gnb.find(">li:last-child ul li:last-child a");

        /* 열림 효과 */
        function menuOpen(){
            TweenMax.killTweensOf(moveElemobj);
            TweenMax.to(moveElemobj, 0.7, { height: parseInt(dep2MaxHeight + 21), ease: Expo.easeOut });
        }

        /* 닫힘 효과 */
        function menuClose(){
            TweenMax.killTweensOf(moveElemobj);
            TweenMax.to(moveElemobj, 0.7, { height: 0, ease: Expo.easeOut });
        }

        /* add event */
        function add_Evt(){
            $gnbDep1Lnk.on('mouseenter focus', menuOpen);
            $gnbLastLnk.on("keydown", lastLnkFn);
            $header.on('mouseleave', menuClose);
        }

        /* gnb dpe2 bg size */
        function setCss(){
            $gnbDep2.each(function(idx){
                gnbdpe_H[idx] = $gnbDep2.eq(idx).height();
            });
            dep2MaxHeight = Math.max.apply(null, gnbdpe_H);
            $headerBg.css({
                'height': 0
            });
            $gnbDep2.css({
                'height': 0
            });
        }

        function lastLnkFn(e) {
            if(e.keyCode == 9 && !e.shiftKey) {
                menuClose();
            }
        }

        /* init */
        function init() {
            setCss();
            add_Evt();
            moveElemobj.push($openTarget);
            moveElemobj.push($headerBg);
            moveElemobj.push($gnbDep2);
            moveElemLen = moveElemobj.length;
        }
        init();
    }
})(jQuery);
/* //GNB script*/


/* main vis script*/
(function($) {
    $(document).on("ready", init);

    function init() {
        mainVisSlide();
        webzineSlide();
    }

    function mainVisSlide(){
        var $slideTarget = jQuery('.mainvisslidejs');
        var slide = new opSlide( $slideTarget );
        var controlobj = {};
        controlobj.nextbtn = $slideTarget.find('.next');
        controlobj.prevbtn = $slideTarget.find('.prev');
        controlobj.indi = $slideTarget.find('.op-indibox');
        controlobj.pager = $slideTarget.find('.op-pager');
        controlobj.play = $slideTarget.find('.op-play');
        controlobj.stop = $slideTarget.find('.op-stop');
        controlobj.speed = 2;
        controlobj.auto = true;
        slide.init( controlobj );
    }

    /*function mainQuickSlide(){
        var $slideTarget = jQuery('.quickslidejs');
        var slide = new bsSlide( $slideTarget );
        function loadslide(){
            var controlobj = {};
            controlobj.nextbtn = $slideTarget.find('.bas-next');
            controlobj.prevbtn = $slideTarget.find('.bas-prev');
            controlobj.stopbtn = $slideTarget.find('.bs-stop');
            controlobj.playbtn = $slideTarget.find('.bs-play');
            controlobj.speed = 1.2;
            controlobj.viewLen = [5,5,5];
            controlobj.totmove = false;
            slide.init( controlobj );
        }
        loadslide();
    }*/

    function webzineSlide(){
        var $slideTarget = jQuery('.webzineslidejs');
        var slide = new bsSlide( $slideTarget );
        function loadslide(){
            var controlobj = {};
            controlobj.nextbtn = $slideTarget.find('.bas-next');
            controlobj.prevbtn = $slideTarget.find('.bas-prev');
            controlobj.stopbtn = $slideTarget.find('.bs-stop');
            controlobj.playbtn = $slideTarget.find('.bs-play');
            controlobj.speed = 1.2;
            controlobj.viewLen = [1,1,1];
            controlobj.totmove = false;
            slide.init( controlobj );
        }
        loadslide();
    }
})(jQuery);
/* //main vis script*/



/*

*/
/* select 디자인 script *//*

(function($) {
    $(document).on("ready", init);

    function init() {
        $('.jqlistjs').jqListBox('init');
    }
})(jQuery);
*/
/* //select 디자인 script *//*


*/





/* label hide script */
(function($){
    $(function(){
        $('.js-label-hide').each(function(){
            $(this).siblings('input').on({
                focusin : function(){
                    $(this).siblings('label').addClass('hide');
                },
                focusout : function(){
                    if(!$(this).val()){
                        $(this).siblings('label').removeClass('hide');
                    }
                }
            })
        });
    })
})(jQuery);
/* //label hide script */


/* tab script */
(function($) {
    $(document).on("ready", init);

    function init() {

        var $alltab, $tabbtnwrap;

        function tabinit() {
            $alltab = $(".tab-js");
            $tabbtnwrap = $alltab.find(".tbtnwrap-js");
            var $clickbtn = $tabbtnwrap.find("a");
            $clickbtn.on("click", tabClickFn);
        }

        function tabClickFn() {
            var $this = $(this),
                $thisPar = $this.parent(),
                $thisidx = $thisPar.index(),
                $conwrap = $this.parents(".tab-js").find(".tabconwrap-js");

            $tabbtnwrap.find("li").removeClass("active");
            $thisPar.addClass("active");

            $conwrap.each(function(i,e) {
                var $this = $(this),
                    $tabcon = $this.find(".tabcon-js");
                $(".tabcon-js").removeClass("active");
                $tabcon.eq($thisidx).addClass("active");
            });
        }

        tabinit();
    }
})(jQuery);
/* //tab script */


/* skip script */
(function($) {
    $(document).on("ready", init);
    function init() {
        $(".skip").on("click", function() {
            $("#container").attr("tabindex", 0);
        })
    }
})(jQuery);
/* //skip script */



(function($){
    "use strict";
    $(function(){
        var $datepicker = $('.js-datepicker');
        if(!$datepicker.length) return;
        $datepicker.datepicker({
            setDate:'today',
            inline: true,
            showOtherMonths: true,
            dateFormat: 'yy-mm-dd',
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            showOn: "button",
            buttonImage: "/image/common/ico-calender.png",
            buttonImageOnly: true,
            buttonText: "calendar"
        });
    });
})(jQuery);



/* 시군별 이달의 교육 checkbox */
(function($) {
    $(document).on("ready", init);

    function init() {

        var $chkbtn, $showCon;
        function chkinit() {
            $chkbtn = $(".chkbtnjs");
            $showCon = $(".chkhidejs-wrap");
            $chkbtn.on("click", chkShowFn);

            if($chkbtn.prop("checked")) {
                $showCon.show();
            } else {
                $showCon.hide();

            }
        }

        function chkShowFn() {
           var $this = $(this);
            if($this.prop("checked")) {
                $showCon.show();
            } else  {
                $showCon.hide();
            }
        }

        chkinit();
    }
})(jQuery);
/* //시군별 이달의 교육 checkbox */