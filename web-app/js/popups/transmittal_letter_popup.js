/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 11/7/12
 * Time: 10:59 AM
 * To change this template use File | Settings | File Templates.
 */

function openAddTransmittalLetter() {
    transLetterType = "add";

    $("#transmittalLetterId").val("");
    $("#transmittalLettter").val("");

    loadPopup("popup_transmittalLettter", "add_transmittalLettter_bg");
    centerPopup("popup_transmittalLettter", "add_transmittalLettter_bg");
}

function closeAddTransmittalLetter() {
    disablePopup("popup_transmittalLettter", "add_transmittalLettter_bg");
}

function editAddedTransmittalLetter(id) {
    transLetterType = "addedit";

    var letterDescription = $("#grid_list_transmittal_letter").jqGrid("getRowData", id).descriptionTransmittal;

    $("#transmittalLetterId").val(id);
    $("#transmittalLettter").val(letterDescription);

    loadPopup("popup_transmittalLettter", "add_transmittalLettter_bg");
    centerPopup("popup_transmittalLettter", "add_transmittalLettter_bg");
}

function deleteAddedTransmittalLetter(id) {
    transLetterType = "adddelete";

    $("#transmittalLetterId").val(id);
    onSaveClick();
}

function wireAddTransmittalLetter() {
    $("#addTransmittalLetter").click(openAddTransmittalLetter);
    $("#close_transmittalLettter, #close_transmittalLettter_close").click(closeAddTransmittalLetter);
}

$(wireAddTransmittalLetter);
