/**
 * Created with IntelliJ IDEA.
 * User: dcrtantuco
 * Date: 11/27/13
 * Time: 4:22 PM
 * To change this template use File | Settings | File Templates.
 */


function compareNumberAndInvalid(){
    var number = $("#taxAccountNumber").val();
   // var validNumberPattern = /^\d{3}-\d{3}-\d{3}-\d{3}$/;
   // var validNumberPattern = /^([0-9\(\)\/\+ \-]*)$/;



    if(number.match(validNumberPattern))
    {
        if (number.match(validNumberPattern))
        {
            triggerAlertMessage("Invalid Number");
            $("#taxAccountNumber").val("");
        }
    }
    else
    {
        triggerAlertMessage("Invalid Tax Account Number");
        $("#taxAccountNumber").val("");

    }

}

function  triggerAlertMessage(text1){
      $("#alertMessage").text(text1);
      centerPopup("popup_alert_dv","popup_alert_bg");
      loadPopup("popup_alert_dv","popup_alert_bg");
}

function disableAlertMessage(){

     disablePopup("popup_alert_dv","popup_alert_bg");
}

$(document).ready(function(){
     $("#taxAccountNumber").change(compareTaxAccountNumberAndInvalid);
     $("#btnAlertOk").click(disableAlertMessage);

});