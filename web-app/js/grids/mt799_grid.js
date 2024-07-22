$(document).ready(function(){
	
	var popup_mt799_div = $('#mt799_popup_div').attr("id");
	var popup_mt799_bg = $('#mt799_popup_bg').attr("id");

	var outgoingPageUrl = '';
	var incomingPageUrl = '';
	
	var gridRowOutgoing = $('#outgoing_mt799_list');
	var gridRowIncoming = $('#incoming_mt799_list');
	
	
	
	setupJqGridPager('outgoing_mt799_list', {width: 780, loadui: "disable", scrollOffset:1},
					[['outDate', 'Date', 150, 'left'],
					['outFileName', 'MT799 File Name', 530, 'left'],
					['outView','View', 100, 'center']], 'outgoing_mt799_pager', outgoingPageUrl);
	
	setupJqGridPager('incoming_mt799_list', {width: 780, loadui: "disable", scrollOffset:1},
			[['inDate', 'Date', 150, 'left'],
			['inFileName', 'MT799 File Name', 530, 'left'],
			['inView','View', 100, 'center']], 'incoming_mt799_pager', incomingPageUrl);

	
//	gridRowOutgoing.addRowData("1", {outDate:"05/15/12 14:30:26 PM",outFileName:"Outgoing_mt799_file.doc", outView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowOutgoing.addRowData("2", {outDate:"11/16/11 14:30:26 PM",outFileName:"Outgoing_mt799_file.doc", outView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowOutgoing.addRowData("3", {outDate:"03/15/12 14:30:26 PM",outFileName:"Outgoing_mt799_file.doc", outView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowOutgoing.addRowData("4", {outDate:"05/15/11 14:30:26 PM",outFileName:"Outgoing_mt799_file.doc", outView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });

	
	

//	gridRowIncoming.addRowData("1", {inDate:"05/15/12 14:30:26 PM",inFileName:"Incoming_mt799_file.doc", inView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowIncoming.addRowData("2", {inDate:"11/16/11 14:30:26 PM",inFileName:"Incoming_mt799_file.doc", inView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowIncoming.addRowData("3", {inDate:"03/15/12 14:30:26 PM",inFileName:"Incoming_mt799_file.doc", inView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });
//	gridRowIncoming.addRowData("4", {inDate:"05/15/11 14:30:26 PM",inFileName:"Incoming_mt799_file.doc", inView:"<a href=\"javascript:void(0)\" class=\"popupLetter\" style=\"color: blue\">View</a>" });

	
	$(".popupLetter").live("click", function(){
		centerPopup(popup_mt799_div, popup_mt799_bg);
		//load popup
		loadPopup(popup_mt799_div, popup_mt799_bg);	
	});
		
		
	$(".mt799_close").live("click", function(){
			disablePopup(popup_mt799_div, popup_mt799_bg);

	});

});