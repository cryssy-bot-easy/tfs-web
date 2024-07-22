//------------------ POPUP ------------------
//0 means disabled; 1 means enabled;
var popupStatus = 0;
var activePopupDiv = "";
var activePopupBg = "";
var activePopup = "";

//loading popup with jQuery magic!
function loadPopup(popup_div, popup_bg){
	//loads popup only if it is disabled
	if(popupStatus==0){
		// get active popup div and bg
		activePopupDiv = popup_div;
		activePopupBg = popup_bg;
		
		activePopup = '#'+popup_div + " :input";
		
		// enable all fields inside active popup
		$(activePopup).attr('disabled', false);
		
		$('#'+popup_bg).css({
			"opacity": "0.2"
		});
		$('#'+popup_bg).fadeIn("fast");
		$('#'+popup_div).fadeIn("fast");
		popupStatus = 1;
	}
}

//disabling popup with jQuery magic!
function disablePopup(popup_div, popup_bg){
		
	//disables popup only if it is enabled
	if(popupStatus==1){
		// resets active popup div and bg
		activePopupDiv = "";
		activePopupBg = "";
		
		activePopup = '#'+popup_div + " :input";
		
		// enable all fields inside active popup		
		$(activePopup).attr('disabled', true);
		
		activePopup = "";

		$('#'+popup_bg).fadeOut("fast");
		$('#'+popup_div).fadeOut("fast");
		popupStatus = 0;
	}
}

//centering popup
function centerPopup(popup_div, popup_bg){
	
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $('#'+popup_div).height();
	var popupWidth = $('#'+popup_div).width();
	//centering
	$('#'+popup_div).css({
		"position": "fixed",
		"top":windowHeight/2-popupHeight/2,	
		"left": windowWidth/2-popupWidth/2
	});
	//only need force for IE6
	
	$('#'+popup_bg).css({
		"height": windowHeight
	});
}




//multiple popup version

function mLoadPopup(popup_div, popup_bg){
    // get active popup div and bg
    var activePopup = '#'+popup_div.attr("id") + " :input";

    // enable all fields inside active popup
    $(activePopup).attr('disabled', false);

	//loads popup only if it is disabled
	if(popup_div.css("display")=="none"){
		$(popup_bg).css({
			"opacity": "0.2"
		});
		$(popup_bg).fadeIn("fast");
		$(popup_div).fadeIn("fast");
	}
}

//disabling popup with jQuery magic!
function mDisablePopup(popup_div, popup_bg){
    var activePopup = '#'+popup_div.attr("id") + " :input";

    // enable all fields inside active popup
    $(activePopup).attr('disabled', true);

	//disables popup only if it is enabled
	if(popup_div.css("display")!="none"){
		$(popup_bg).fadeOut("fast");
		$(popup_div).fadeOut("fast");
	}
}

function mCenterPopup(popup_div, popup_bg){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $(popup_div).height();
	var popupWidth = $(popup_div).width();
	//centering
	$(popup_div).css({
		"position": "fixed",
		"top":windowHeight/2-popupHeight/2,	
		"left": windowWidth/2-popupWidth/2
	});
	//only need force for IE6
	
	$(popup_bg).css({
		"height": windowHeight
	});
}