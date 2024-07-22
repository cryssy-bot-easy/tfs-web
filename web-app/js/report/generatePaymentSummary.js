//@js/gsp

// rest of parameters are found in GenericReports Controller
function generatePaymentSummaryReport(){
    var tmpPaymentSummaryUrl = paymentSummaryUrl;

    var count = 0;
    var countCharges = 0;
    
    if((documentType == "DOMESTIC" && serviceType == "Adjustment") 
    	|| (documentType == "DOMESTIC" && serviceType.toUpperCase() == "NEGOTIATION" && documentSubType2 == "USANCE")
    	|| (documentClass == "CORRES_CHARGE")) {
    		tmpPaymentSummaryUrl += "?paymentSummary=WC";
    } else if(documentType == "DOMESTIC" && documentSubType1 == "CASH" && documentClass == "LC" && serviceType.toUpperCase() == "NEGOTIATION") {
        tmpPaymentSummaryUrl += "?paymentSummary=WP";
	} else {
        tmpPaymentSummaryUrl += "?paymentSummary=A";
    }

    if($("#currency").val()!="" && $("#currency").val()!=undefined) {
        tmpPaymentSummaryUrl += "&currency=" + $("#currency").val();
    } else if($("#originalCurrency").val()!="" && $("#originalCurrency").val()!=undefined) {
        tmpPaymentSummaryUrl += "&currency=" + $("#originalCurrency").val();
    } else {
        tmpPaymentSummaryUrl += "&currency=" + $("#negotiationCurrency").val();
    }

    tmpPaymentSummaryUrl += "&settlementCurrencyLc=" + $("#settlementCurrencyLc").val();
    tmpPaymentSummaryUrl += "&totalAmountDueLc=" + $("#totalAmountDueLc").val();
    tmpPaymentSummaryUrl += "&documentNumber=" + $("#documentNumber").val();
    tmpPaymentSummaryUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
    tmpPaymentSummaryUrl += "&documentType=" + $("#documentType").val();
    tmpPaymentSummaryUrl += "&serviceType=" + $("#serviceType").val();
    tmpPaymentSummaryUrl += "&pnNumber=" + $("#pnNumber").val();
    tmpPaymentSummaryUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
    tmpPaymentSummaryUrl += "&preparedByFirstName=" + $("#preparedByFirstName").val();
    tmpPaymentSummaryUrl += "&preparedByLastName=" + $("#preparedByLastName").val();
    tmpPaymentSummaryUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();
    tmpPaymentSummaryUrl += "&totalAmountOfPaymentLc=" + $("#totalAmountOfPaymentLc").val();
    tmpPaymentSummaryUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentCharges").val();
    tmpPaymentSummaryUrl += "&forexTableRowCount=" + $("#forex_product tr").length;

    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $.each(gridDataCashPayment,function(idx, data) {
        count = count + 1;
        tmpPaymentSummaryUrl += "&accountNumber" + count + "=" + data.accountNumber;
        tmpPaymentSummaryUrl += "&modeOfPayment" + count + "=" + data.modeOfPayment;
        tmpPaymentSummaryUrl += "&settlementCurrency" + count + "=" + data.settlementCurrency;
        tmpPaymentSummaryUrl += "&amountSettlement" + count + "=" + data.amountSettlement;
        tmpPaymentSummaryUrl += "&amount" + count + "=" + data.amount;

        if(data.modeOfPayment.indexOf("Loan") != -1) {
            tmpPaymentSummaryUrl += "&pnNumberTrue=true";
        }
    });

    var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
    $.each(gridDataChargesPayment,function(idx, data) {
        countCharges = countCharges + 1;
        tmpPaymentSummaryUrl += "&accountNumberCharges" + countCharges + "=" + data.accountNumber;
        tmpPaymentSummaryUrl += "&modeOfPaymentCharges" + countCharges + "=" + data.modeOfPayment;
        tmpPaymentSummaryUrl += "&settlementCurrencyCharges" + countCharges + "=" + data.settlementCurrency;
        tmpPaymentSummaryUrl += "&amountSettlementCharges" + countCharges + "=" + data.amountSettlement;
    });
    
    if($("#documentType").val() == "DOMESTIC" && $("#documentSubType1").val() == "CASH"	&& $("#documentClass").val() == "LC" && $("#serviceType").val().toUpperCase() == "NEGOTIATION") {
    	var gridDataProceedsPayment = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
    	$.each(gridDataProceedsPayment,function(idx, data) {
    		tmpPaymentSummaryUrl += "&accountNumberProceeds=" + data.accountNumber;
    		tmpPaymentSummaryUrl += "&modeOfPaymentProceeds=" + data.modeOfPayment;
            tmpPaymentSummaryUrl += "&settlementCurrencyProceeds=" + data.settlementCurrency;
            tmpPaymentSummaryUrl += "&amountSettlementProceeds=" + data.amountSettlement;
    	});
    }

    window.open(tmpPaymentSummaryUrl);
}

