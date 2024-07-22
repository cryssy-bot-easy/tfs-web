function onReroutePopupClick(id){
    centerPopup("popup_reroute", "popupBackground_reroute")
    loadPopup("popup_reroute", "popupBackground_reroute")

    $("#routedTo").val(id);
}

function onReroutePopupCloseClick(){
    var popup_div = "popup_reroute"
    var popup_bg = "popupBackground_reroute"

    disablePopup(popup_div, popup_bg)
}


function initReroutePopup(){

//    $('#popup_reroute_title').text("Re-route");
////    $('jqgrid_inline_links_reroute').click(onReroutePopupClick);
////    $('#searchEtsBtn').click(onReroutePopupClick);
//    $("#popupClose_reroute, #cancelRouteEtsBtn").click(onReroutePopupCloseClick);
}

$(initReroutePopup)