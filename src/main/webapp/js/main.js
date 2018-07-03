(function($){
    "use strict";

    $(document).ready( init );
   /* $(window).on('resize', resizeInit);*/

    function init(){
        mainVisSlide();
        /*mainNewsSlide();
        mainBlogSlide();
        mainServiceSlide();*/
        if(GAT.IS_VIEWTYPE == 'mobile') {
            mainEventSlide();
            mainNoticeSlide();
            mainColumnSlide();
        }
    }



    function mainVisSlide(){
        var $slideTarget = jQuery('.mainvisSlide');
        var slide = new opSlide( $slideTarget );
        var controlobj = {};
        controlobj.nextbtn = $slideTarget.find('.next');
        controlobj.prevbtn = $slideTarget.find('.prev');
        controlobj.indi = $slideTarget.find('.op-indibox');
        controlobj.pager = $slideTarget.find('.op-pager');
        controlobj.play = $slideTarget.find('.op-play');
        controlobj.stop = $slideTarget.find('.op-stop');
        controlobj.speed = 2;
        controlobj.auto = false;
        slide.init( controlobj );

        /*   var $visualimg = $('.mainvis-item').find('img');
         var imgwidth = $visualimg.width();
         $visualimg.css('margin-left', - imgwidth / 2);
         console.log(imgwidth);*/
    }

    /* resize function */
    function resizeSet() {
        SetViewSize();
        DeivceChkFn();
        self.controlSet( basicobj );
        self.setPosition();

        if(basicobj.onMobile) { // onMobile = true
            if(GAT.IS_VIEWTYPE != 'mobile')  {
                $elemList.removeAttr('style');
                $elemContainer.removeAttr('style');
                $elemSlideContainer.removeAttr('style');
            }
        } else { //onMobile = false

        }
    }


})(jQuery);




