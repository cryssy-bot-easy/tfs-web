function setupUploadTransactions(){
    //var uploadTransactionsUrl = '';

    setupJqGridWidthPagerHidden('cdt_list_upload_transactions', {width: 780, loadui: "disable", scrollOffset:0, sortable: false},
        [['iedNumber', 'IED/IERD No.'],
            ['aabNumber', 'AAB Ref No.'],
            ['importerName', 'Importer\'s Name'],
            ['tfsCdtAmount', 'TFS CDT Amount', 85, 'right', (title.indexOf("Upload Transactions")!=-1 ? 'hidden' : '')],
            ['cdtAmount', 'e2m CDT Amount', 85, 'right', ''],
            ['requestType', 'Request Type', 85, 'center'],
//            ['emailed', 'E-mailed'],
            ['collectionStatus', 'Status in e2m', 75, 'center', ''],
            ['tfsCollectionStatus', 'Status in TFS', 75, 'center', (title.indexOf("Upload Transactions")!=-1 ? 'hidden' : '')],
            ['receivedDate', 'Received Date', 75, 'center', ''],
            ['collectionAction', 'Action']], 'cdt_pager_upload_transactions', searchCdtPaymentUrl + ("?headerTitle=" + title));

    var postUrl = searchCdtPaymentUrl;
    postUrl += ("?headerTitle=" + title)
    // postUrl += "?"+$("#cdtPaymentInquiryForm").serialize();

    $("#cdt_list_upload_transactions").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}

function onViewPayment(){
    var url = "";

    url = payDutiesAndTaxesUrl;
    url += '?serviceType='+"Customs Duties and Taxes";
    url += '&documentType='+"Collection";
    url += '&referenceType='+"Pay Duties and Taxes";
//	url += '&username='+$("#username").val();
    location.href = url;
}

function initUploadTransactions(){
    setupUploadTransactions();

//	var gridList = $('#cdt_list_upload_transactions');
//
//	gridList.addRowData("1", {requestType:"Advanced",emailed:"Sent",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("2", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("3", {requestType:"Advanced",emailed:"Failed",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("4", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("5", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
}

$(initUploadTransactions);

