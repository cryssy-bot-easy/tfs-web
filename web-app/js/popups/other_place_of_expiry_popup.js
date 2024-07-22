/*
 * Created by: Rafael Ski Poblete 
 * Date : 08/13/18
 * Description : Handles Other Place of Expiry popup behaviour.
 * */
function onOtherPlaceOfExpiryPopupSaveClick() {
    var otherPlaceOfExpiry = $("#otherPlaceOfExpiryComment").val().toUpperCase();
    if($("#otherPlaceOfExpiryTo").length > 0) {
        $("#otherPlaceOfExpiryTo").val(otherPlaceOfExpiry);
    } else if($("#otherPlaceOfExpiryTextArea").length > 0) {
        $("#otherPlaceOfExpiryTextArea").val(otherPlaceOfExpiry);
    } else {
        $("#otherPlaceOfExpiry").val(otherPlaceOfExpiry);
    }
    disablePopup("otherPlaceOfExpiry_popup", "otherPlaceOfExpiry_bg");
}

$(function (){
    var popup_otherPlaceOfExpiry_div = $('#otherPlaceOfExpiry_popup').attr("id");
    var popup_otherPlaceOfExpiry_bg = $('#otherPlaceOfExpiry_bg').attr("id");

    $('#popup_btn_otherPlaceOfExpiry').click(function (){
        $("#otherPlaceOfExpiryComment").val(($("#otherPlaceOfExpiryTo").length > 0 ) ? $("#otherPlaceOfExpiryTo").val() : ($("#otherPlaceOfExpiryTextArea").length > 0) ? $("#otherPlaceOfExpiryTextArea").val() : ($("#otherPlaceOfExpiry").length > 0 ) ? $("#otherPlaceOfExpiry").val() : ($("#otherPlaceOfExpiryMt").length > 0 ) ? $("#otherPlaceOfExpiryMt").val() : '');
        centerPopup(popup_otherPlaceOfExpiry_div, popup_otherPlaceOfExpiry_bg);
        loadPopup(popup_otherPlaceOfExpiry_div, popup_otherPlaceOfExpiry_bg);
        $("#otherPlaceOfExpiryComment").focus();
        $("#otherPlaceOfExpiryComment").limitCharAndLines(25, 1);
    });
    
    $('.otherPlaceOfExpiry_close').click(function (){
        $("#otherPlaceOfExpiryComment").val("");
        disablePopup(popup_otherPlaceOfExpiry_div, popup_otherPlaceOfExpiry_bg);
    });
    $("#otherPlaceOfExpiryPopupSave").click(onOtherPlaceOfExpiryPopupSaveClick);
});