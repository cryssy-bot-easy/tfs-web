/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/7/12
 * Time: 3:25 AM
 * To change this template use File | Settings | File Templates.
 */

/**
     (revision)
    [Revised by:] Cedrick C. Nungay
    [Date revised:] October 10, 2018
    [Date deployed:]
    Program [Revision] Details: Modified period for presentation for MT707.
    Member Type: JavaScript file (JS)
    Project: WEB
    Project Name: amendment_dataentry_additional_conditions2_utility.js
 */
function disableAdditionalConditions2Fields() {
    $("form#additionalCondition2TabForm :input").each(function(){
        var input = $(this); // This is the jquery object of the input, do what you will

        if(input.attr("name") != undefined) {
            var name = input.attr("name");

            if(name.substring(name.length -2, name.length) == "To") {
                if(input.attr("type") == "text" || input.attr("type") == "textarea") {
                    input.attr("readonly", "readonly");
                }else {
                    input.attr("disabled", "disabled");
                }
            }
        }
    });
}

function setPeriodForPresentation1() {
    var periodForPresentation1 = $("#periodForPresentation1Switch").val();

    if(periodForPresentation1) {
        if(periodForPresentation1.toLowerCase() == "on") {
            $("#periodForPresentation1SwitchDisplay").attr("checked", "checked");
        } else {
            $("#periodForPresentation1SwitchDisplay").attr("checked", false);
        }
    }else {
        $("#periodForPresentation1SwitchDisplay").attr("checked", false);
    }
}

function onCheckPeriodForPresentation1() {
    if($("#periodForPresentation1SwitchDisplay").attr("checked") == "checked") {
    	//alert(1);
        $("#periodForPresentation1Switch").val("on");
        $("#periodForPresentation1To").removeAttr("readonly");  
        $("#periodForPresentation1To").removeAttr("disabled");  
        $("#periodForPresentation1NumberTo").removeAttr("readonly");
        $("#periodForPresentation1NumberTo").removeAttr("disabled");    
    } else {
    	//alert(2);
        $("#periodForPresentation1Switch").val("off");
        $("#periodForPresentation1To").attr("readonly", "readonly");
        $("#periodForPresentation1To").val("");
        $("#periodForPresentation1NumberTo").attr("readonly", "readonly");
        $("#periodForPresentation1NumberTo").val("");
    }
}

