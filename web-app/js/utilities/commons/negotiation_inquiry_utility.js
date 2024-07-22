/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/4/12
 * Time: 11:12 PM
 * To change this template use File | Settings | File Templates.
 */

function searchNegos() {
    var postUrl = '/tfs-web/inquiry/searchNegotiationInquiryGrid';
    postUrl += "?"+$("#negotiationInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;
    if($("#grid_list_negotiation_inquiry_branch").length > 0) {
        grid = $("#grid_list_negotiation_inquiry_branch");
    } else {
        grid = $("#grid_list_negotiation_inquiry_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertNegoInquiryCount}).trigger("reloadGrid");
}

function alertNegoInquiryCount(){
	var grid;
	
	if ($("#grid_list_negotiation_inquiry_branch").length > 0) {
		grid = $("#grid_list_negotiation_inquiry_branch");
	} else {
		grid = $("#grid_list_negotiation_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
    onNegoInquiryResetClick();
}

function onNegoInquiryResetClick() {
	
	var postUrl = searchNegotiationInquiryUrl;
	postUrl += "?unitcode="+unitcode;
    var grid = null;

    if($("#grid_list_negotiation_inquiry_branch").length > 0) {
        grid = $("#grid_list_negotiation_inquiry_branch");
    } else {
        grid = $("#grid_list_negotiation_inquiry_main");
    }
  
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
	
//    $("#documentNumber, #cifName, #clientName, #negotiationDateFrom, #negotiationNumber, #negotiationDateTo").val("");
}

function initializeNegotiationInquiry() {
    $("#negotiationInquirySearch").click(searchNegos);
    $("#negotiationInquiryReset").click(onNegoInquiryResetClick);
}

$(initializeNegotiationInquiry);