/* MOBILE MENU */
(function($){
    "use strict";

    $(document).ready( init );

    function init(){

        var $header = $('.header-wrap');
        var $quickico = $('.quick-ico');
        var $quickcon = $('.quick-cont');
        var $mobMenubtn = $('.menu-ico');
        var $gnbwrap = $('.haeder-gnb');
        var $gnb = $(".gnb");
        var $body = $("body");
        var $dep1 = $('.dep1 > .deplnk > a');
        var $depbtn = $('.depbtn');
        var $dep2wrap = $('.dep2wrap');
        var $dep2list = $('.dep2list');
        var $gnbdep2list = $('.gnb-box').find($dep2list);
        var $searchopen = $('.searchopen');
        var $logo = $('.logo');
        var $logoimg = $('.logo').find('.webshow');
        var $this, win_w, win_h, oldviewType;
        var $parul, $parDiv;
        var gnbdpe_H = [];
        var dep2MaxHei;

        function menuinit(){
            resizeCss();
            InitCss();
            $quickico.on('click', fnquick);
            $mobMenubtn.on('click', fnMobMenu );
            $(window).on("resize", fnResize);
            $dep1.on('mouseenter focus', fnWebMenuOpen);
            $searchopen.on('click', fnsearchOpen);
            $depbtn.on('click', fnMenuList);
            $(window).on("scroll", fngnbbar);
            tabinit();
        }

        function tabinit() {
            if($('.ly-sublnb').find(".dep2.active")) {
                $('.ly-sublnb').find(".dep2.active").find(".dep3wrap").css("display", "block");
            }
        }

        function InitCss() {
            if(GAT.IS_VIEWTYPE != 'web'){
                $gnb.css('display', 'none');
            }
            $quickcon.css('top', -$quickcon.height());
            $dep2wrap.each(function(idx){
                gnbdpe_H[idx] = $dep2wrap.eq(idx).height();
            });
            dep2MaxHei = Math.max.apply(null, gnbdpe_H);
        }

        function resizeCss(){
            win_w = $(window).outerWidth();
            win_h = $(window).outerHeight();

            if(GAT.IS_VIEWTYPE == 'web'){
                $gnbwrap.on('mouseleave', fnWebMenuClose);
            }

            if(GAT.IS_VIEWTYPE == 'mobile' || GAT.IS_VIEWTYPE == 'tablet'){
                if($body.hasClass("mobgnbopen") == false){
                }
            }

            if(GAT.IS_VIEWTYPE == 'web'){
                $body.removeClass("mobgnbopen");
                $gnbwrap.find('.dep1').removeClass("active");
                $gnbwrap.find('.dep2').removeClass("active");
                $gnbwrap.find('.depwrap').removeClass("active");
                $gnbwrap.find('.dep2list').removeAttr('style');
                $gnbwrap.find('.depwrap').removeAttr('style');
                $quickico.removeClass("on");
                $header.css('margin-top', '0');
                //$quickcon.css('opacity', '0');
                $gnb.removeAttr('style');
                $gnbwrap.removeAttr('style');
            }

            $quickcon.css('top', -$quickcon.height());
            keydownEff();
            tabinit();

            if(oldviewType == GAT.IS_VIEWTYPE ) return;
            if(oldviewType == 'web' && GAT.IS_VIEWTYPE == 'tablet' || oldviewType == 'web' && GAT.IS_VIEWTYPE == 'mobile'){
                $quickcon.css('top', -$quickcon.height());
                $gnb.css("right", -win_w);
                $gnb.removeAttr('style');
                $gnb.css('display', 'none');
                $dep2list.css('display','block');
                $gnbwrap.removeClass('scrollshow');
                $gnbwrap.removeAttr('style');
                $logo.removeClass('scrollshow');
            }
            oldviewType = GAT.IS_VIEWTYPE;
        }

        function fnquick(){
            $quickico.toggleClass("on");
            if($body.hasClass('mobgnbopen')) {
                $body.removeClass("mobgnbopen");
                fnMobMenuClose();
                setTimeout(fnquickOpen, 500);
            } else {
                fnquickOpen();
                fnquickClose();
            }
        }

        function fnquickOpen(){
            if($quickico.hasClass("on")) {
                var quickH = $quickcon.height();
                $quickcon.css('top', -quickH);
                TweenMax.to($header, 0.5, {marginTop:quickH, ease:Expo.easeOut});
                //TweenMax.to($quickcon, 0.5, {opacity:1, ease:Expo.easeOut});
                $quickico.text("퀵메뉴 닫기");
            }
        }

        function fnquickClose(){
            if($quickico.hasClass("on") == false) {
                TweenMax.to($header, 0.5, {marginTop:0, ease:Expo.easeOut});
                //TweenMax.to($quickcon, 0.5, {opacity:0, ease:Expo.easeOut});
                $quickico.text("퀵메뉴 열기");
            }
        }

        function fnMobMenu(){
            $this = $(this);
            $body.toggleClass("mobgnbopen");

            if($quickico.hasClass("on")) {
                $quickico.removeClass("on");
                fnquickClose();
                setTimeout(fnMobMenuOpen, 500);
            } else {
                fnMobMenuOpen();
                fnMobMenuClose();
            }
        }

        function fnMobMenuOpen(){
            if($body.hasClass('mobgnbopen')){
                var gnb_h = $gnb.height();
                $gnb.css('height', '0');
                $gnb.css('display', 'block');
                TweenMax.to($gnb, 0.5, {height:gnb_h, ease:Expo.easeOut, onComplete:function() {
                    $gnb.css('overflow', 'visible');
                    TweenMax.killTweensOf($gnb);
                }});
            }
        }

        function fnMobMenuClose(){
            if($body.hasClass("mobgnbopen") == false) {
                $gnb.css('display', 'block');
                $gnb.css('overflow', 'hidden');
                TweenMax.to($gnb, 0.5, {height:0, ease:Expo.easeOut, onComplete:function() {
                    $gnb.css('display', 'none');
                    $gnb.css('height', 'auto');
                    $('.dep1').removeClass("active");
                    $('.depwrap').removeClass("active");
                    $('.depwrap').removeAttr('style');
                    TweenMax.killTweensOf($gnb);
                }});
            }
        }

        function fnMenuList() {
            var $this = $(this),
                $dep1 = $this.closest("li"),
                $con = $this.parent().siblings("div");
            $parul = $this.closest("ul");
            $parDiv = $parul.find(">li").find(".depwrap");
            fnGnbLiEvt( $dep1 );
            fnGnbConEvt( $this, $con );
        }

        function fnGnbLiEvt($target) {
            $target.toggleClass("active");
            if($target.hasClass("active")) {
                $parul.find("li").removeClass("active");
                $target.toggleClass("active");
            }
        }

        function fnGnbConEvt( $this, $content ) {
            $content.toggleClass("active");
            if($content.hasClass("active")) {
                $parDiv.removeClass("active").stop().slideUp("fast");
                $this.text("닫기");
                $content.stop().slideDown("fast").toggleClass("active");
            } else {
                $this.text("열기");
                $content.stop().slideUp("fast");
            }
        }

        var oldOpen_H = 0, open_H;
        var $eloldOpen = null;
        var $elgnb;
        $elgnb = {};
        $elgnb.dep1lnk = $('.dep1lnk');
        $elgnb.dep2wrap = $('.dep2wrap');
        $elgnb.dep2bg = $('.gnb-dimmd');

        function fnWebMenuOpen(){
            if(GAT.IS_VIEWTYPE == 'web'){
                $this = $(this);
                var $thisdepwrap = $this.parents('.deplnk');
                var $elopbox = $thisdepwrap.next();
                var $elopboxUl = $elopbox.find('.dep2list');
                var openObj = {};
                var speed = 0.3;
                var $html = $('html');
                $gnbwrap.addClass("menushow");
                $gnb.css('overflow', 'visible');
                if($elopbox.hasClass('active')) return;
                if($eloldOpen != null) {
                    TweenMax.killTweensOf($elopbox);
                    $elopbox.removeAttr('style');
                }
                var open_H = $elopbox.outerHeight();
                fnWebMenuClose();
                $this.addClass("on");
                $elopbox.addClass('active');
                if($eloldOpen == null) {
                    $elopbox.css({
                        'opacity': '0',
                        'height' : '0',
                        'display': 'block'
                    });
                } else {
                    TweenMax.killTweensOf( $elopbox );

                    var typeheight;
                    if($html.hasClass("webL") && $html.hasClass("ie8")){
                        typeheight = 690;
                    }
                    else if($html.hasClass("webL")){
                        typeheight = 650;
                        /*typeheight = parseInt(dep2MaxHei);*/
                    } else {
                        typeheight = oldOpen_H;
                    }

                    $elopbox.css({
                        'opacity': '1',
                        'height': typeheight,
                        'display': 'block'
                    });

                    $elopboxUl.css({
                        'opacity':'0'
                    });
                }
                if ($html.hasClass("webL") && $html.hasClass("ie8")){
                    openObj.height = 690;
                }
                else if($html.hasClass("webL")){
                    openObj.height = 650;
                    /*openObj.height = parseInt(dep2MaxHei);*/
                    console.log(dep2MaxHei)
                } else {
                    openObj.height = open_H;
                }

                openObj.opacity = 1;
                openObj.ease = Power1.easeInOut;
                gnbEffect( $elopbox, speed, openObj, $elopbox );
                if( $eloldOpen != null ) {
                    var ulOpenObj = {};
                    ulOpenObj.opacity = 1;
                    openObj.ease = Power1.easeInOut;
                    gnbEffect( $elopboxUl, speed, ulOpenObj, $elopboxUl );
                }
                oldOpen_H = open_H;
                $eloldOpen = $elopbox;
            }
        }

        function removeStyle( $target ){
            $target.removeAttr('style');
            if( !$elgnb.dep2wrap.hasClass('active') ) {
                $eloldOpen = null;
            }
        }

        function fnWebMenuClose(){
            if(GAT.IS_VIEWTYPE == 'web'){
                var $elclose = $header.find('.deplnk').siblings('.active');
                var closeObj = {};
                var speed = 0;
                closeObj.opacity = 0;
                closeObj.ease = Power1.easeInOut;
                closeObj.onComplete = removeStyle;
                closeObj.onCompleteParams = [ $elclose ];

                gnbEffect( $elclose, speed, closeObj, $elclose );
                $elclose.removeClass('active');
                $dep1.removeClass("on");
            }
        }

        function gnbEffect( $el, speed, effectObj, $elstop ){
            TweenMax.killTweensOf($elstop);
            TweenMax.to($el, speed,  effectObj);
        }

        function fnsearchOpen(){
            var $searchbox = $('.searchbox');
            $searchbox.toggleClass('on');
            if($searchbox.hasClass('on')){
                $searchopen.text("검색 닫기");
                $searchopen.addClass("on");
            } else {
                $searchopen.text("검색 열기");
                $searchopen.removeClass("on");
            }
        }

        function fngnbbar(){
            if(GAT.IS_VIEWTYPE == 'web') {
                var top = $(document).scrollTop();
                if (top > 100) {
                    $gnbwrap.addClass('scrollshow');
                    $logo.addClass('scrollshow');
                    $gnbwrap.css('height', '60px');
                } else {
                    $gnbwrap.removeClass('scrollshow');
                    $logo.removeClass('scrollshow');
                    $gnbwrap.css('height', '105px');
                }
            }
        }

        function keydownEff(){
            $('.logo > a').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                } else if(e.keyCode == 9 &&!e.shiftKey){
                    fnquick();
                }
            });
            $quickico.on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                    fnquick();
                }
            });
            $('.quick-list > li:last-child').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                } else if(e.keyCode == 9){
                    fnquick();
                }
            });
            $('.menu-ico.open').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                } else if(e.keyCode == 9){
                    fnMobMenu();
                }
            });
            $('.dep1:last-child .dep2:last-child .dep3list>li:last-child').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                } else if(e.keyCode == 9){
                    fnWebMenuClose();
                }
            });
            $('.web-sitemenu-list.lang > li:first-child > a').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                    fnquick();
                }
            });
            $('.dep1list>li:first-child > .deplnk > a').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                    fnWebMenuClose();
                }
            });
            $('.searchbox-btn').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                } else if(e.keyCode == 9){
                    $('.searchbox').removeClass('on');
                    $searchopen.removeClass("on");
                }
            });
            $('.searchopen').on('keydown', function(e){
                if(e.shiftKey && e.keyCode == 9) {
                    $('.searchbox').removeClass('on');
                    $searchopen.removeClass("on");
                }
            });
            $('.skip').find('a').on('keydown', function(e){
                if(e.keyCode == 13) {
                    $('html, body').stop().animate({
                        scrollTop: '0'
                    }, 1);
                    console.log(e.keyCode);
                }

            });
        }

        function fnResize() {
            var timeout = null;
            setTimeout(resizeCss, 25);
            //clearTimeout(timeout);
        }

        menuinit();

    }
})(jQuery);

/* TOP button scroll */
(function($){
    "use strict";
    $(function(){

        $(document).on('ready', initpos);
        $(window).on('resize', initpos);

        function initpos(){
            var $topbtn = $('.scrollTop-btn');
            var $footerwrap = $('.scrollTop');
            var pdsize;
            if(!$footerwrap.length || !$topbtn.length) return;

            if(GAT.IS_VIEWTYPE == 'web'){
                pdsize = 30;
            } else {
                pdsize = 20;
            }
            $footerwrap.css({
                "right":$('.footerbot-wrap').offset().left + pdsize
            });

            $(window).scroll(function (){
                var top = $(document).scrollTop();
                if(top > 100) {
                    $footerwrap.stop().animate({"bottom":20}, 250);
                } else {
                    $footerwrap.stop().animate({"bottom":-200}, 250);
                }
            });
            $topbtn.on('click', windowscTop)
        }

        function windowscTop(){
            $('html, body').stop().animate({
                scrollTop: '0'
            }, 300)

        }

    });
})(jQuery);