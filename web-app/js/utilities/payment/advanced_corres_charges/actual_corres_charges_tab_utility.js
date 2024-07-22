/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 11/5/12
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */

function setNetBillingCurrencySettlement() {
    var settlementCurrency = $("#settlementCurrency").val();
    alert(settlementCurrency)
//    if(settlementCurrency != "") {
//        $("#netBillingCurrencySettlement").val(settlementCurrency);
//    }else {
//        $("#netBillingCurrencySettlement").val("");
//    }
}

function wireCurrencies() {
    $("#settlementCurrency").change(setNetBillingCurrencySettlement);
}

$(wireCurrencies);
