// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-tagsinput.min

//= require readmore
//= require_tree .

$(function(){
	$("#novel_novel_title").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-1").text(countNum + "文字");
	});
});

$(function(){
	$("#novel_novel_about").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-2").text(countNum + "文字");
	});
});

$(function(){
	$("#novel_content_novel_content_title").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-3").text(countNum + "文字");
	});
});

$(function(){
	$("#novel_content_novel_content_forewords").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-4").text(countNum + "文字");
	});
});

$(function(){
	$("#novel_content_novel_content_text").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-5").text(countNum + "文字");
	});
});

$(function(){
	$("#novel_content_novel_content_afterwords").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-6").text(countNum + "文字");
	});
});

$(function(){
	$("#user_about").on("keyup", function(){
		let countNum = String($(this).val().length);
		$("#counter-7").text(countNum + "文字");
	});
});

$(function(){
	$('#hm-btn').on('click', function(){
		$('#navcon').addClass('active');
		$('#navcon').slideToggle();
		// $('#navcon').toggleClass('active');
	});
});

$(function(){
  $(".dropdwn_btn-1").on("click", function(){
    $(".1st").slideToggle();
  });
});
$(function(){
  $(".dropdwn_btn-2").on("click", function(){
    $(".2nd").slideToggle();
  });
});



// $(function(){
// 	$(".open").readmore({
// 	moreLink: '<a  class="btn  btn_open" href="#"><span>続きを読む</span></a>',
// 	lessLink: '<a  class="btn  btn_close" href="#"><span>閉じる</span></a>'
// 	});
// });

$(document).ready(function($){
	$(".open").readmore({
	collapsedHeight: 100,
	moreLink: '<a  class="btn  btn_open" href="#"><span>続きを読む</span></a>',
	lessLink: '<a  class="btn  btn_open" href="#"><span>閉じる</span></a>'
	});
});

// jQuery(document).ready(function($){
// 	$(".open").readmore({
// 	moreLink: '<a  class="btn  btn_open" href="#"><span>続きを読む</span></a>',
// 	lessLink: '<a  class="btn  btn_close" href="#"><span>閉じる</span></a>'
// 	});
// });

// $(function(){
// 	$('#hm-btn').on('click', function(){
// 		$(this).toggleClass('active');
// 		$('#navcon').slideToggle();
// 		$('#navcon').toggleClass('active');
// 		return false;
// 	});
// });







