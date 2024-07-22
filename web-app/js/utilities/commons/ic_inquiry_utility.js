/**
 * PROLOGUE:
	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date created:] 08/16/2017
	Program [Revision] Details: IC Inquiry module
	Member Type: JS
	Project: tfs-web
	Project Name: ic_inquiry_utility.js
 */

function onViewIcClick(id){
    var grid = null;

    grid = $("#grid_list_lc_inquiry_main");
    
    var gridData = grid.jqGrid("getRowData", id);

    var gotoUrl = viewIcUrl;
    gotoUrl += '?serviceType='+gridData.serviceType;
    gotoUrl += '&documentType='+gridData.documentType;
    gotoUrl += '&documentClass='+gridData.documentClass;
    gotoUrl += '&documentSubType1='+gridData.documentSubType1;
    gotoUrl += '&documentSubType2='+gridData.documentSubType2;
    gotoUrl += '&tradeServiceId='+id;

    location.href = gotoUrl;
}

function onResetIcBtnClick() {
	var postUrl = tsdIcInquiryUrl;
//    postUrl += "&unitcode="+unitcode;
    var grid = null;

    if($("#grid_list_ic_inquiry_main").length > 0) {
        grid = $("#grid_list_ic_inquiry_main");
    }
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    $("#currency").select2("data",null);
}

function onSearchIcBtnClick() {
	var ctr = 0;
	$(".icSearchCriteria").each(function() {
		if( $(this).val() != "" ){
			ctr = ctr + 1;
		}
	});
	if( ctr == 0 ){
		triggerAlertMessage("No criteria for searching.");
	} else {
		var postUrl = tsdIcInquiryUrl;
	    postUrl += "?"+$("#icInquiry").serialize();
	    var unitcode = $('input[name=unitcode]').val();
	    postUrl += "&unitcode="+unitcode;

	    var grid = null;

	    if($("#grid_list_ic_inquiry_main").length > 0) {
	        grid = $("#grid_list_ic_inquiry_main");
	    }

	    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertIcCount}).trigger("reloadGrid");
	}
}

function alertIcCount(){
	var grid;
	
	if ($("#grid_list_ic_inquiry_branch").length > 0) {
		grid = $("#grid_list_ic_inquiry_branch");
	} else {
		grid = $("#grid_list_ic_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function validateAmounts(id){
	var lcAmountFrom = $("input[name=lcAmountFrom]").val();
	var lcAmountTo = $("input[name=lcAmountTo]").val();
	var icAmountFrom = $("input[name=icAmountFrom]").val();
	var icAmountTo = $("input[name=icAmountTo]").val();
	
	lcAmountFrom = lcAmountFrom.replace(/,/g, '');
	lcAmountTo = lcAmountTo.replace(/,/g, '');
	icAmountFrom = icAmountFrom.replace(/,/g, '');
	icAmountTo = icAmountTo.replace(/,/g, '');
	
	lcAmountFrom = parseFloat(lcAmountFrom);
	lcAmountTo = parseFloat(lcAmountTo);
	icAmountFrom = parseFloat(icAmountFrom);
	icAmountTo = parseFloat(icAmountTo);
	
	if( !isNaN(lcAmountFrom) && !isNaN(lcAmountTo) ){ 
		switch(id){
		case "lcAmountFrom":
			if( lcAmountFrom > lcAmountTo ){
				triggerAlertMessage("The value for LC Amount From should not be greater than LC Amount To.")
				$("input[name=lcAmountFrom]").val("");
				if( $("#btnAlertOk").val() != undefined ){
					$("#btnAlertOk").click(function() {
						$("input[name=lcAmountFrom]").focus();
					});
				}
			}
			break;
		case "lcAmountTo":
			if ( lcAmountTo < lcAmountFrom ){
				triggerAlertMessage("The value for LC Amount To should not be less than LC Amount From.")
				$("input[name=lcAmountTo]").val("");
				if( $("#btnAlertOk").val() != undefined ){
					$("#btnAlertOk").click(function() {
						$("input[name=lcAmountTo]").focus();
					});
				}
			}
			break;
		}
	} 
	if( !isNaN(icAmountFrom) && !isNaN(icAmountTo) ){ 
		switch(id){
		case "icAmountFrom":
			if( icAmountFrom > icAmountTo ){
				triggerAlertMessage("The value for IC Amount From should not be greater than IC Amount To.")
				$("input[name=icAmountFrom]").val("");
				if( $("#btnAlertOk").val() != undefined ){
					$("#btnAlertOk").click(function() {
						$("input[name=icAmountFrom]").focus();
					});
				}
			}
			break;
		case "icAmountTo":
			if ( icAmountTo < icAmountFrom ){
				triggerAlertMessage("The value for IC Amount To should not be less than IC Amount From.")
				$("input[name=icAmountTo]").val("");
				if( $("#btnAlertOk").val() != undefined ){
					$("#btnAlertOk").click(function() {
						$("input[name=icAmountTo]").focus();
					});
				}
			}
			break;
		}
	} 
}

function initializeEtsPopup() {
    $("#searchIcBtn").click(onSearchIcBtnClick);
    $("#resetIcBtn").click(onResetIcBtnClick);
}

$(document).ready(function() {
	$("#currency").setCurrencyDropdown($(this).attr("id"));
	
	initializeEtsPopup();
	
	$('.validateIfZero').bind('blur', function() {
	    var id = $(this).attr('id');
	    var amount = $(this).val();
	    var fieldname = ""
	    amount = amount.replace(/,/g, '');
	    amount = parseFloat(amount);
	    switch(id){
	    	case "lcAmountFrom" :
		    	if( amount <= 0 ){
		    		fieldname = "LC Amount From";
		    		$("#lcAmountFrom").val("");
		    	}	
	    	break;
	    	case "lcAmountTo" :
		    	if( amount <= 0 ){
		    		fieldname = "LC Amount To";
		    		$("#lcAmountTo").val("");
		    	}	
	    	break;
	    	case "icAmountFrom" :
		    	if( amount <= 0 ){
		    		fieldname = "IC Amount From";
		    		$("#icAmountFrom").val("");
		    	}	
	    	break;
	    	case "icAmountTo" :
		    	if( amount <= 0 ){
		    		fieldname = "IC Amount To";
		    		$("#icAmountTo").val("");
		    	}	
	    	break;
	    }
	    if( fieldname != "" ){
	    	triggerAlertMessage("The value for " + fieldname + " should not be zero or negative.");
	    	if( $("#btnAlertOk").val() != undefined ){
				$("#btnAlertOk").click(function() {
					var fieldId = '#' + id;
					$(fieldId).focus();
				});
			}
	    }
	});
	
	$('input[name=icDateFrom]').change(function() {
		if( $('input[name=icDateFrom]').val() != null 
				|| $('input[name=icDateFrom]').val() != "" ){
			$("input[name=icDateTo]").datepicker("option", "minDate", $("input[name=icDateFrom]").val());
		}
	});
	
	$('input[name=icDateTo]').change(function() {
		if( $('input[name=icDateTo]').val() != null 
				|| $('input[name=icDateTo]').val() != "" ){
			$("input[name=icDateFrom]").datepicker("option", "maxDate", $("input[name=icDateTo]").val());
		}
	});
});
