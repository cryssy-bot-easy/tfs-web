/**
 * Created with IntelliJ IDEA.
 * User: dcrtantuco
 * Date: 11/27/13
 * Time: 4:22 PM
 * To change this template use File | Settings | File Templates.
 */


function compareTaxAccountNumberAndInvalid(){
    var tax = $("#taxAccountNumber").val();
    var validTaxPattern = /^\d{3}-\d{3}-\d{3}-\d{3}$/;
    var invalid1='000-000-000-';
    var invalid2='000-000-000-000';
    var invalid3='111-111-111-000';
    var invalid4='111-111-111-111';
    var invalid5='222-222-222-000';
    var invalid6='222-222-222-222';
    var invalid7='333-333-333-000';
    var invalid8='333-333-333-333';
    var invalid9='444-444-444-000';
    var invalid10='444-444-444-444';
    var invalid11='555-555-555-000';
    var invalid12='555-555-555-555';
    var invalid13='666-666-666-000';
    var invalid14='666-666-666-666';
    var invalid15='777-777-777-000';
    var invalid16='777-777-777-777';
    var invalid17='888-888-888-000';
    var invalid18='888-888-888-888';
    var invalid19='999-999-999-';
    var invalid20='999-999-999-000';
    var invalid21='999-999-999-999';


    if(tax.match(validTaxPattern))
    {
        if (tax.match(invalid1)||tax.match(invalid2)||tax.match(invalid3)||tax.match(invalid4)||tax.match(invalid5)||tax.match(invalid6)||
            tax.match(invalid7)||tax.match(invalid8)||tax.match(invalid9)||tax.match(invalid10)||tax.match(invalid11)||tax.match(invalid12)||
            tax.match(invalid13)||tax.match(invalid14)||tax.match(invalid15)||tax.match(invalid16)||tax.match(invalid17)||tax.match(invalid18)||
            tax.match(invalid19)||tax.match(invalid20)||tax.match(invalid21))
        {
            triggerAlertMessage("Invalid Tax Account Number");
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