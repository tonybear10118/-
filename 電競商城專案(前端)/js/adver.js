$(window).load(function(){  //等視窗loading完再執行
	var $win = $(window),    //傳入dom
		$ad = $('#abgne_float_ad').css('opacity', 0).show(),	// 取的廣告ID並讓廣告區塊變透明且顯示出來
		_width = $ad.width(),   //傳入廣告的寬度
		_height = $ad.height(),  //傳入廣告的高度
		_diffY = 20, _diffX = 20,	// 距離右及下方邊距
		_moveSpeed = 1000;	// 移動的速度
 
	// 先把 #abgne_float_ad (廣告)移動到定點
	$ad.css({
		top: $(document).height(),  // 移動到目前高度
		left: $win.width() - _width - _diffX,  //移動到目前寬度
		opacity: 1  //透明效果0~1
	});
 
	// 幫網頁加上 scroll 及 resize 事件
	$win.bind('scroll resize', function(){   //bind為添加一個處理程序
		var $this = $(this);
 
		// 控制 #abgne_float_ad 的移動
		$ad.stop().animate({
			top: $this.scrollTop() + $this.height() - _height - _diffY - 500,
			left: $this.scrollLeft() + $this.width() - _width - _diffX
		}, _moveSpeed);
	}).scroll();	// 每觸發一次 scroll()
 
	// 關閉廣告
	$('#abgne_float_ad .abgne_close_ad').click(function(){
		$ad.hide();  //很簡單的利用hide()關閉
	});
});