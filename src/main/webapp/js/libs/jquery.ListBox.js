
/****************
 * jqListBox
 * jQuery Custom SelectBox
 * 뷰티포인트 용 _ select사이즈 할당안함.
 *  iam@syung.kr
 *****************/
;(function($){
	"use strict";

	var isMobile = (function(){
		if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			return true;
		} else {
			return false
		}
	})();

	$.fn.jqListBox = function(options){

		return this.each(function(index){

			var $this = $(this),
				Len = $this.find('option').length,
				origin_Txt = [],
				origin_Tit = [],
				origin_Val = [],
				IndexZ = 5-index,
				selectedIdx = $this.find('option:selected').index();

			var _className = ($this.data('class')) ? ' '+$this.data('class') : '',
				_idName = ($this.attr('id')) ? 'data-origin="'+$this.attr('id')+'"' : '',
				_selectTitle = ($this.attr('title')) ? 'title="'+$this.attr('title')+'"' : '',
				_originWidth = ($this.data('width')) ? $this.data('width') : $this.width(),
				_maxHeight = ($this.data('maxheight')) ? 'max-height:'+$this.data("maxheight")+'px;' : '';

			$.each($this.find('option'),function(){
				var list = $(this);
				origin_Txt.push( list.text() );
				origin_Val.push( list.val() );
				origin_Tit.push( ( list.attr('title') ) ? list.attr('title') : list.text() );
			});

			var make = {
				el : function(){
					var $listbox = $this.next('.jqListBox'),
						$combo = $listbox.find('.jqListBox-combo'),
						$comboTxt = $combo.find('.jqListBox-combo-txt'),
						$comboArrow = $combo.find('.jqListBox-combo-arrow'),
						$list = $listbox.find('.jqListBox-list'),
						$option = $list.find('.jqListBox-option');

					return {
						listbox : $listbox,
						combo : $combo,
						comboTxt : $comboTxt,
						comboArr : $comboArrow,
						list : $list,
						option : $option
					}
				},

				init : function(){
					var _this = this;
					_this.make();
					_this.bind();
					_this.change(selectedIdx);
					if(isMobile){
						_this.mobileType();
					}
				},

				make : function(){
					var html ='';
					var selected = '';

					html +=  '<div class="jqListBox'+_className+'"'+_idName+'style="z-index:'+IndexZ+'">';
					html += 	'<div class="jqListBox-combo" id="jqListBox-combo-'+index+'" '+_selectTitle+' tabindex="0" role="combobox" aria-autocomplete="list" aria-owns="jqListBox-list-'+index+'"><span class="jqListBox-combo-txt" data-id="0">'+origin_Txt[0]+'</span><span class="jqListBox-combo-arrow"></span></div>';
					html += 	'<ul class="jqListBox-list" id="jqListBox-list-'+index+'"role="listbox" aria-hidden="false" role="listbox" aria-labelledby="jqListBox-combo-'+index+'" aria-expanded="false" style="display:none;'+_maxHeight+'">';

					for (var i=0;i < Len;i++){
						if (i!=0){
							html += 	'<li class="jqListBox-option" id="jqListBox-option-'+index+'-'+i+'" data-id="'+i+'" data-val="'+origin_Val[i]+'"role="option" tabindex="0">'+origin_Txt[i]+'</li>';
						} else {
							html += 	'<li class="jqListBox-option selected" id="jqListBox-option-'+index+'-'+i+'" data-id="'+i+'" data-val="'+origin_Val[i]+'" role="option" tabindex="0">'+origin_Txt[i]+'</li>';
						}
					}
					html += 	'</ul>';
					html +=  '</div>';

					$this.hide().after(html);
					//this.setWidth();
				},
				/*

				 setWidth : function(){
				 var el = this.el();
				 var calWidth = parseInt( _originWidth - el.comboArr.outerWidth() ,10);
				 el.comboTxt.width(calWidth);
				 el.combo.width(_originWidth);
				 el.list.width(el.combo.width());
				 },
				 */

				change : function(idx){
					var el = this.el();

					if($this.prop('disabled')){
						return false;
					}

					el.option.removeClass('selected').eq(idx).addClass('selected');
					el.combo.find('.jqListBox-combo-txt').attr('data-id',idx).text( origin_Txt[idx] );
					el.combo.attr('aria-activedescendant',el.option.eq(idx).attr('id'));
					$this.find('option:eq('+idx+')').prop("selected", true).end().change();
				},

				open : function(){
					var el = this.el();

					if($this.prop('disabled')){
						return false;
					}

					el.combo.find('.jqListBox-combo-arrow').addClass('on');
                    el.list.slideDown(100,function(){
                        el.list.find('.selected').focus();
                        if(el.list.closest('.jqListbox-adapt').hasClass('jqdate')) {
                            el.list.css('overflow-y', 'scroll');
                        }
                    }).attr('aria-expanded','true');
					el.list.width(Math.floor(el.combo.width()));
				},

				close : function(){
					var el = this.el();
					el.combo.focus().find('.jqListBox-combo-arrow').removeClass('on');
					el.list.slideUp(100).attr('aria-expanded','false');
				},

				mobileType : function(){
					var el = this.el();
					$this.css({
						'position' : 'absolute',
						'display' : 'block',
						'opacity' : 0
					}).next('.jqListBox').css('z-index','-1');
					//alert(_originWidth)
					$this.change(function(){
						var idx = $(this).find('option:selected').index();
						el.option.removeClass('selected').eq(idx).addClass('selected');
						el.combo.find('.jqListBox-combo-txt').attr('data-id',idx).text( origin_Txt[idx] );
					});
				},
				unbind : function(){
					var el = this.el();
					el.combo.off();
					el.option.off();
					el.option.last().off();
					el.listbox.off();
				},

				bind : function(){
					var _this = this;
					var el = this.el();
					var listLen = el.option.length;

					el.combo.on({
						'click' : function(e){
							if (el.list.is(':visible'))	{
								_this.close();
							} else {
								_this.open();
							}
							e.preventDefault();
						},
						'keydown' : function(e){
							var idx = el.option.filter('.selected').index();
							if(e.shiftKey){
								if(e.keyCode == 9){
									_this.close();
								}
							} else if (!e.altKey){
								switch (e.keyCode) {


									case 13 :
										e.preventDefault();
										break;

									case 27 :	//esc
										_this.close();
										break;

									case 32 :	//space
										_this.open();
										break;

									case 33 :	//pageUp
										if (idx >= 3){
											el.option.eq(idx-3).click();
										} else {
											el.option.eq(0).click();
										}
										e.preventDefault();
										break;

									case 34 :	//pageDown
										if (Len > idx+3){
											el.option.eq(idx+3).click();
										} else {
											el.option.eq(Len-1).click();
										}
										e.preventDefault();
										break;

									case 35 :	//end
										el.option.eq(-1).click();
										e.preventDefault();
										break;

									case 36 :	//home
										el.option.eq(0).click();
										e.preventDefault();
										break;

									case 37 :	//left
									case 38 :	//up
										if (idx > 0){
											el.option.eq(idx-1).click();
										}
										e.preventDefault();
										break;

									case 39 :	//right
									case 40 :	//down
                                        _this.open();
										/*if (idx < listLen){
											el.option.eq(idx+1).click();
										}*/
										e.preventDefault();
										break;
								}
							} //no altKey
							else if (e.altKey){

								switch (e.keyCode) {
									case 38 :	//up
									case 40 :	//down
										_this.open();
										break;
								}
							}
						}
					});

					el.option.on({
						'click' : function(e){
							var idx = $(this).data('id');
							_this.change(idx);
							_this.close();
							el.combo.focus();
							e.preventDefault();
						},
						'keydown' : function(e){
							var idx = $(this).data('id');
							if (!e.altKey ){
								switch (e.keyCode) {

									case 13 :	//space
									case 32 :	//enter
										$(this).click();
										e.preventDefault();
										break;

									case 27 : //esc
										_this.close();
										el.combo.focus();
										break;

									case 33 :	//pageUp
										if (idx >= 3){
											el.option.eq(idx-3).focus();
										} else {
											el.option.eq(0).focus();
										}
										e.preventDefault();
										break;

									case 34 :	//pageDown
										if (Len >= idx+3){
											el.option.eq(idx+3).focus();
										} else {
											el.option.eq(Len-1).focus();
										}
										e.preventDefault();
										break;

									case 35 : //end
										el.option.eq(-1).focus();
										e.preventDefault();
										break;

									case 36 : //home
										el.option.eq(0).focus();
										e.preventDefault();
										break;

									case 37 :	//up
									case 38 :	//left
										if (idx != 0){
											idx--;
										}
										el.option.eq(idx).focus();
										e.preventDefault();
										break;

									case 39 :	//right
									case 40 :	//down
										idx++;
										el.option.eq(idx).focus();
										e.preventDefault();
										break;

								}
							} //no altKey
							else if (e.altKey){

								switch (e.keyCode) {
									case 38 :	//up
									case 40 :	//down
										_this.close();
										break;
								}
							} //alt
						}
					});

					el.option.last().on({
						'keydown' : function(e){
							if (e.keyCode == 9) {
								if(!e.shiftKey) {
									e.preventDefault();
									_this.close();
								}
							}
						}
					});

					el.list.on('mouseleave',function(){
						_this.close();
					});

				}
			};

			if(options === 'init') {
				make.init();
			}
			if(options === 'update') {
				make.change($this.find('option:selected').index());
			}
			if(options === 'destory') {
				make.unbind();
				$this.show().next('.jqListBox').remove();
			}
		});
	};

})(jQuery);
