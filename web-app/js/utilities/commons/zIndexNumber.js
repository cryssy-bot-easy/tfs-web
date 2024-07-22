$(function() {
		
	var zIndexNum = 1000;
	$('div').each(function() {
		
		$(this).css('zIndex', zIndexNum);
		zIndexNum -= 10;
		
	});
});