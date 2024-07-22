/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 7/16/13
 * Time: 4:09 PM
 * To change this template use File | Settings | File Templates.
 */
function onOrderingBankChange() {
    var orderingBank = $("input[name=orderingBankFlagMt202]:checked").val();

    $(".orderingBankMt202OptionLetter").text(orderingBank);

    if (orderingBank == "A") {
        $("#bankIdentifierCodeMt").select2("enable");

        $("#bankNameAndAddressMt").val("");
        $("#orderingBankNameAndAddressPopup").hide();
    } else if (orderingBank == "D") {
        $("#orderingBankNameAndAddressPopup").show();

        $("#bankIdentifierCodeMt").select2("data", null);
        $("#bankIdentifierCodeMt").select2("disable");
    } else {
        $("#bankNameAndAddressMt").val("");
        $("#orderingBankNameAndAddressPopup").hide();

        $("#bankIdentifierCodeMt").select2("data", null);
        $("#bankIdentifierCodeMt").select2("disable");
    }
}

function onSendersCorrespondentChange() {
    var sendersCorrespondent = $("input[name=sendersCorrespondentFlagMt202]:checked").val();

    $(".sendersCorrespondentMt202OptionLetter").text(sendersCorrespondent);

    if (sendersCorrespondent == "A") {
        $("#senderIdentifierCodeMt").select2("enable");

        $("#senderPartyIdentifierMt").val("");
        $("#senderPartyIdentifierMt").attr("readonly", "readonly");

        $("#senderNameAndAddressMt").val("");
        $("#sendersCorrespondentNameAndAddressPopup").hide();
    } else if (sendersCorrespondent == "B") {
        $("#senderPartyIdentifierMt").val(sendersCorrespondentPartyIdentifier);

        if (sendersCorrespondentPartyIdentifier != "") {
            $("#sendersCorrespondentComplete").val("true");
        } else {
            $("#sendersCorrespondentComplete").val("");
        }

        $("#senderIdentifierCodeMt").select2("data", null);
        $("#senderIdentifierCodeMt").select2("disable");

        $("#senderNameAndAddressMt").val("");
        $("#sendersCorrespondentNameAndAddressPopup").hide();
    } else if (sendersCorrespondent == "D") {
        $("#sendersCorrespondentNameAndAddressPopup").show();

        $("#senderPartyIdentifierMt").val("");
        $("#senderPartyIdentifierMt").attr("readonly", "readonly");

        $("#senderIdentifierCodeMt").select2("data", null);
        $("#senderIdentifierCodeMt").select2("disable");
    } else {
        $("#senderPartyIdentifierMt").val("");
        $("#senderPartyIdentifierMt").attr("readonly", "readonly");

        $("#senderIdentifierCodeMt").select2("data", null);
        $("#senderIdentifierCodeMt").select2("disable");

        $("#senderNameAndAddressMt").val("");
        $("#sendersCorrespondentNameAndAddressPopup").hide();
    }
}

function onSendersCorrespondentIdentifierCodeChange() {
    if ($("input[orderingBankFlagMt202]:checked").val() == "A") {
        alert(2)
        if ($("#senderIdentifierCodeMt").val() != "" && $("#senderIdentifierCodeMt").val() != null) {
            $("#sendersCorrespondentComplete").val("true");
        } else {
            $("#sendersCorrespondentComplete").val("");
        }
    }
}

function onReceiversCorrespondentChange() {
    var receiversCorrespondent = $("input[name=receiversCorrespondentFlagMt202]:checked").val();

    $(".receiversCorrespondentMt202OptionLetter").text(receiversCorrespondent);

    if (receiversCorrespondent == "A") {
        $("#receiverIdentifierCodeMt").select2("enable");

        $("#receiverPartyIdentifierMt").attr("readonly", "readonly");
        $("#receiverLocationMt").attr("readonly", "readonly");

        $("#receiverNameAndAddressMt").val("");
        $("#receiversCorrespondentNameAndAddressPopup").hide();
    } else if (receiversCorrespondent == "B") {
        $("#receiverPartyIdentifierMt").removeAttr("readonly");
        $("#receiverLocationMt").removeAttr("readonly");

        $("#receiverIdentifierCodeMt").select2("disable");
        $("#receiverIdentifierCodeMt").select2("data", null);

        $("#receiverNameAndAddressMt").val("");
        $("#receiversCorrespondentNameAndAddressPopup").hide();
    } else if (receiversCorrespondent == "D") {
        $("#receiversCorrespondentNameAndAddressPopup").show();

        $("#receiverIdentifierCodeMt").select2("disable");
        $("#receiverIdentifierCodeMt").select2("data", null);

        $("#receiverPartyIdentifierMt").attr("readonly", "readonly");
        $("#receiverLocationMt").attr("readonly", "readonly");
    } else {
        $("#receiverIdentifierCodeMt").select2("disable");
        $("#receiverIdentifierCodeMt").select2("data", null);

        $("#receiverPartyIdentifierMt").attr("readonly", "readonly");
        $("#receiverLocationMt").attr("readonly", "readonly");

        $("#receiverNameAndAddressMt").val("");
        $("#receiversCorrespondentNameAndAddressPopup").hide();
    }
}