function generatePaymentSummaryWithoutCashReport(){
    var tmpPaymentSummaryWithoutCashUrl = paymentSummaryWithoutCashUrl;

    var countCharges = 0;
    
    tmpPaymentSummaryWithoutCashUrl += "?paymentSummary=B";

    if($("#currency").val()!="" && $("#currency").val()!=undefined) {
        tmpPaymentSummaryWithoutCashUrl += "&currency=" + $("#currency").val();
    } else if($("#originalCurrency").val()!="" && $("#originalCurrency").val()!=undefined) {
        tmpPaymentSummaryWithoutCashUrl += "&currency=" + $("#originalCurrency").val();
    } else {
        tmpPaymentSummaryWithoutCashUrl += "&currency=" + $("#negotiationCurrency").val();
    }

    tmpPaymentSummaryWithoutCashUrl += "&documentNumber=" + $("#documentNumber").val();
    tmpPaymentSummaryWithoutCashUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
    tmpPaymentSummaryWithoutCashUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
    tmpPaymentSummaryWithoutCashUrl += "&preparedByFirstName=" + $("#preparedByFirstName").val();
    tmpPaymentSummaryWithoutCashUrl += "&preparedByLastName=" + $("#preparedByLastName").val();
    tmpPaymentSummaryWithoutCashUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();
    tmpPaymentSummaryWithoutCashUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentCharges").val();
    tmpPaymentSummaryWithoutCashUrl += "&forexTableRowCount=" + $("#forex_charges tr").length;

    var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
    $.each(gridDataChargesPayment,function(idx, data) {
        countCharges = countCharges + 1;
        tmpPaymentSummaryWithoutCashUrl += "&accountNumber" + countCharges + "=" + data.accountNumber;
        tmpPaymentSummaryWithoutCashUrl += "&modeOfPaymentCharges" + countCharges + "=" + data.modeOfPayment;
        tmpPaymentSummaryWithoutCashUrl += "&settlementCurrency" + countCharges + "=" + data.settlementCurrency;
        tmpPaymentSummaryWithoutCashUrl += "&amountSettlement" + countCharges + "=" + data.amountSettlement;
    });

    window.open(tmpPaymentSummaryWithoutCashUrl);

}

