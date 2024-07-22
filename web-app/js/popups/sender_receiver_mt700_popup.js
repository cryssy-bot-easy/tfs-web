/*
 * Modified by : Rafael Ski Poblete
 * Date : 7/26/18
 * Description : Changed sender to receiver limitCharAndLines. Added 'Z' as parameter.
 * */
function onSenderToReceiverInformationPopupSaveClick() {
    var senderToReceiverInformation = $("#senderToReceiverInformationComment").val().toUpperCase();
    
    if($("#senderToReceiverInformationTo").length > 0) {
        $("#senderToReceiverInformationTo").val(senderToReceiverInformation);
    } else if($("#senderToReceiverInformationTextArea").length > 0) {
        $("#senderToReceiverInformationTextArea").val(senderToReceiverInformation);
    } else if($("#senderToReceiverInformationMt").length > 0){
        $("#senderToReceiverInformationMt").val(senderToReceiverInformation);
    } else if($("#senderToReceiverInformationMt202").length > 0){
        $("#senderToReceiverInformationMt202").val(senderToReceiverInformation);
    } else {
        $("#senderToReceiverInformation").val(senderToReceiverInformation);
    }
    disablePopup("sender_receiver_popup", "sender_receiver_bg");
}

$(function (){
    var popup_sender_receiver_div = $('#sender_receiver_popup').attr("id");
    var popup_sender_receiver_bg = $('#sender_receiver_bg').attr("id");

    $('#sender_info').click(function (){
        $("#senderToReceiverInformationComment").val(($("#senderToReceiverInformationTo").length > 0 ) ? $("#senderToReceiverInformationTo").val() : ($("#senderToReceiverInformationTextArea").length > 0) ? $("#senderToReceiverInformationTextArea").val() : ($("#senderToReceiverInformation").length > 0 ) ? $("#senderToReceiverInformation").val() : ($("#senderToReceiverInformationMt").length > 0 ) ? $("#senderToReceiverInformationMt").val() : '');
        //centering with css
        centerPopup(popup_sender_receiver_div, popup_sender_receiver_bg);
        //load popup
        loadPopup(popup_sender_receiver_div, popup_sender_receiver_bg);
        $("#senderToReceiverInformationComment").focus();
        $("#senderToReceiverInformationComment").limitCharAndLines(35,6,'Z');
    });
    
    $('.sender_receiver_close').click(function (){
        $("#senderToReceiverInformationComment").val("");
        disablePopup(popup_sender_receiver_div, popup_sender_receiver_bg);
    });
    
    //on click of ellipsis
    $("#new_sender_info").click(function(){
        $("#senderToReceiverInformationComment").val(($("#senderToReceiverInformationTo").length > 0 ) ? $("#senderToReceiverInformationTo").val() : ($("#senderToReceiverInformationTextArea").length > 0) ? $("#senderToReceiverInformationTextArea").val() : ($("#senderToReceiverInformation").length > 0 ) ? $("#senderToReceiverInformation").val() : ($("#senderToReceiverInformationMt").length > 0 ) ? $("#senderToReceiverInformationMt").val() : '');
        var senderToReceiverCode = $('#newSenderToReceiver option:selected').text();
        senderToReceiverCode = senderToReceiverCode.toUpperCase();
        senderToReceiverCode = "/" + senderToReceiverCode + "/";
        var senderToReceiverTextArea = $('textarea#senderToReceiverInformation').val();
        if( senderToReceiverTextArea != ""){
            var senderToReceiverTextAreaSub = senderToReceiverTextArea.substring(0,10);
            senderToReceiverTextAreaSub = senderToReceiverTextAreaSub.toUpperCase();
        } else {
            if( !senderToReceiverCode.startsWith("/SELECT") ){
                $("#senderToReceiverInformationComment").val(senderToReceiverCode); 
                $("#senderToReceiverInformationComment").limitCharAndLines(33,6,'Z');
            } else {
                $("#senderToReceiverInformationComment").val(senderToReceiverTextArea); 
                $("#senderToReceiverInformationComment").limitCharAndLines(35,6,'Z');
            }
        }
        centerPopup(popup_sender_receiver_div, popup_sender_receiver_bg);
        loadPopup(popup_sender_receiver_div, popup_sender_receiver_bg);
        $("#senderToReceiverInformationComment").focus();
    });
    //on change of sender to receiver code
    $("#newSenderToReceiver").change(function(){
        var senderToReceiverCode = $('#newSenderToReceiver option:selected').text();
        var senderToReceiverTextArea = $('textarea#senderToReceiverInformation').val();
        if( senderToReceiverTextArea != "" ){
            var div = $("#popup_senderToReceiver_confirmation"); //change
            var bg = $("#confirmation_background_tab");
            mCenterPopup(div, bg);
            mLoadPopup(div, bg);
            if( $("#btnSenderToReceiverYes").val() != undefined ){
                $("#btnSenderToReceiverYes").click(function(){
                    $('textarea#senderToReceiverInformation').val("");
                    mDisablePopup(div, bg);
                });
            } 
            if( $("#btnSenderToReceiverNo").val() != undefined ){
                $("#btnSenderToReceiverNo").click(function(){
                    if( senderToReceiverTextArea != "" ){
                        var senderToReceiverSplit = senderToReceiverTextArea.split('/');
                        $("#newSenderToReceiver").val(senderToReceiverSplit[1]);
                        mDisablePopup(div, bg);
                    }
                });
            } 
        }
    });
    
    function checkCode(senderToReceiverCode){
        var limitTo;
        if( !senderToReceiverCode.startsWith("SELECT") ){
            limitTo = $("#senderToReceiverInformationComment").limitCharAndLines(33,6,'Z');
        } else {
            limitTo = $("#senderToReceiverInformationComment").limitCharAndLines(35,6,'Z');
        }
        return limitTo;
    }
    
    var senderToReceiverCode = $('#newSenderToReceiver option:selected').text();
    switch(documentClass){
    
    case "BC":
        checkCode(senderToReceiverCode);
    break;
    
    case "BP":
        checkCode(senderToReceiverCode);
    break;
    
    case "EXPORT_ADVISING":
        if( documentSubType1 != "SECOND_ADVISING"){
            checkCode(senderToReceiverCode);
        } else {
            $("#senderToReceiverInformationComment").limitCharAndLines(35,6,'Z');
        }
    break;
    
    default:
            $("#senderToReceiverInformationComment").limitCharAndLines(35,6,'Z');
    break;
    }   
    $("#senderToReceiverInformationPopupSave").click(onSenderToReceiverInformationPopupSaveClick);
});