function onViewLcClick(id){
    var grid = null;

    if($("#grid_list_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_lc_inquiry_branch");
    } else {
        grid = $("#grid_list_lc_inquiry_main");
    }
    var gridData = grid.jqGrid("getRowData", id);

    var gotoUrl = viewLcUrl;
    gotoUrl += '?serviceType='+gridData.serviceType;
    gotoUrl += '&documentType='+gridData.documentType;
    gotoUrl += '&documentClass='+gridData.documentClass;
    gotoUrl += '&documentSubType1='+gridData.documentSubType1;
    gotoUrl += '&documentSubType2='+gridData.documentSubType2;
    gotoUrl += '&tradeServiceId='+id;

    location.href = gotoUrl;
}

function onCreateEtsClick(id) {
		
    $("#reinstateFlag").val("");

    var grid = null;

    var popup_div = "create_ets_popup";
    var popup_bg = "create_ets_popup_bg";
    var redirect_btn = "etsRedirectTo"

    var accessFrom = "";

    if($("#grid_list_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_lc_inquiry_branch");
        accessFrom = "br";
    } else {
        grid = $("#grid_list_lc_inquiry_main");
        accessFrom = "tsd";
        popup_div = "create_ets_main_popup";
        popup_bg = "create_ets_main_popup_bg";
        redirect_btn = "etsMainRedirectTo"
    }

    var data = grid.jqGrid("getRowData",id);
    
    var documentNumber = data.documentNumber;
    var status = data.status;
    //alert("status = " +status)
    
    var cifNumber = data.cifNumber;
    var mainCifNumber = data.mainCifNumber
    var documentSubType1 = data.documentSubType1;

    $("input[name=createEts]").attr('checked', false);
    $("input[name=createEtsMain]").attr('checked', false);
    
    // marv.13Oct2012.start - constructs available services based on criteria
    var postUrl = constructCreateEtsUrl;

    var params = {
        documentClass: "LC",
        documentNumber: id,
        accessFrom: accessFrom
    }

    $.post(postUrl, params, function(data) {
        $("#radioContainer").empty(); // clears radio container first
        $("#radioContainerTsd").empty(); // clears radio container first

        var container;
        var name;
        var on_click;
        if(accessFrom == "br") {
            name = "createEts";
            container = "#radioContainer";
            on_click = "onCreateEtsRadioClick()";
        } else if(accessFrom == "tsd") {
            name = "createEtsMain";
            container = "#radioContainerTsd";
            on_click = "onCreateEtsMainRadioClick()";
        }

        for (var key in data.radioItems) {
            $("<input type='radio' id='"+key+"' name='"+name+"' value='"+key+"' onclick='"+on_click+"'>&#160;<label for='"+key+"'>"+data.radioItems[key] + "</label><br/>").appendTo(container);
        }

        $("#tradeServiceId").val(id);
        $("#dnBranch").val(documentNumber);
        $("#dnTsd").val(documentNumber);

        $("#cNumber").val(cifNumber);
        $("#mcNumber").val(mainCifNumber);
        $("#dsType1").val(documentSubType1);

        if(status == "EXPIRED") { //"productStatus" sya dati
            onReinstate();
            return true;
        }

        loadPopup(popup_div, popup_bg);
        centerPopup(popup_div, popup_bg);
        if($("#"+redirect_btn).attr("disabled") != "disabled"){
        	$("#"+redirect_btn).attr("disabled", "disabled");
        }

    });
    // marv.13Oct2012.end

//    $("#lcNumber").val(id);

}


function closeEtsPopup() {
    $("#documentType").val("");
    $("#doucmentClass").val("");
    $("#documentSubType1").val("");

    disablePopup("create_ets_popup", "create_ets_popup_bg");
    $("#etsRedirectTo").attr("disabled", "disabled");
}

function onResetLcBtnClick() {
	var postUrl = branchLcInquiryUrl;
	postUrl += "?unitcode="+unitcode;
    var grid = null;

    if($("#grid_list_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_lc_inquiry_branch");
    } else {
        grid = $("#grid_list_lc_inquiry_main");
    }
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    $("#currency").select2("data",null);
    
//    $("#documentNumber, #cifName, #expiryDate, #currency, #amountFrom, #amountTo, #outstandingAmountFrom, #outstandingAmountTo").val("");
}

function onSearchLcBtnClick() {
    var postUrl = branchLcInquiryUrl;
    postUrl += "?"+$("#lcInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;

    if($("#grid_list_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_lc_inquiry_branch");
    } else {
        grid = $("#grid_list_lc_inquiry_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertLcCount}).trigger("reloadGrid");
}

function closeEtsMainPopup() {
	
	
    $("#documentType").val("");
    $("#doucmentClass").val("");
    $("#documentSubType1").val("");

    disablePopup("create_ets_main_popup", "create_ets_main_popup_bg");
    $("#etsMainRedirectTo").attr("disabled", "disabled");
}

function alertLcCount(){
	var grid;
	
	if ($("#grid_list_lc_inquiry_branch").length > 0) {
		grid = $("#grid_list_lc_inquiry_branch");
	} else {
		grid = $("#grid_list_lc_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function onReinstate() {
	
    var mSave_div = $("#popup_reinstate_div");
    var mBg = $("#confirmation_background");
   
    mLoadPopup(mSave_div, mBg);
    mCenterPopup(mSave_div, mBg);
}

function onReinstateConfirmClick() {
    var popup_div = "create_ets_popup";
    var popup_bg = "create_ets_popup_bg";
    //added by henry
    if($("#grid_list_lc_inquiry_branch").length > 0) {
        grid = $("#grid_list_lc_inquiry_branch");
        accessFrom = "br";
    } else {
        grid = $("#grid_list_lc_inquiry_main");
        accessFrom = "tsd";
        popup_div = "create_ets_main_popup";
        popup_bg = "create_ets_main_popup_bg";
        redirect_btn = "etsMainRedirectTo"
    }
    //end
    loadPopup(popup_div, popup_bg);
    centerPopup(popup_div, popup_bg);

    var mSave_div = $("#popup_reinstate_div");
    var mBg = $("#confirmation_background");

    $("#reinstateFlag").val("Y");
    mDisablePopup(mSave_div, mBg);
}

function onReinstateCancelClick() {
    var mSave_div = $("#popup_reinstate_div");
    var mBg = $("#confirmation_background");

    mDisablePopup(mSave_div, mBg);
}

function onCreateEtsRadioClick() {
	$("#etsRedirectTo").removeAttr("disabled");
}

function onCreateEtsMainRadioClick() {
	$("#etsMainRedirectTo").removeAttr("disabled");
}

function initializeEtsPopup() {
    $("#searchLcBtn").click(onSearchLcBtnClick);
    $("#resetLcBtn").click(onResetLcBtnClick);
    $("#cancelRedirect, #create_ets_popup_close").click(closeEtsPopup);

    $("#cancelMainRedirect, #create_ets_main_popup_close").click(closeEtsMainPopup);

    $("#reinstateConfirm").click(onReinstateConfirmClick);
    $("#reinstateNo, #reinstateCancel").click(onReinstateCancelClick);

    $("#currency").setCurrencyDropdown($(this).attr("id"));
    $("input[name=createEts]").click(onCreateEtsRadioClick);
    $("input[name=createEtsMain]").click(onCreateEtsMainRadioClick);
}

$(initializeEtsPopup)

