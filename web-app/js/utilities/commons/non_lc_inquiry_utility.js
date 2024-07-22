/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/6/12
 * Time: 3:12 PM
 * To change this template use File | Settings | File Templates.
 */
var settleUrl = "";

function onSettleNegotiation(id) {
    $.post(multipleServiceInstructionUrl, {tradeProductNumber: id, serviceType: "SETTLEMENT"}, function(data) {
        var grid = null;

        if($("#grid_list_non_lc_inquiry_main").length > 0) {
            grid = $("#grid_list_non_lc_inquiry_main");
        } else {
            grid = $("#grid_list_non_lc_inquiry_branch");
        }
        var gridData = grid.jqGrid("getRowData", id);

        var gotoUrl = viewApprovedNonLcBranchUrl;

        gotoUrl += "?documentNumber="+id;
        gotoUrl += "&serviceType=Settlement";
        switch(gridData.documentClass) {
            case "DA":
                gotoUrl += "&documentClass=DA";
                break;
            case "DP":
                gotoUrl += "&documentClass=DP";
                gotoUrl += "&documentType="+gridData.documentType;
                break;
            case "DR":
                gotoUrl += "&documentClass=DR";
                break;
            case "OA":
                gotoUrl += "&documentClass=OA";
                break;
        }

        settleUrl = gotoUrl;

        if (data.success == "true") {

            location.href = gotoUrl;

        } else if(data.action == "continue"){

            $("#confirmMessage_settle").text(data.message);

            mLoadPopup($("#popup_confirm_div_settle"), $("#popup_confirm_bg_settle"));
            mCenterPopup($("#popup_confirm_div_settle"), $("#popup_confirm_bg_settle"));
        } else {
        	triggerAlertMessage(data.message);
        }
    });
}



function onCancelNegotiation(id) {
	
//    var gridData = $("#grid_list_non_lc_inquiry_main").jqGrid("getRowData", id);
    var grid = null;
    var serviceType = null;

    if($("#grid_list_non_lc_inquiry_main").length > 0) {
        grid = $("#grid_list_non_lc_inquiry_main");
    } else {
        grid = $("#grid_list_non_lc_inquiry_branch");
    }
    var gridData = grid.jqGrid("getRowData", id);
    var gotoUrl = viewApprovedNonLcTsdUrl;
    gotoUrl += "?documentNumber="+gridData.documentNumber;
    switch(gridData.documentClass) {
        case "DA":
        	switch(gridData.status){
        	case "ACKNOWLEDGED":
        		/*showAcceptCancelPopup();
        		$("#daDocNum").val(gridData.documentNumber);
        		return false;*/
        		gotoUrl += "&documentClass=DA";
        		gotoUrl += "&serviceType=Negotiation Acceptance";
        		serviceType = "Negotiation Acceptance"
        		break;
        	case "ACCEPTED":
        		gotoUrl += "&documentClass=DA";
        		gotoUrl += "&serviceType=Cancellation";
        		serviceType = "Cancellation"
        		break;
        	}
            break;
        case "DP":
        	gotoUrl += "&documentClass=DP";
        	gotoUrl += "&documentType="+gridData.documentType;
        	gotoUrl += "&serviceType=Cancellation";
        	serviceType = "Cancellation"
            break;
        case "DR":
        	gotoUrl += "&documentClass=DR";
        	gotoUrl += "&serviceType=Cancellation";
        	serviceType = "Cancellation"
            break;
        case "OA":
        	gotoUrl += "&documentClass=OA";
        	gotoUrl += "&serviceType=Cancellation";
        	serviceType = "Cancellation"
            break;
    }
    $.post(multipleServiceInstructionUrl, {tradeProductNumber: id, serviceType: serviceType}, function(data) {

//    gotoUrl += "?tradeServiceId="+id;
//    gotoUrl += "&documentClass="+gridData.documentClass;
//    gotoUrl += "&documentType="+gridData.documentType;
	    if (data.success == "true") {
	    	location.href = gotoUrl;
	    } else {
	    	triggerAlertMessage(data.message);
	    }
	});
}

function onNonLcResetClick() {
	var postUrl = mainNonLcInquiryGridUrl;
	postUrl += "?unitcode="+unitcode;
    var grid = null;

    if($("#grid_list_non_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_non_lc_inquiry_branch");
    } else {
        grid = $("#grid_list_non_lc_inquiry_main");
    }
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
	
//    $("#documentNumber, #cifName, #status").val("");
}

function onNonLcSearchClick() {
    var postUrl = mainNonLcInquiryGridUrl;
    postUrl += "?"+$("#nonLcInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;

    if($("#grid_list_non_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_non_lc_inquiry_branch");
    } else {
        grid = $("#grid_list_non_lc_inquiry_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertNonLcCount}).trigger("reloadGrid");
}

function alertNonLcCount(){
	var grid;
	
	if ($("#grid_list_non_lc_inquiry_branch").length > 0) {
		grid = $("#grid_list_non_lc_inquiry_branch");
	} else {
		grid = $("#grid_list_non_lc_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function initializeNonLcInquiry() {
    $("#nonLcSearch").click(onNonLcSearchClick);
    $("#nonLcReset").click(onNonLcResetClick);
    $(".accept_cancel_nonlc_close").click(closeAcceptCancel);
    $("#accept_cancelCancel").click(closeAcceptCancel);
    $("#accept_cancelRedirect").click(evaluateDaAction);
}

$(initializeNonLcInquiry);
/*
function goToCancel(){
	evaluateDaAction("cancel")
}

function goToAccept(){
	evaluateDaAction("accept")
}*/

function evaluateDaAction(){
	var gotoUrl = viewApprovedNonLcTsdUrl;
	var action = $("input[name=createDa]:checked").val();
	gotoUrl += "?documentNumber="+$("#daDocNum").val();
	gotoUrl += "&documentClass=DA";
	if (action == "accept"){
		gotoUrl += "&serviceType=Negotiation Acceptance";
	} else if (action == "cancel"){
		gotoUrl += "&serviceType=Cancellation";
	}
	
	location.href = gotoUrl;
}

//Popup for Accept/Cancel
function closeAcceptCancel(){
	disablePopup($("#accept_cancel_nonlc_popup").attr("id"),$("#accept_cancel_nonlc_bg").attr("id"));
	$("#daDocNum").val("");
}

function showAcceptCancelPopup(){
	centerPopup($("#accept_cancel_nonlc_popup").attr("id"),$("#accept_cancel_nonlc_bg").attr("id"));
	loadPopup($("#accept_cancel_nonlc_popup").attr("id"),$("#accept_cancel_nonlc_bg").attr("id"));
}