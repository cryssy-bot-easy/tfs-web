/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/9/12
 * Time: 1:25 AM
 * To change this template use File | Settings | File Templates.
 */

function onChangeArDocumentNumber() {
    var apBalDisplay2Charges=$(".display-ap-balance2_charges");
    var apBalDisplay1Charges=$(".display-ap-balance1_charges");

    var apDocumentNumbers = stringToListHashMap(accountsReceivable);

    var apOutstandingBalance = null;
    var apCount = 0;

    for(var ctr = 0; ctr < apDocumentNumbers.length; ctr++) {
        if(this.value == apDocumentNumbers[ctr].SETTLEMENTACCOUNTNUMBER) {
            if(parseInt(apDocumentNumbers[ctr].DEBITCOUNT) == 1) {
                apOutstandingBalance = apDocumentNumbers[ctr].AROUTSTANDINGBALANCE;
            }

            apCount = apDocumentNumbers[ctr].DEBITCOUNT;
        }
    }

    var url = findAllArByDocNumUrl;

    if(parseInt(apCount) == 1) {
        $('.mode_of_payment_buttons').css("display", "block");
        apBalDisplay2Charges.css("display", "block");
        apBalDisplay1Charges.css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

        $("#apOutstandingBalance").val(formatCurrency(apOutstandingBalance));

        url += "?documentNumber="+this.value;

        $.post(url,{},function(data){
            $("#arReferenceId").val(data.referenceId);
        });
    }else if(parseInt(apCount) > 1){
        $('.mode_of_payment_buttons').css("display", "block");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "block");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

        url += "?documentNumber="+this.value;
        $("#grid_list_ap_balance_charges").jqGrid('setGridParam', {url: url, page: 1}).trigger("reloadGrid");
    } else{
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
    }
}

function setupAccountsPayableDocumentNumbers() {
    var apDocumentNumbers;

    if(accountsReceivable) {
        apDocumentNumbers = stringToListHashMap(accountsReceivable);

        for(var ctr = 0; ctr < apDocumentNumbers.length; ctr++) {
            var val = apDocumentNumbers[ctr].SETTLEMENTACCOUNTNUMBER;
            var option = "<option value="+val+">"+val+"</option>"

            $("#documentReferenceNumberAr").append(option);
        }

        $("#documentReferenceNumberAr").change(onChangeArDocumentNumber);
    }
}

$(setupAccountsPayableDocumentNumbers);
