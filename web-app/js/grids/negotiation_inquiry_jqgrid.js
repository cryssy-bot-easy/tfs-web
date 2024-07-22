function setupnegotiationInquiryGrids(){

        
        setupJqGridPagerWithHidden('grid_list_negotiation_inquiry_branch', {width: 780, height: 355, loadui: "disable", scrollOffset:0, rowNum: 20},
        		[['documentNumber', 'Document Number'], 
              		['negotiationNumber', 'Negotiation Number'],//added on sept 20
              		['negotiationDate', 'Negotiation Date'],//added on sept 20
              		['negoBankRefNum', 'Nego Bank Ref. Num'],//added on sept 20
              		['valueDate','Value Date'],
              		['maturityDate','Maturity Date'],
              		['pnNumber','PN Number'],				//added on sept 20
                    ['negotiationAmount', 'Negotiation Amount'],  // added july 1
              		['outstandingBalance', 'O/S Balance'],
                    ['etsAction', 'Create UA'],
                    ['documentType', 'Document Type', 'center', 'hidden']], 'grid_pager_negotiation_inquiry_branch', '');
        		/*
        		 [['documentNumber', 'Document Number'],
                 ['outstandingBalance', 'O/S FXLC Balance'],
                 ['shipmentNumber', 'Shipment Number'],
                 ['negotiationType', 'Negotiation Type'],
                 ['referenceNumber','Reference Number'],
                 ['negotiationCurrency','Negotiation Currency'],
                 ['negotiationAmount','Negotiation Amount'],
                 ['valueDate','Value Date'],
                 ['maturityDate','Maturity Date'],
                 ['etsAction', 'Create eTS'],
                 ['serviceType', 'Service Type', 'center', 'hidden'],
                 ['documentType', 'Document Type', 'center', 'hidden'],
                 ['documentClass', 'Document Class', 'center', 'hidden'],
                 ['documentSubType1', 'SubType1', 'center', 'hidden'],
                 ['documentSubType2', 'SubType2', 'center', 'hidden']],'grid_pager_negotiation_inquiry_branch', branchNegotiationInquiryUrl);
               
                 ['outstandingBalance', 'O/S FXLC Balance'],
                ['shipmentNumber', 'Shipment Number'],
                ['negotiationType', 'Negotiation Type'],
                ['referenceNumber','Reference Number'],
                ['negotiationCurrency','Negotiation Currency'],
                ['negotiationAmount','Negotiation Amount'],
                ['valueDate','Value Date'],
                ['maturityDate','Maturity Date'],
                ['etsAction', 'Create eTS'],
                ['documentType', 'Document Type', 'center', 'hidden']], 'grid_pager_negotiation_inquiry_branch', branchNegotiationInquiryUrl);                 
                 */
        
    
    setupJqGridPagerWithHidden('grid_list_negotiation_inquiry_main', {width: 780, height: 355, loadui: "disable", scrollOffset:0, rowNum: 20},
    			[['unitCode', 'Unit Code', 'center'],
    			 	['documentNumber', 'Document Number'],
    			 	['negotiationNumber', 'Negotiation Number'],//added on sept 20
    			 	['negotiationDate', 'Negotiation Date'],//added on sept 20
    			 	['negoBankRefNum', 'Nego Bank Ref. Num'],//added on sept 20
    			 	['valueDate','Value Date'],
    			 	['maturityDate','Maturity Date'],
    			 	['pnNumber','PN Number'],				//added on sept 20
                    ['negotiationAmount', 'Negotiation Amount'], // added july 1
    			 	['outstandingBalance', 'O/S Balance'],
                    ['etsAction', 'Create UA', 'left', 'hidden'],
                    ['documentType', 'Document Type', 'center', 'hidden']], 'grid_pager_negotiation_inquiry_main', '');
    			/*
    			[['documentNumber', 'Document Number'],
    			 	['outstandingBalance', 'O/S FXLC Balance'],
    			 	['shipmentNumber', 'Shipment Number'],
    			 	['negotiationType', 'Negotiation Type'],
    			 	['referenceNumber','Reference Number'],
    			 	['negotiationCurrency','Negotiation Currency'],
    			 	['negotiationAmount','Negotiation Amount'],
    			 	['valueDate','Value Date'],
    			 	['maturityDate','Maturity Date'],
    			 	['etsAction', 'Create eTS'],
    			 	['serviceType', 'Service Type', 'center', 'hidden'],
    			 	['documentType', 'Document Type', 'center', 'hidden'],
    			 	['documentClass', 'Document Class', 'center', 'hidden'],
    			 	['documentSubType1', 'SubType1', 'center', 'hidden'],
    			 	['documentSubType2', 'SubType2', 'center', 'hidden']], 'grid_pager_negotiation_inquiry_main', mainNegotiationInquiryUrl);
                ['outstandingBalance', 'O/S FXLC Balance'],
                ['shipmentNumber', 'Shipment Number'],
                ['negotiationType', 'Negotiation Type'],
                ['referenceNumber','Reference Number'],
                ['negotiationCurrency','Negotiation Currency'],
                ['negotiationAmount','Negotiation Amount'],
                ['valueDate','Value Date'],
                ['maturityDate','Maturity Date'],
                ['etsAction', 'Create eTS'],
                ['documentType', 'Document Type', 'center', 'hidden']], 'grid_pager_negotiation_inquiry_branch', branchNegotiationInquiryUrl);
*/
        
}

function setupnegotiationInquiryGridsValidation(){
	if($("#grid_list_negotiation_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_negotiation_inquiry_branch").jqGrid("hideCol","etsAction").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
	if($("#grid_list_negotiation_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_negotiation_inquiry_main").jqGrid("hideCol","etsAction").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function onCreateUa(id,documentType) {

    $("input[name=createUa]").attr('checked', false);

    loadPopup("create_ua_popup", "create_ua_popup_bg");
    centerPopup("create_ua_popup", "create_ua_popup_bg");

    $("#tradeServiceId").val(id);
    $("#documentType").val(documentType);


    var grid;

    if($("#grid_list_negotiation_inquiry_main").length > 0) {
        grid = $("#grid_list_negotiation_inquiry_main");
    } else if($("#grid_list_negotiation_inquiry_branch").length > 0) {
        grid = $("#grid_list_negotiation_inquiry_branch");
    }

    var data = grid.jqGrid("getRowData", id);

    //$("#id").val(id);
    //$("#documentType").val(documentType);
    
    if($("#uaRedirectTo").attr("disabled") != "disabled"){
    	$("#uaRedirectTo").attr("disabled", "disabled");
    }
}

function initNegotiationInquiryGrid(){
	setupnegotiationInquiryGrids();
	setupnegotiationInquiryGridsValidation();
}

$(initNegotiationInquiryGrid);

