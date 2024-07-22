// open facility lookup
function onFacilityLookup() {
	mLoadPopup($("#facility_popup"),$("#facility_search_bg"));
	mCenterPopup($("#facility_popup"),$("#facility_search_bg"));


    var pageUrl = facilitySearchUrl;

    if (serviceType.toUpperCase() == "ADJUSTMENT") {

    	if ($("#cifNumberTo").val() != "") {
            pageUrl += "?cifNumber="+$("#cifNumberTo").val().replace(/,/g,"");
        } else {
            pageUrl += "?cifNumber="+$("#cifNumberFrom").val().replace(/,/g,"");
        }
    	
        if($("#mainCifNumberTo").length > 0 && $("#mainCifNumberTo").val() != "") {
            pageUrl += "&mainCifNumber="+$("#mainCifNumberTo").val().replace(/,/g,"");
        } else {
            pageUrl += "&mainCifNumber"+$("#mainCifNumberFrom").val().replace(/,/g,"");
        }
    } else if (serviceType.toUpperCase() == "UA LOAN SETTLEMENT" || serviceType.toUpperCase() == "UA_LOAN_SETTLEMENT") {
        pageUrl = facilitySearchForUaUrl;
        pageUrl += "?cifNumber="+$("#cifNumber").val().replace(/,/g,"") + "&seqNo=" + $("#facilityIdParam").val() + "&currency=" + $("#currency").val();
    } else {
        pageUrl += "?cifNumber="+$("#cifNumber").val().replace(/,/g,"");
        if($("#mainCifNumber").length > 0 && $("#mainCifNumber").val() != "") {
            pageUrl += "&mainCifNumber="+$("#mainCifNumber").val().replace(/,/g,"");
        }
    }

    $("#grid_list_facility_type").jqGrid("setGridParam", {url: pageUrl, page: 1}).trigger("reloadGrid");
}

function searchLoanFacilities(){

    var mPopupDiv = $("#facility_popup");
    var mPopupBg = $("#facility_search_bg");

    mLoadPopup($("#facility_popup"),$("#facility_search_bg"));
    mCenterPopup($("#facility_popup"),$("#facility_search_bg"));
    var gridData = $("#grid_list_cash_payment_summary").jqGrid("getRowData", $("#selectionId").val());

    var url;
    var loanType = gridData.modeOfPayment;

    if(loanType=='IB Loan'){
        url =  ibLineFacilitySearchUrl
    }else if(loanType == 'UA Loan' || loanType == 'DUA Loan'){
        url = uaLineFacilitySearchUrl;
    }else if(loanType == 'TR Loan' || loanType == 'DTR Loan'){
        url = trLineFacilitySearchUrl;
    }else if(loanType == 'DBP Loan'){
        url = dbpLoanFacilitySearchUrl;
    }else if(loanType == 'EBP Loan'){
    	url = ebpLoanFacilitySearchUrl;
    }
    var currency;
    if(gridData.currency != undefined){
        currency  = gridData.currency;
    }else if(gridData.settlementCurrency != undefined){
        currency = gridData.settlementCurrency;
    }


    url += "?cifNumber="+$("#cifNumber").val() + "&mainCifNumber="+$("#mainCifNumber").val() + "&currency=" + currency + "&documentType=" + documentType;

    if ($("#facilityIdParam").length > 0 && $("#facilityIdParam").val() != "") {
        url += "&seqNo="+$("#facilityIdParam").val();
    }
    
    if ($("#bpFacilityType").length > 0 && $("#bpFacilityType").val() != "") {
        url += "&facilityType="+$("#bpFacilityType").val();
    }

//    $("#grid_list_facility_type").jqGrid("setGridParam", {data: "json", url: url, page: 1}).trigger("reloadGrid");
    $("#grid_list_facility_type").jqGrid("setGridParam", {url: url, page: 1}).trigger("reloadGrid");
}

//TODO: combine with ib and tr
function searchUALoanFacilities(){
    var mPopupDiv = $("#facility_popup");
    var mPopupBg = $("#facility_search_bg");
    mLoadPopup($("#facility_popup"),$("#facility_search_bg"));
    mCenterPopup($("#facility_popup"),$("#facility_search_bg"));

    var url = uaLineFacilitySearchUrl + "?cifNumber="+$("#cifNumber").val();

    $("#grid_list_facility_type").jqGrid("setGridParam", {url: url, page: 1}).trigger("reloadGrid");
}

// close facility lookup
function onCloseFacilityLookup() {
//    disablePopup(activePopupDiv, activePopupBg);
    mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
}

function initializeFacilityIdPopup(){
	$("#facility_lookup").click(onFacilityLookup);
	$(".facility_search_close").click(onCloseFacilityLookup);
    $("#ibFacilitySearchButton").click(searchLoanFacilities);
//    $("#uaFacilitySearchButton").click(searchUALoanFacilities);

}

$(initializeFacilityIdPopup);