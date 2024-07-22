//@js/gsp
//	PROLOGUE:
//	(revision)
//	SCR/ER Number: 
//	SCR/ER Description: redmine 3700 - EBC Nego - Special characters and next words omitted
//	[Revised by:] Maximo Brian Lulab
//	[Date revised:] 04/04/2016
//	Program [Revision] Details: To have validation on input of additional instruction when special characters 
//                              are inputted,system auto-omit the special character and the words next to it on the nego advise generated.
//	Date deployment:  
//	Member Type: JS
//	Project: WEB
//	Project Name: _generateExportNegotiationAdivce.js



function generateExportNegotiationAdvice(){
	var tmpExportNegotiationAdviceUrl = exportNegotiationAdviceUrl;

	tmpExportNegotiationAdviceUrl += "?refNo=" + $("#documentNumber").val();
	tmpExportNegotiationAdviceUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpExportNegotiationAdviceUrl += "&currency=" + $("#currency").val();
	tmpExportNegotiationAdviceUrl += "&amount=" + $("#amount").val();
	tmpExportNegotiationAdviceUrl += "&usanceTenorTerm=" + ($("#lcTenor").val() == "SIGHT" ? "SIGHT" : ($("#usanceTerm").length > 0 ? $("#usanceTerm").val() : $("#nonLcTenorDisplay").length > 0 ? ($("#nonLcTenorDisplay").val() + " " + $("#nonLcTenorTerm").val()) : ""));
	tmpExportNegotiationAdviceUrl += "&authorizedSign=" + $("#authorizedSign").val();
	tmpExportNegotiationAdviceUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();
	tmpExportNegotiationAdviceUrl += "&drawee=" + $("#drawee").val();
	tmpExportNegotiationAdviceUrl += "&buyerName=" + $("#buyerName").val();
	tmpExportNegotiationAdviceUrl += "&documentType=" + $("#documentType").val();
	
	var selectedDocEnclosed = $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow");
	var documentsEnclosedList = "";

    $.each(selectedDocEnclosed, function(id, val) {
        var documentSelected = $("#grid_list_documents_enclosed").jqGrid("getRowData", val);

        documentSelected["id"] = val;

        documentsEnclosedList += JSON.stringify(documentSelected).split('\&').join('amp*').split('\'').join('apos*')+"|"
    });
    
    tmpExportNegotiationAdviceUrl += "&documentsEnclosedList=" + documentsEnclosedList;
    
    var selectedEnclosedInstructions = $("#grid_list_instructions").jqGrid("getGridParam", "selarrrow");
    var additionalInstructions = $("#grid_list_additional_conditions").jqGrid("getDataIDs");
    var instructionsList = "";
    $.each(selectedEnclosedInstructions, function(id, val) {
        var enclosedInstruction = $("#grid_list_instructions").jqGrid("getRowData", val);

        enclosedInstruction["id"] = val;
        delete enclosedInstruction.edit;

        instructionsList += JSON.stringify(enclosedInstruction).split('\&').join('amp*').split('\'').join('apos*')+"|"
    });
    
    $.each(additionalInstructions, function(id, val) {
    	var additionalInstruction = $("#grid_list_additional_conditions").jqGrid("getRowData", val);

    	additionalInstruction["id"] = val;
    	delete additionalInstruction.edit;
    	delete additionalInstruction.del;

        instructionsList += JSON.stringify(additionalInstruction)+"|"
    });
    //start validation of max redmine 3700 as of 4/04/2016
	tmpExportNegotiationAdviceUrl += "&instructionsList=" + instructionsList.replace("&","andreplace").replace("#","numreplace").replace("%","pcntreplace");
	// end of max validation
	tmpExportNegotiationAdviceUrl += "&issuingCollectingBank=" + ($("#paymentMode").val() == 'LC' ? $("#issuingBankName").val() : $("#paymentMode").val() in {DA:1,DP:1,OA:1,DR:1} ? $("#collectingBankName").val() : '');
	tmpExportNegotiationAdviceUrl += "&issuingCollectingBankAddress=" + ($("#paymentMode").val() == 'LC' ? $("#issuingBankAddress").val() : $("#paymentMode").val() in {DA:1,DP:1,OA:1,DR:1} ? $("#collectingBankAddress").val() : '');
	
	window.open(tmpExportNegotiationAdviceUrl);
}


function init() {	
	$('#viewExportNegotiationAdvice').click(generateExportNegotiationAdvice);
}

$(init);