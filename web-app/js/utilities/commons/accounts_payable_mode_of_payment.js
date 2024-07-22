/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/9/12
 * Time: 1:25 AM
 * To change this template use File | Settings | File Templates.
 */

function computeApBalance(apOutstandingBalance) {
    var rowData = $("#grid_list_charges_payment").jqGrid("getRowData");

    var totalAp = 0;

    for(i in rowData) {
        if(rowData[i].paymentMode == "AP") {
            var amount = rowData[i].amountSettlement;

            if(amount == undefined) {
                amount = rowData[i].amount;
            }

            totalAp += parseFloat(stripCommas(amount));
        }
    }

    apOutstandingBalance = parseFloat(stripCommas(apOutstandingBalance)) - totalAp;

    $("#apOutstandingBalance").val(formatCurrency(apOutstandingBalance));
}

function onChangeApDocumentNumber() {
    var apBalDisplay2Charges=$(".display-ap-balance2_charges");
    var apBalDisplay1Charges=$(".display-ap-balance1_charges");

    var apDocumentNumbers = stringToListHashMap(accountsPayable);

    var apOutstandingBalance = null;
    var apCount = 0;

    for(var ctr = 0; ctr < apDocumentNumbers.length; ctr++) {
        if(this.value == apDocumentNumbers[ctr].SETTLEMENTACCOUNTNUMBER) {
            if(parseInt(apDocumentNumbers[ctr].CREDITCOUNT) == 1) {
                apOutstandingBalance = apDocumentNumbers[ctr].APOUTSTANDINGBALANCE;
            }

            apCount = apDocumentNumbers[ctr].CREDITCOUNT;
        }
    }

    var url = findAllApByDocNumUrl;
    url += "?documentNumber="+this.value;

    if(parseInt(apCount) == 1) {
        $('.mode_of_payment_buttons').css("display", "block");
        apBalDisplay2Charges.css("display", "block");
        apBalDisplay1Charges.css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

        computeApBalance(apOutstandingBalance);
        $("#apOutstandingBalance").val(formatCurrency(apOutstandingBalance));

        $.post(url,{},function(data){
            $("#apReferenceId").val(data.referenceId);
        });
    }else if(parseInt(apCount) > 1){
        $('.mode_of_payment_buttons').css("display", "block");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "block");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

        $("#grid_list_ap_balance_charges").jqGrid('setGridParam', {url: url, page: 1}).trigger("reloadGrid");
    } else{
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
    }
}

function setupAccountsPayableDocumentNumbers() {
    var apDocumentNumbers;

    if(accountsPayable) {
        apDocumentNumbers = stringToListHashMap(accountsPayable);

        for(var ctr = 0; ctr < apDocumentNumbers.length; ctr++) {
            var val = apDocumentNumbers[ctr].SETTLEMENTACCOUNTNUMBER;
            var option = "<option value="+val+">"+val+"</option>"

            $("#documentReferenceNumberAp").append(option);
        }

        $("#documentReferenceNumberAp").change(onChangeApDocumentNumber);
    }
}

$(setupAccountsPayableDocumentNumbers);