function generatePaymentSummaryOtherImports(){
    var tmpPaymentSummaryOtherImportsUrl = paymentSummaryOtherImportsUrl;

    var count = 0;
    
    tmpPaymentSummaryOtherImportsUrl += "?paymentSummary=MD";
    
    if($("#currency").val()!="" && $("#currency").val()!=undefined) {
        tmpPaymentSummaryOtherImportsUrl += "&currency=" + $("#currency").val();
    } else if($("#originalCurrency").val()!="" && $("#originalCurrency").val()!=undefined) {
        tmpPaymentSummaryOtherImportsUrl += "&currency=" + $("#originalCurrency").val();
    } else {
        tmpPaymentSummaryOtherImportsUrl += "&currency=" + $("#negotiationCurrency").val();
    }
    
    if($("#currency").val()!="" && $("#currency").val()!=undefined) {
	tmpPaymentSummaryOtherImportsUrl += "&currency=" + $("#currency").val();
    } else {
	tmpPaymentSummaryOtherImportsUrl += "&currency=" + $("#originalCurrency").val();
    }

    tmpPaymentSummaryOtherImportsUrl += "&documentNumber=" + $("#documentNumber").val();
    tmpPaymentSummaryOtherImportsUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
    tmpPaymentSummaryOtherImportsUrl += "&preparedByFirstName=" + $("#preparedByFirstName").val();
    tmpPaymentSummaryOtherImportsUrl += "&preparedByLastName=" + $("#preparedByLastName").val();
    tmpPaymentSummaryOtherImportsUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();

    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $.each(gridDataCashPayment,function(idx, data) {
        count = count + 1;
        tmpPaymentSummaryOtherImportsUrl += "&accountNumber" + count + "=" + data.accountNumber;
        tmpPaymentSummaryOtherImportsUrl += "&modeOfPayment" + count + "=" + data.modeOfPayment;
        tmpPaymentSummaryOtherImportsUrl += "&settlementCurrency" + count + "=" + data.settlementCurrency;
        tmpPaymentSummaryOtherImportsUrl += "&amountSettlement" + count + "=" + data.amountSettlement;
        tmpPaymentSummaryOtherImportsUrl += "&amount" + count + "=" + data.amount;
    });

    window.open(tmpPaymentSummaryOtherImportsUrl);

}

function showPaymentSummary() {

    var documentClass = $("#documentClass").val();
    var documentSubType1 = $("#documentSubType1").val();
    var serviceType = $("#serviceType").val().toUpperCase();
    var overdrawnAmount = $("#overdrawnAmount").val();

    if(documentSubType1 == "CASH") {
        if(serviceType == "OPENING" || (serviceType == "AMENDMENT" && lcAmountFlag == "INC")) {
            checkIfPaidPaymentSummaryWithCash();
        }
        else if(serviceType == "AMENDMENT" && lcAmountFlag != "INC") {
            checkIfPaidPaymentSummaryWithoutCash();
        }
        else if($("#documentType").val() == "DOMESTIC" && documentClass == "LC" && serviceType == "NEGOTIATION") {
        	checkIfPaidPaymentSummaryWithCash();
        }
        else if(serviceType == "NEGOTIATION" && overdrawnAmount != "0.00") {
            checkIfPaidPaymentSummaryWithCash();
        }
        else if(serviceType == "NEGOTIATION" && overdrawnAmount == "0.00") {
            checkIfPaidPaymentSummaryWithoutCash();
        }
        else if(documentClass == "INDEMNITY" && (serviceType == "ISSUANCE" || serviceType == "CANCELLATION")) {
            checkIfPaidPaymentSummaryWithoutCash();
        }
    }
    if(documentSubType1 == "REGULAR") {
        if(serviceType == "ADJUSTMENT") {
            if(($("#partialCashSettlementFlagBox").checked=true) && $("#cashAmount").length == 0) {
                checkIfPaidPaymentSummaryWithCash();
            }
        }
        else if(serviceType == "NEGOTIATION") {
            checkIfPaidPaymentSummaryWithCash();
        }
        else if((serviceType == "UA LOAN SETTLEMENT" || serviceType == "UA_LOAN_SETTLEMENT") && documentSubType2 == "USANCE") {
            checkIfPaidPaymentSummaryWithCash();
        }
        else if(serviceType == "OPENING" || serviceType == "AMENDMENT" || serviceType == "ISSUANCE" || serviceType == "CANCELLATION" || serviceType == "UA LOAN MATURITY ADJUSTMENT") {
            checkIfPaidPaymentSummaryWithoutCash();
        }
        else if(serviceType == "UA LOAN MATURITY ADJUSTMENT" || serviceType == "UA_LOAN_MATURITY_ADJUSTMENT") {
            checkIfPaidPaymentSummaryWithoutCash();
        }
    }

    if(documentSubType1 == "STANDBY") {
        if(serviceType == "NEGOTIATION"){
            checkIfPaidPaymentSummaryWithCash();
        }
        else if(serviceType == "OPENING" || serviceType == "AMENDMENT" || (serviceType == "UA LOAN MATURITY ADJUSTMENT" || serviceType == "UA_LOAN_MATURITY_ADJUSTMENT") || (serviceType == "UA LOAN SETTLEMENT" || serviceType == "UA_LOAN_SETTLEMENT")){
            checkIfPaidPaymentSummaryWithoutCash();
        }
    }

    if((documentClass == "DA" || documentClass == "DP" || documentClass == "DR" || documentClass == "OA") && serviceType.toUpperCase() == "SETTLEMENT") {
        checkIfPaidPaymentSummaryWithCash();
    }

    if(documentClass == "MD" && serviceType == "COLLECTION") {
        checkIfPaidPaymentSummaryWithCash();
    }

    if(documentClass == "EXPORT_ADVISING" || documentClass == "BC" || (documentClass == "IMPORT_CHARGES" && serviceType.toUpperCase() == "PAYMENT_OTHER")) {
    	checkIfPaidPaymentSummaryWithoutCash();
    }
    
    if(documentClass == "BP") {
    	checkIfPaidPaymentSummaryWithCash();
    }
    
    if(documentClass == "CORRES_CHARGE" || (documentClass == 'IMPORT_ADVANCE' && serviceType == 'PAYMENT')) {
    	checkIfPaidPaymentSummaryWithCash();
    }
}

