// init function
function initializeNegoEnoughTabUtility() {

    var dType = $('#documentType').val();
    var dSubType1 = $('#documentSubType1').val();
    var dSubType2 = $('#documentSubType2').val();
    var sType = $('#serviceType').val();
    var dClass = $('#documentClass').val();

    if(dType.toUpperCase() == 'DOMESTIC' && dSubType1.toUpperCase() == "CASH" && dSubType2.toUpperCase() == "SIGHT" && dClass.toUpperCase() == "LC" && sType.toUpperCase()=="NEGOTIATION"){

        if($("#btnPrepare").val==null && $("#btnPrepare").val==null ){
            alert('ANGOL');
            $("#btnPrepare").removeAttr("disabled");
        }



    }
}


$(initializeNegoEnoughTabUtility);