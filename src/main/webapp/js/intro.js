
/* INTRO */
/*(function($){
    "use strict";
    $(function(){

        var $introwrap = $('.intro-wrap');
        var $introbox = $('.intro-box-wrap');
        var $introboxinner = $('.intro-box-inner');
        var $introtxtbox = $('.intro-box-txt');
        var $introbtn = $('.intro-openbtn');

        $(document).on("ready", introinit);
        $(window).on('resize', boxsize);

        function introinit(){
            boxsize();
            $introbtn.on('click', function() {
                var $this = $(this);
                introAnimate($this);
            });
            $introbtn.on('focus', btnfocus);
        }

        function boxsize (){

            var win_h = $(window).height();
            var win_w = $(window).width();

            if(GAT.VIEWPORT_WIDTH >= 1259){
                $introbox.css({
                    'width': '50%',
                    'height': win_h
                });
                $introtxtbox.css({
                    opacity: '1'
                });
                $introwrap.css({
                    'width': win_w,
                    'height': win_h
                });
                $introboxinner.css({
                    'width': $('.intro').width(),
                    'height': win_h
                });
            } else {
                $introbox.css({
                    'width': 'auto',
                    'height': win_h / 2
                });
                $introboxinner.css({
                    'width': 'auto',
                    'height': win_h / 2
                });
                $introwrap.css({
                    'width': 'auto',
                    'height': win_h
                });
            }
        }

        function introAnimate ($elem) {
            var $thisintrobox = $elem.closest($introbox);
            var $sibintrobox = $thisintrobox.siblings($introbox);
            var $thistxtbox = $thisintrobox.find($introtxtbox);
            var $sibtxtbox = $sibintrobox.find($introtxtbox);

            TweenMax.to($thisintrobox, 0.8, {width:"90%", ease:Expo.easeOut});
            TweenMax.to($sibintrobox, 0.8, {width:"10%", ease:Expo.easeOut});
            TweenMax.to($thistxtbox, 0.8, {opacity:"1", ease:Expo.easeOut});
            TweenMax.to($sibtxtbox, 0.8, {opacity:"0", ease:Expo.easeOut});
        }

        function btnfocus (){
            var $this = $(this);
            introAnimate($this);
        }

    })
})(jQuery);*/

/* INTRO height */
(function($){
    "use strict";
    $(function(){

        var $introbox = $('.intro-box');

        $(document).on("ready", introinit);
        $(window).on('resize', introinit);

        function introinit(){
            var win_h = $(window).outerHeight();
            if(GAT.IS_VIEWTYPE == 'mobile'){
                $introbox.css("height", win_h / 2);
            } else {
                $introbox.css("height", win_h);
            }
        }

    })
})(jQuery);


