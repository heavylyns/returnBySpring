/**
 *
 * jQuery RetinaImg replace
 * xlrj0716@gmail.com
 * $(element).RetinaImg();
 * element는 체크할 이미지;
 * 반응형시 mobile(maxMobile), Tablet(maxTablet) breakpoint 조절
 * 2015.04.23 V 0.1
 *
 */

;(function($,window,document,undefined) {
	"use strict";

	(function(pluginName){

		var defaults = {
			'item' : '.retinaimg',
			'maxMobile' : GAT.IS_SIZE.MAXMOBILE || 767 ,
			'maxTablet' :  GAT.IS_SIZE.MAXTABLET || 1024
		};

		$.fn[pluginName] = function(options, settings) {
			settings = $.extend(true, {}, defaults, settings);

			var imgSrc = [];

			var _var = {
				itemLen : 0,
				viewType : 'mobile',
				oldViewType  : '',
				initFlag : true
			};


			SetViewSize();
			CheckMobile();

			return this.each(function(){
				var elem = this;
				var $item = $(settings.item)

				_var.itemLen = $item.length;

				/**
				 * 단말기 구분은 기본적으로
				 * document.documentElement.clientWidth와 userAgent값을 가져와서 구분
				 */

				this.init = function () {
					DeivceChkFn();
					this.RetinaReplace();
					this.ChangeBandImgSrc();
				};

				/*this.DeivceChk = function() {
					var deviceWidth = GAT.VIEWPORT_WIDTH;
					if(deviceWidth < $maxMobile && GAT.IS_MOBILE){
						_var.viewType = 'mobile';

					} else if(deviceWidth <= $maxTablet && GAT.IS_MOBILE){
						_var.viewType = 'tablet';
					} else {
						if(deviceWidth < $maxMobile ) {
							_var.viewType = 'mobile';
						} else if (deviceWidth <= $maxTablet ) {
							_var.viewType = 'tablet';
						} else {
							_var.viewType = 'pc';
						}
					}
				};*/


				/**
				 * 레티나 3x 이미지까지 고려
				 * 필요없는 경우 조정해서 이미지 개수 최소화
				 * 기본으로(아이폰6plus까지) pc 이미지 1개와 모바일 태블릿 이미지 3씩 준비 총 7장의 이미지가 필요함
				 * 맥북 레티나까지 고려와 @4x 까지 전체적으로 고려시 총 12장의 이미지가 필요
				 */

				this.RetinaReplace = function(){
					$item.each(function (index) {
						var $this = $(this);
						if(GAT.IS_VIEWTYPE != 'pc' && window.devicePixelRatio != undefined) { // 일반적인 pc사용시

//				if(window.devicePixelRatio != undefined) { // 맥북 레티나 고려시
							if ($this.data(GAT.IS_VIEWTYPE).indexOf('@') != -1) {
								//if (window.devicePixelRatio >= 4) {
								//	imgSrc[index] = $this.data(viewType).replace(/\@1x/g, '@4x');
								//} else /* 4x 이미지 필요시 활성화 */
								if(window.devicePixelRatio >= 3) {
									imgSrc[index] = $this.data(GAT.IS_VIEWTYPE).replace(/\@1x/g, '@3x');
								} else if (window.devicePixelRatio >= 2) {
									imgSrc[index] = $this.data(GAT.IS_VIEWTYPE).replace(/\@1x/g, '@2x');
								} else if (window.devicePixelRatio >= 1 ) {
									imgSrc[index] = $this.data(GAT.IS_VIEWTYPE);
								}
							} else {
								imgSrc[index] = $this.data(GAT.IS_VIEWTYPE);
							}
						} else {
							imgSrc[index] = $this.data(GAT.IS_VIEWTYPE);
						}
					});
				};

				this.ChangeBandImgSrc = function(){
					if (_var.initFlag || _var.oldViewType != GAT.IS_VIEWTYPE) {
						var $img = [];
						$item.each(function (index) {
							$img[index] = $item.eq(index);
							$img[index].attr('src', imgSrc[index]);
						});
						_var.initFlag = false;
						_var.oldViewType = GAT.IS_VIEWTYPE;
					}
				};

				$(window).resize(function(){
					if (_var.itemLen > 0) {
						SetViewSize();
						CheckMobile();
						DeivceChkFn();
						elem.RetinaReplace();
						elem.ChangeBandImgSrc();
					}
				});
				this.init();
			});
		};
		$.fn[pluginName].defaults = defaults;
	})('RetinaImg');
})(jQuery,window,document,undefined);
