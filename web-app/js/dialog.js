/**
 * Author: Arvin Patrick R. Guiam
 * used for the creation of popups
 * 
 */

function loadPopup(popup, popupBackground, popupStatus){
	if(popupStatus == 0){
		$("#" + popupBackground).css({
			"opacity": "0.7"
		});
		$("#" + popupBackground).fadeIn("fast");
		$("#" + popup).fadeIn("fast");
		return 1;
	} else {
		return popupStatus;
	}
}

function disablePopup(popup, popupBackground, popupStatus){
	if(popupStatus == 1){
		$("#" + popupBackground).fadeOut("fast");
		$("#" + popup).fadeOut("fast");
		return 0;
	} else {
		return popupStatus;
	}
}

function centeringPopup(popup, popupBackground){
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#" + popup).height();
	var popupWidth = $("#" + popup).width();
	$("#" + popup).css({
		"position": "fixed",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
	$("#" + popupBackground).css({
		"height": windowHeight
	});
}