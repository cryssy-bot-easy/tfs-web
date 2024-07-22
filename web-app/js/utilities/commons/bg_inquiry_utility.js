function getBgInquiryGrid(){
	var grid=null;
	
}

$(function(){
	var bgInquiryGrid= $("#grid_list_bg_inquiry_branch").length > 0 ? $("#grid_list_bg_inquiry_branch") : $("#grid_list_bg_inquiry_main");
	
	$("#searchBgInquiry").click(function(){
		var postUrl=indemnityInquiryUrl + "?" + $("#bgInquiry").serialize();
		postUrl += "&unitcode="+unitcode;
		bgInquiryGrid.jqGrid("setGridParam",{url:postUrl,page:1, gridComplete: alertBgCount}).trigger("reloadGrid");
	});
	
	$("#resetBgInquiry").click(function(){
		var postUrl=indemnityInquiryUrl;
		postUrl += "?unitcode="+unitcode;
		bgInquiryGrid.jqGrid("setGridParam",{url:postUrl,page:1}).trigger("reloadGrid");
		$("#bgInquiry :input").filter(function(){
			return "searchBgInquiry" == $(this).attr("id") || "resetBgInquiry" == $(this).attr("id") ?
					null : $(this);
		}).val("");
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});

function alertBgCount(){
	var bgInquiryGrid= $("#grid_list_bg_inquiry_branch").length > 0 ? $("#grid_list_bg_inquiry_branch") : $("#grid_list_bg_inquiry_main");
	
	triggerAlertMessage(bgInquiryGrid.jqGrid('getGridParam', 'records') + " record/s found.");
	bgInquiryGrid.jqGrid('setGridParam', {gridComplete: ""});
}