function onIntermediaryChange() {
    var intermediary = $("input[name=intermediaryFlagMt202]:checked").val();

    $(".intermediaryMt202OptionLetter").text(intermediary);

    if (intermediary == "A") {
        $("#intermediaryIdentifierCodeMt").select2("enable");

        $("#intermediaryNameAndAddressMt").val("");
        $("#intermediaryNameAndAddressPopup").hide();
    } else if (intermediary == "D") {
        $("#intermediaryNameAndAddressPopup").show();

        $("#intermediaryIdentifierCodeMt").select2("enable");
        $("#intermediaryIdentifierCodeMt").select2("data", null);
    } else {
        $("#intermediaryIdentifierCodeMt").select2("enable");
        $("#intermediaryIdentifierCodeMt").select2("data", null);

        $("#intermediaryNameAndAddressMt").val("");
        $("#intermediaryNameAndAddressPopup").hide();
    }
}

function onAccountWithBankChange() {
    var accountWithBank = $("input[name=accountWithBankFlagMt202]:checked").val();

    $(".accountWithBankMt202OptionLetter").text(accountWithBank);

    if (accountWithBank == "A") {
        $("#accountIdentifierCodeMt").select2("enable");

        $("#accountWithBankIdentifierMt").val("");
        $("#accountWithBankLocationMt").val("");
        $("#accountWithBankIdentifierMt").attr("readonly", "readonly");
        $("#accountWithBankLocationMt").attr("readonly", "readonly")

        $("#accountNameAndAddressMt").val("");
        $("#accountWithBankNameAndAddressPopup").hide();
    } else if (accountWithBank == "B") {
        $("#accountWithBankIdentifierMt").removeAttr("readonly");
        $("#accountWithBankLocationMt").removeAttr("readonly");

        $("#accountIdentifierCodeMt").select2("disable");
        $("#accountIdentifierCodeMt").select2("data", null);

        $("#accountNameAndAddressMt").val("");
        $("#accountWithBankNameAndAddressPopup").hide();
    } else if (accountWithBank == "D") {
        $("#accountWithBankNameAndAddressPopup").show();

        $("#accountIdentifierCodeMt").select2("disable");
        $("#accountIdentifierCodeMt").select2("data", null);

        $("#accountWithBankIdentifierMt").val("");
        $("#accountWithBankLocationMt").val("");
        $("#accountWithBankIdentifierMt").attr("readonly", "readonly");
        $("#accountWithBankLocationMt").attr("readonly", "readonly")
    } else {
        $("#accountIdentifierCodeMt").select2("disable");
        $("#accountIdentifierCodeMt").select2("data", null);

        $("#accountWithBankIdentifierMt").val("");
        $("#accountWithBankLocationMt").val("");
        $("#accountWithBankIdentifierMt").attr("readonly", "readonly");
        $("#accountWithBankLocationMt").attr("readonly", "readonly")

        $("#accountNameAndAddressMt").val("");
        $("#accountWithBankNameAndAddressPopup").hide();
    }
}

function onBeneficiaryBankChange() {
    var beneficiaryBank = $("input[name=beneficiaryBankFlagMt202]:checked").val();

    $(".beneficiaryBankMt202OptionLetter").text(beneficiaryBank);

    if (beneficiaryBank == "A") {
        $("#beneficiaryIdentifierCodeMt").select2("enable");

        $("#beneficiaryNameAndAddressMt").val("");
        $("#beneficiaryBankNameAndAddressPopup").hide();
    } else if (beneficiaryBank == "D") {
        $("#beneficiaryBankNameAndAddressPopup").show();

        $("#beneficiaryIdentifierCodeMt").select2("disable");
        $("#beneficiaryIdentifierCodeMt").select2("data", null);
    } else {
        $("#beneficiaryIdentifierCodeMt").select2("disable");
        $("#beneficiaryIdentifierCodeMt").select2("data", null);

        $("#beneficiaryNameAndAddressMt").val("");
        $("#beneficiaryBankNameAndAddressPopup").hide();
    }
}

function onBeneficiaryBankIdentifierCodeChange() {
    if ($("input[name=beneficiaryBankFlagMt202]:checked").val() == "A") {
        if ($("#beneficiaryIdentifierCodeMt").val() != "" && $("#beneficiaryIdentifierCodeMt").val() != null) {
            $("#beneficiaryBankComplete").val("true");
        } else {
            $("#beneficiaryBankComplete").val("");
        }
    }
}