

$(document).ready(customUIinit);

function customUIinit(){

    // 체크박스 라디오버튼 디자인 바인딩
    var $checkbox = $('input.iCheck-default');
    if($checkbox.length) {
        $checkbox.iCheck({
            checkboxClass: 'icheckbox_minimal',
            radioClass: 'iradio_minimal',
            increaseArea: '20%',
            aria: true
        });
    }

    //셀렉트 디자인 바인딩
    $('.subselect-jqListbox').find('select').jqListBox('init');

    //커스텀 셀렉트에 연결된 label 포커스
    $('label').on('click',function(e){
        var $customeSelect = $('[data-origin="'+ $(this).attr('for') +'"]');

        if( $customeSelect.length ){
            e.preventDefault();
            $customeSelect.find('.jqListBox-combo').focus();
        }
    });

}

$(function(){
    $('.js-label-hide').each(function(){
        $(this).next('input, textarea').on({
            focusin : function(){
                $(this).prev('label').addClass('hide');
            },
            focusout : function(){
                if(!$(this).val()){
                    $(this).prev('label').removeClass('hide');
                }
            }
        })
    });
});

/* slide  */
function efftoogleopen (){

    this.listOpen = function ( $target ){
        $target.stop().slideDown(function(){
            $target.attr('style','').css('display','block')
        });
    };

    this.listClose = function ( $target ){
        $target.stop().slideUp(function(){
            $target.attr('style','').css('display','none')
        });
    };
}

(function($){
    "use strict";
    $(function(){
        var $datepicker = $('.js-datepicker');
        if(!$datepicker.length) return;
        $datepicker.datepicker({
            setDate:'today',
            inline: true,
            //nextText: '&rarr;',
            //prevText: '&larr;',
            showOtherMonths: true,
            dateFormat: 'yy-mm-dd',
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            showOn: "button",
            buttonImage: "/admin/images/common/ico-calender.png",
            buttonImageOnly: true,
            buttonText: "calendar"
        });
    });
})(jQuery);

/*
$(document).ready(function(){
    var fileTarget = $('.upload-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }
        $(this).siblings('.form-input').find('.upload-name').val(filename);
    });
});
*/


/* 사용점 통계 3depth script */
(function($) {
    $(document).on("ready", init);
    function init() {
        function depFninit() {
            var $dep2 = $(".dep2-list"),
                $depitem = $dep2.find("li");
            $depitem.on("mouseenter", mouseoverFn);
            $depitem.on("mouseleave", mouseleaveFn);
        }

        function mouseoverFn() {
            var $this = $(this);
            $this.closest("li").find(".dep3-list").stop().slideDown("fast").addClass("active");
            $this.closest("li").addClass("hover");
        }

        function mouseleaveFn() {
            var $this = $(this);
            $this.closest("li").find(".dep3-list").stop().slideUp("fast").removeClass("active");
            $this.closest("li").removeClass("hover");
        }
        depFninit();
    }
})(jQuery);
/* //사용점 통계 3dep script */


/* 첨부파일 삭제 script */
(function($) {
    $(document).on("ready", init);

    function init() {
        var $delbtn;

        function valinit() {
            $delbtn = $(".valdel-btn");
            $delbtn.on("click", delFn);
        }

        function delFn() {
            var $inp = $('#inp-image');
            if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1) {
                $inp.val("");
            } else {
                $inp.each(function() {
                    $(this).after($(this).clone(true)).remove();
                });
            }
        }
        valinit();
    }
})(jQuery);
/* //첨부파일 삭제 script */



/* html editor script */
(function($) {
    $(document).on("ready", init);

    function init(){
        var $editorchk, $editorArea, $editorimage;

        function radioinit() {
            $editorchk = $("input:radio[id='sel-inphtml']");
            $editorimage = $("input:radio[id='sel-inpimage']");
            $editorArea = $(".editor-area");

            if($editorchk.is(":checked")) {
                changeFn();
            }
            $editorchk.on("click", changeFn);
            $editorimage.on("click", function() {
                $editorArea.removeClass("active");
            });
        }

        function changeFn() {
            $editorArea.addClass("active");
        }
        radioinit();
    }
})(jQuery);
/* //html editor script */


/* 권한관리 체크박스 */
(function($) {
    $(document).on("ready", init);
    function init() {

        function chkinit() {
            var $authorpage = $(".sel-author"),
                $allchk = $authorpage.find(".all-chk"),
                $allnchk = $authorpage.find(".all-nchk"),
                $inputchk = $(".author-table").find("input[type='checkbox']");

            $allchk.on("click", function() {
                $inputchk.prop("checked", true);
            });

            $allnchk.on("click", function() {
                $inputchk.prop("checked", false);
            });
        }
        chkinit();
    }
})(jQuery);
/* //권한관리 체크박스 */