function checkIfPaidPaymentSummaryWithCash() {
    $(".showPaySummaryWithCash").show();
    $(".showPaySummaryWithoutCash").hide();

    var count = 0;

    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $.each(gridDataCashPayment,function(idx, data) {
        if(data.status == "Paid" || data.status == "Accepted"){
            count = count + 1;
        }
    });
    
    var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
    $.each(gridDataChargesPayment,function(idx, data) {
        if(data.status == "Paid"){
            count = count + 1;
        }
    });

    if($("#documentType").val() == "DOMESTIC" && $("#documentSubType1").val() == "CASH"	&& $("#documentClass").val() == "LC" && $("#serviceType").val().toUpperCase() == "NEGOTIATION") {
    	var gridDataProceedsPayment = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
    	$.each(gridDataProceedsPayment,function(idx, data) {
    		if(data.status == "Paid"){
    			count = count + 1;
    		}
    	});    	
    }
    
    if(count >= 1){
        $(".enablePaySummaryWithCash").attr("id", "viewPaymentSummaryPayment");
        $(".enablePaySummaryWithCash").removeClass("disablePaySummaryWithCash");
    }

    else {
        $(".enablePaySummaryWithCash").removeAttr("id");
        $(".enablePaySummaryWithCash").addClass("disablePaySummaryWithCash");
    }
    
}

function checkIfPaidPaymentSummaryWithoutCash() {
    $(".showPaySummaryWithCash").hide();
    $(".showPaySummaryWithoutCash").show();

    var count = 0;

    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $.each(gridDataCashPayment,function(idx, data) {
        if(data.status == "Paid" || data.status == "Accepted"){
            count = count + 1;
        }
    });

    var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
    $.each(gridDataChargesPayment,function(idx, data) {
        if(data.status == "Paid"){
            count = count + 1;
        }
    });

    if(count >= 1){
        $(".enablePaySummaryWithoutCash").attr("id", "viewPaymentSummaryWithoutCash");
        $(".enablePaySummaryWithoutCash").removeClass("disablePaySummaryWithoutCash");
    }

    else {
        $(".enablePaySummaryWithoutCash").removeAttr("id");
        $(".enablePaySummaryWithoutCash").addClass("disablePaySummaryWithoutCash");
    }

}

$(document).ready(function() {

    var documentClass = $("#documentClass").val();
    var serviceType = $("#serviceType").val();

    $(".showPaySummaryWithCash").show();
    $(".showPaySummaryWithoutCash").hide();

//	$("#grid_list_cash_payment_summary").mouseover(showPaymentSummary);
//	$("#grid_list_charges_payment").mouseover(showPaymentSummary);

    $("#viewPaymentSummaryPayment").live("click",function(){
        if(documentClass == "MD" && serviceType == "Collection") {
            generatePaymentSummaryOtherImports();
        }
        else {
            generatePaymentSummaryReport();
        }
    });

    $("#viewPaymentSummaryWithoutCash").live("click",function(){
        generatePaymentSummaryWithoutCashReport();
    });
});