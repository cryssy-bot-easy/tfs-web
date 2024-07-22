/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/25/12
 * Time: 6:50 PM
 * To change this template use File | Settings | File Templates.
 */

function computeOverDrawnAmountFromIc() {
    var negotiationAmount = $("#negotiationAmount").val();
    var outstandingBalance = $("#outstandingBalance").val()
    var apCashAmountInNegotiationCurrency = $("#cashAmount").val();

    var apCashAmount = 0;

    if(apCashAmountInNegotiationCurrency != "") {
        apCashAmount = parseFloat(stripCommas(apCashAmountInNegotiationCurrency));
    }

    var overdrawnAmount = 0;
    var documentSubType1 = $("#documentSubType1").val();
    

    negotiationAmount = parseFloat(stripCommas(negotiationAmount));
    outstandingBalance = parseFloat(stripCommas(outstandingBalance));
	console.log("negotiationAmount : " + negotiationAmount);
	console.log("outstandingBalance : " + outstandingBalance);
    
    if (documentSubType1 == "REGULAR") {
    	console.log("The document in Regular");
    	overdrawnAmount = parseFloat(negotiationAmount - apCashAmount);
    } else if (documentSubType1 == "CASH") {
    	console.log("The document in Cash");
        if (outstandingBalance < negotiationAmount) {
        	console.log("outstandingBalance" + outstandingBalance);
        	console.log("negotiationAmount" + negotiationAmount);
        	overdrawnAmount = parseFloat(negotiationAmount - outstandingBalance);
        }
    }
    if(overdrawnAmount < 0) {
        overdrawnAmount = 0;
    }
    
    $("#overdrawnAmount").val(formatCurrency(overdrawnAmount));
}

function onIcNumberChange() {
    var icNumber = $("#icNumber").val();

    if(icNumber != "") {
        var ajaxPostUrl = icDetailsUrl;
        
        $.post(ajaxPostUrl, {icNumber: icNumber}, function(data){
            $("#negotiationAmount").attr("readonly", "readonly");
            $("#negotiationAmount").val(data.negotiationAmount);

            $("#negotiationBank").val(data.negotiationBank);
            $("#negotiationBankRefNumber").val(data.negotiationBankRefNumber);
            $("#senderToReceiverInformation").val(data.senderToReceiverInformation);

            $("#icCashAmount").val(data.icCashAmount);
            $("#icRegularAmount").val(data.icRegularAmount);
            
            computeOverDrawnAmountFromIc();
        });
    } else {
        $("#negotiationAmount").removeAttr("readonly");
        $("#negotiationAmount").val("");
        $("#negotiationBank").val("");
        $("#negotiationBankRefNumber").val("");
        $("#senderToReceiverInformation").val("");

        computeOverDrawnAmountFromIc();
    }

}

function setIcNumber() {
    var icNumber = $("#icNumber").val();
    if (icNumber != "") {
        var ajaxPostUrl = icDetailsUrl;

        $.post(ajaxPostUrl, {icNumber: icNumber}, function(data){
            $("#negotiationAmount").attr("readonly", "readonly");
            $("#negotiationAmount").val(data.negotiationAmount);

            $("#negotiationBank").val(data.negotiationBank);
            $("#negotiationBankRefNumber").val(data.negotiationBankRefNumber);
            $("#senderToReceiverInformation").val(data.senderToReceiverInformation);

            $("#icCashAmount").val(data.icCashAmount);
            $("#icRegularAmount").val(data.icRegularAmount);
            
            computeOverDrawnAmountFromIc();
        });
    }
}

function initializeIcWiring() {
    $("#icNumber").change(onIcNumberChange);
//    onIcNumberChange();

    setIcNumber();
}

$(initializeIcWiring);