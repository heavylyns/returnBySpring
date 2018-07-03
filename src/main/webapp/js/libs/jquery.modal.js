
/****************
 * jqModal
 * jQuery Custom LayerPopup
 *  iam@syung.kr
 *****************/
/***
 *
 링크를 띄울 a 태그에 data-modal 과 href에 해당 레이어의 url 필요
 레이어 안에 닫기 버튼에는 data-dismiss='modal' 속성 추가
 레이어 안쪽 컨테이너에 data-modal-size="400-600" 속성으로 창 사이즈 지정 (width : 400, height : 600);
 레어아 타이틀 해딩에 id="modal-title" 추가
 */
;(function($){
    $.fn.jqModal = function(targetURL, hash){
        var $origin = GAT.FOCUS_ELEM = $(this),
            _targetURL = targetURL || '',
            _hash = hash || ' #modal_wrapper',
            _beforeOpenScrollTop = 0;

        makeModalWrapper();

        var $modal = $('#ly-modal');
        var $dialog = $modal.find('.modal-dialog');

        $dialog.load(_targetURL+_hash,function(){
            var $this = $modal;
            var focusable = [],
                el_firstFocus, el_lastFocus;

            $this.find('*').each(function(i, val) {
                if(val.tagName.match(/^A$|AREA|INPUT|TEXTAREA|SELECT|BUTTON/gim) && parseInt(val.getAttribute("tabIndex")) !== -1) {
                    focusable.push(val);
                }
                if((val.getAttribute("tabIndex") !== null) && (parseInt(val.getAttribute("tabIndex")) >= 0) && (val.getAttribute("tabIndex", 2) !== 32768)) {
                    focusable.push(val);
                }
            });
            el_firstFocus = focusable[0];
            el_lastFocus = focusable[focusable.length-1];

            $(el_firstFocus).on({
                'keydown' : function(e){
                    if (e.target == this){
                        var keyCode = e.keyCode || e.which;
                        if (keyCode == 9){
                            if (e.shiftKey){
                                $(el_lastFocus).focus();
                                e.preventDefault();
                            }
                        }
                    }
                }
            });

            $(el_lastFocus).on({
                'keydown' : function(e){
                    var keyCode = e.keyCode || e.which;
                    if (keyCode == 9){
                        if (!e.shiftKey){
                            $(el_firstFocus).focus();
                            e.preventDefault();
                        }
                    }
                }
            });

            $this.find("[data-dismiss='modal']").click(function(e){
                closeModal();
                e.preventDefault();
            });

            if(GAT.IS_MOBILE){
                _beforeOpenScrollTop = $('body').scrollTop();
                $('html').addClass('modal-opened modal-opened-mobile');
            } else {
                var scrollWidth = getPCScrollbarWidth();
                $('html').addClass('modal-opened');
                //$('body').css('padding-right',scrollWidth);
            }
            setDialogSize();
            setModalPosition();
            $modal.css('opacity','0').show().stop().animate({'opacity':'1'},0).find($(el_firstFocus)).focus();
            $this.on('touchmove',function(e){e.stopPropagation();});
        });

        $(document).on({
            'keydown' : function(e){
                var keyCode = e.keyCode || e.which;
                if (keyCode == 27){
                    closeModal();
                    $(document).off('keydown');
                }
            }
        });

        $(window).on('resize',function(){
            "use strict";
            GAT.DELAY_FUNC(function(){
                setDialogSize();
                setModalPosition();
            },300);

        });

        function makeModalWrapper(){
            if(!$('#ly-modal').length){
                var modalHtml = '';
                modalHtml += '<div id="ly-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-title" aria-hidden="true">';
                modalHtml += '  <div class="modal-fade" tabindex="-1" data-dismiss="modal" aria-hidden="true">&nbsp;</div>';
                modalHtml += '      <section class="modal-dialog" tabindex="0">';
                modalHtml += '      </section>';
                modalHtml += '</div>';
                $('body').append(modalHtml).show();
            }
        }

        function setDialogSize(){
            var dataSize = $modal.find('[data-modal-size]').data('modalSize');

            if(dataSize){
                var dialogSize = dataSize.split('-');
                var $win = $(window);
                var screenW = $win.width(),
                    screenH = $win.height();
                var modal_width = (screenW < dialogSize[0]) ? screenW : Number(dialogSize[0])+ 2;

                if(GAT.IS_MOBILE){
                    $dialog.css({
                        'width' : '100%',
                        'height' : '80%'
                    });

                } else {
                    console.log(modal_width)
                    $dialog.css({
                        'width' : modal_width,
                        'max-height' : screenH-130 //top margin 40 + bottom margin 40
                    });
                }
            }
        }

        function getPCScrollbarWidth() {
            if ($(document.body).height() <= $(window).height()) {
                return 0;
            }

            var outer = document.createElement("div");
            outer.style.visibility = "hidden";
            outer.style.width = "100px";
            document.body.appendChild(outer);

            var widthNoScroll = outer.offsetWidth;
            outer.style.overflow = "scroll";

            var inner = document.createElement("div");
            inner.style.width = "100%";
            outer.appendChild(inner);

            var widthWithScroll = inner.offsetWidth;
            outer.parentNode.removeChild(outer);

            return widthNoScroll - widthWithScroll;
        }

        function setModalPosition(){
            var $modalBody = $('#ly-modal').find('.modal-dialog');
            var _width = $modalBody.outerWidth(),
                _height = $modalBody.outerHeight();

            if(GAT.IS_MOBILE){
                $modalBody.css({
                    'top' : '10%',
                    'left' : '0'
                })
            } else {
                $modalBody.css({
                    'marginTop' : 0,//parseInt(_height/2 * -1,10),
                    'marginLeft' : parseInt(_width/2 * -1,10)
                })
            }
        }

        function closeModal(){
            $origin.focus();
            $modal.stop().animate({'opacity':'0'},0,function(){
                $('html').removeClass('modal-opened modal-opened-mobile');
                $('body').css('padding-right',0);
                if(GAT.IS_MOBILE) $('body').scrollTop(_beforeOpenScrollTop);
                $(this).hide();
            });
        }
    };


    $.jqModalClose = function(){
        "use strict";
        var $modal = $(document).find('#ly-modal');
        if($modal.is(':visible')){
            $modal.find('[data-dismiss="modal"]').click();
        }
    };

    $.jqModal_close = function(beforeCloseFunc){
        var $target = $(document).find('.modal:visible');
        $target.each(function(){
            var beforeFuncResult = true;
            beforeFuncResult = beforeCloseFunc && beforeCloseFunc();
            if(beforeFuncResult){
                $('html').removeClass('modal-opened').off('touchmove');
                GAT.FOCUS_ELEM.focus();
                $(this).hide();
            }
        });
    };

})(jQuery);
