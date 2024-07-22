/*
 * Created by: Cedrick C. Nungay
 * Date : 01/11/19
 * */
function onOtherPlaceOfExpiryPopupSaveClick() {
    var otherPlaceOfExpiry = $("#otherPlaceOfExpiryComment").val().toUpperCase();
    if($("#otherPlaceOfExpiry").length > 0) {
        $("#otherPlaceOfExpiry").val(otherPlaceOfExpiry);
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

    $('#popup_btn_other_place_of_expiry').click(function (){
        $("#otherPlaceOfExpiryComment").val(($("#otherPlaceOfExpiry").length > 0 ) ? $("#otherPlaceOfExpiry").val() : ($("#otherPlaceOfExpiryTextArea").length > 0) ? $("#otherPlaceOfExpiryTextArea").val() : ($("#otherPlaceOfExpiry").length > 0 ) ? $("#otherPlaceOfExpiry").val() : ($("#otherPlaceOfExpiryMt").length > 0 ) ? $("#otherPlaceOfExpiryMt").val() : '');
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
