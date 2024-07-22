function setupUnactedAdviseOnExport(){
	var gridUrl = unactedExportAdvisingUrl;
    var _opt ={width: 780, loadui: "disable", scrollOffset: 0};
    if('undefined' !== typeof setTsdGrid && '' != setTsdGrid){
    	$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
    }
	
		setupJqGridWidthPagerHidden('grid_list_advise_on_export_unacted',_opt,
				[['documentNumber', 'Document Number'],
					['cifName', 'CIF Name'],
					['exportersName', 'Exporter\'s Name'],
					['transactionType', 'Transaction Type'],
					['lcCurrency', 'LC Currency'],
					['lcAmount', 'LC Amount'],
					['dataEntry', 'Data Entry'],
					['payCharges', 'Payment'],
                    ['documentSubType1', 'Document Subtype1',200, 'center', 'hidden'],
                    ['serviceType', 'Service Type',200, 'center', 'hidden']], 'grid_pager_advise_on_export_unacted', gridUrl);
}

function viewExportAdvising(id) {
    var data = $("#grid_list_advise_on_export_unacted").jqGrid("getRowData", id);

    var url = viewDataEntryUrl;
    url += "?tradeServiceId="+id+
        "&documentClass=EXPORT_ADVISING"+
        "&serviceType="+data.serviceType+
        "&documentSubType1="+data.documentSubType1;

    location.href = url;
}

function payExportAdvising(id) {
    var data = $("#grid_list_advise_on_export_unacted").jqGrid("getRowData", id);

    var url = viewChargesUrl;
    url += "?tradeServiceId="+id+
        "&documentClass=EXPORT_ADVISING"+
        "&documentSubType1="+data.documentSubType1+
        "&serviceType="+data.serviceType;

    location.href = url;
}

function onChargesAdviseOnExportClick(id) {
	var grid = $("#grid_list_advise_on_export_unacted").jqGrid("getRowData",id);
	var url = '';
	var referenceType = "Payment Processing";
	if (grid.serviceType.toLowerCase() == 'opening'){
		url = chargesAdvisingBankOpeningUrl;
	}else if(grid.serviceType.toLowerCase() == 'cancellation'){
		url = chargesAdvisingBankAmendmentUrl;
	}else if(grid.serviceType.toLowerCase() == 'amendment'){
		url = chargesAdvisingBankCancellationUrl;
	}
	url += '?serviceType='+grid.serviceType;
	url += '&referenceType='+referenceType;
	url += '&subType2='+grid.subType2;
	location.href = url;
}

function onDataEntryAdviseOnExportClick(id) {
	var grid = $("#grid_list_advise_on_export_unacted").jqGrid("getRowData",id);
	var url = '';
	var referenceType = "Data Entry";
	var documentClass = "Advise"
	if (grid.serviceType.toLowerCase() == 'opening'){
		url = dataEntryAdvisingBankOpeningUrl;
	}else if(grid.serviceType.toLowerCase() == 'amendment'){
		url = dataEntryAdvisingBankAmendmentUrl;
	}else if(grid.serviceType.toLowerCase() == 'cancellation'){
		url = dataEntryAdvisingBankCancellationUrl;
	}
	url += '?serviceType='+grid.serviceType;
	url += '&referenceType='+referenceType;
	url += '&documentClass='+documentClass;
	url += '&subType2='+grid.subType2;
	location.href = url;
}

function initUnactedAdviseOnExport(){
	setupUnactedAdviseOnExport();
}

$(initUnactedAdviseOnExport);