function setReimbursingBank() {
    var reimbursingBank = $("#reimbursingBankSwitch").val();

    if(reimbursingBank) {
        if(reimbursingBank.toLowerCase() == "on") {
            $("#reimbursingBankSwitchDisplay").attr("checked", "checked");
        } else {
            $("#reimbursingBankSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#reimbursingBankSwitchDisplay").attr("checked", false);
    }
}

function onCheckReimbursingBank() {
    if($("#reimbursingBankSwitchDisplay").attr("checked") == "checked") {
        $("#reimbursingBankSwitch").val("on");
        $("input[type=radio][name=reimbursingBankFlagTo]").removeAttr("disabled");

        $("#reimbursingAccountTypeTo").removeAttr("readonly");
//        $("#reimbursingCurrencyTo").removeAttr("disabled");
        $("#reimbursingCurrencyTo").select2("enable");
        $("#reimbursingBankAccountNumberTo").removeAttr("readonly");
        $("#reimbursingBankAccountNumberTo").removeAttr("disabled");  
    } else {
        $("#reimbursingBankSwitch").val("off");
        $("input[type=radio][name=reimbursingBankFlagTo]").attr("disabled", "disabled");
        $("input[type=radio][name=reimbursingBankFlagTo]").attr("checked", false);

        $("#reimbursingAccountTypeTo").val("");
        $("#reimbursingAccountTypeTo").attr("readonly", "readonly");

//        $("#reimbursingCurrencyTo").val("");
//        $("#reimbursingCurrencyTo").attr("disabled", "disabled");
        $("#reimbursingCurrencyTo").select2("disable");
        $("#reimbursingCurrencyTo").select2("data",null);

        $("#reimbursingBankAccountNumberTo").val("");
        $("#reimbursingBankAccountNumberTo").attr("readonly", "readonly");
        onClickReimbursingBankFlagTo();
    }
}

function onClickReimbursingBankFlagTo() {
    var reimbursingBankFlag = $("input[type=radio][name=reimbursingBankFlagTo]:checked").val();

    if(reimbursingBankFlag == "A") {
        $("#reimbursingBankIdentifierCodeTo").select2("enable");        
        $("#reimbursingBankNameAndAddressTo").attr("readonly", "readonly");
        $("#reimbursingBankNameAndAddressTo").val("");
//    } else if(reimbursingBankFlag == "D") {
    } else if(reimbursingBankFlag == "D") {
        $("#reimbursingBankNameAndAddressTo").removeAttr("readonly");
        $("#reimbursingBankNameAndAddressTo").removeAttr("disabled");  
        $("#reimbursingBankIdentifierCodeTo").select2("data",null);
        $("#reimbursingBankIdentifierCodeTo").select2("disable");
    } else {
        $("#reimbursingBankNameAndAddressTo").attr("readonly", "readonly");
        $("#reimbursingBankNameAndAddressTo").val("");
        $("#reimbursingBankIdentifierCodeTo").select2("data",null);
        $("#reimbursingBankIdentifierCodeTo").select2("disable");
    }
}

function setPeriodForPresentation() {
    var periodForPresentation = $("#periodForPresentationSwitch").val();

    if(periodForPresentation) {
        if(periodForPresentation.toLowerCase() == "on") {
            $("#periodForPresentationSwitchDisplay").attr("checked", "checked");
        } else {
            $("#periodForPresentationSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#periodForPresentationSwitchDisplay").attr("checked", false);
    }
}

function onCheckPeriodForPresentation() {
    if($("#periodForPresentationSwitchDisplay").attr("checked") == "checked") {
        $("#periodForPresentationSwitch").val("on");
        $("#btn_period_of_presention2").show();
    } else {
        $("#periodForPresentationSwitch").val("off");
        $("#btn_period_of_presention2").hide();
        $("#periodForPresentationTo").val("");
    }
}

function setAdviseThroughBank() {
    var adviseThroughBank = $("#adviseThroughBankSwitch").val();

    if(adviseThroughBank) {
        if(adviseThroughBank.toLowerCase() == "on") {
            $("#adviseThroughBankSwitchDisplay").attr("checked", "checked");
        } else {
            $("#adviseThroughBankSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#adviseThroughBankSwitchDisplay").attr("checked", false);
    }
}

function onCheckAdviseThroughBank() {
    if($("#adviseThroughBankSwitchDisplay").attr("checked") == "checked") {
        $("#adviseThroughBankSwitch").val("on");
        $("input[type=radio][name=adviseThroughBankFlagTo]").removeAttr("disabled");
    } else {
        $("#adviseThroughBankSwitch").val("off");
        $("input[type=radio][name=adviseThroughBankFlagTo]").attr("disabled", "disabled");
        $("input[type=radio][name=adviseThroughBankFlagTo]").attr("checked", false);
        onClickAdviseThroughBankTo();
    }
}

function onClickAdviseThroughBankTo() {
    var adviseThroughBankFlag = $("input[type=radio][name=adviseThroughBankFlagTo]:checked").val();

    if(adviseThroughBankFlag == "A") {
        $("#adviseThroughBankIdentifierCodeTo").select2("enable");

        $("#adviseThroughBankLocationTo").attr("readonly", "readonly");
        $("#adviseThroughBankLocationTo").val("");

        $("#adviseThroughBankNameAndAddressTo").attr("readonly", "readonly");
        $("#adviseThroughBankNameAndAddressTo").val("");
    } else if(adviseThroughBankFlag == "B") {
        $("#adviseThroughBankLocationTo").removeAttr("readonly");

        $("#adviseThroughBankIdentifierCodeTo").select2("data",null);
        $("#adviseThroughBankIdentifierCodeTo").select2("disable");

        $("#adviseThroughBankNameAndAddressTo").attr("readonly", "readonly");
        $("#adviseThroughBankNameAndAddressTo").val("");
    } else if(adviseThroughBankFlag == "D") {
        $("#adviseThroughBankNameAndAddressTo").removeAttr("readonly");
        $("#adviseThroughBankNameAndAddressTo").removeAttr("disabled");  
        $("#adviseThroughBankIdentifierCodeTo").select2("data",null);
        $("#adviseThroughBankIdentifierCodeTo").select2("disable");

        $("#adviseThroughBankLocationTo").attr("readonly", "readonly");
        $("#adviseThroughBankLocationTo").val("");
    } else {
        $("#adviseThroughBankIdentifierCodeTo").select2("data",null);
        $("#adviseThroughBankIdentifierCodeTo").select2("disable");

        $("#adviseThroughBankLocationTo").attr("readonly", "readonly");
        $("#adviseThroughBankLocationTo").val("");

        $("#adviseThroughBankNameAndAddressTo").attr("readonly", "readonly");
        $("#adviseThroughBankNameAndAddressTo").val("");
    }
}

function setSenderToReceiver() {
    var senderToReceiver = $("#senderToReceiverSwitch").val();

    if(senderToReceiver) {
        if(senderToReceiver.toLowerCase() == "on") {
            $("#senderToReceiverSwitchDisplay").attr("checked", "checked");
        } else {
            $("#senderToReceiverSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#senderToReceiverSwitchDisplay").attr("checked", false);
    }
}

function onCheckSenderToReceiver() {
    if($("#senderToReceiverSwitchDisplay").attr("checked") == "checked") {
        $("#senderToReceiverSwitch").val("on");
        $("#senderToReceiverTo").removeAttr("disabled");
        $("#senderToReceiverInformationTo").removeAttr("disabled");
        
        $("#sender_info").show();
    } else {
        $("#senderToReceiverSwitch").val("off");
        $("#senderToReceiverTo").attr("disabled", "disabled");
        
        $("#sender_info").hide();
        $("#senderToReceiverInformationTo").val("");
    }
}

function initializeDataEntryAdditionalConditions2() {
    disableAdditionalConditions2Fields();

    setPeriodForPresentation1();
    $("#periodForPresentation1SwitchDisplay").click(onCheckPeriodForPresentation1);
    onCheckPeriodForPresentation1();

    setReimbursingBank();
    $("#reimbursingBankSwitchDisplay").click(onCheckReimbursingBank);
    onCheckReimbursingBank();
    $("input[type=radio][name=reimbursingBankFlagTo]").click(onClickReimbursingBankFlagTo);
    onClickReimbursingBankFlagTo();

    setPeriodForPresentation();
    $("#periodForPresentationSwitchDisplay").click(onCheckPeriodForPresentation);
    onCheckPeriodForPresentation();

    setAdviseThroughBank();
    $("#adviseThroughBankSwitchDisplay").click(onCheckAdviseThroughBank);
    onCheckAdviseThroughBank();
    $("input[type=radio][name=adviseThroughBankFlagTo]").click(onClickAdviseThroughBankTo);
    onClickAdviseThroughBankTo();

    setSenderToReceiver();
    $("#senderToReceiverSwitchDisplay").click(onCheckSenderToReceiver);
    onCheckSenderToReceiver();  
    
    $("#periodForPresentation1NumberTo").keyup(function (event) {
        if (!/^[1-9]\d*$/.test(this.value)) {
            this.value = this.value.substr(0, this.value.length - 1);
        }
        disableNarrative();
    });
    $("#periodForPresentation1NumberTo").keydown(function (event) {
        if (!/^[1-9]\d*$/.test(this.value)) {
            this.value = this.value.substr(0, this.value.length - 1);
        }
    });
    
    $("#periodForPresentation1NumberTo").blur(function (event) {
        if (!/^[1-9]\d*$/.test(this.value)) {
            this.value = this.value.substr(0, this.value.length - 1);
        }
        disableNarrative();
    });
}

$(initializeDataEntryAdditionalConditions2);
