var destinationUrl = "";

function openConfirmPopup(gotoUrl){
    var mSave_div = $("#popup_save_confirmation");
    var mBg = $("#confirmation_background");

    destinationUrl = gotoUrl;

    var returnUrl;
    switch($("#subtitle").text().trim()){
    	case "Main Unacted MTs":
    		returnUrl = "&returnUrl=viewUnactedMt"; 
    		break;
    	case "Transmitted MTs":
    		returnUrl = "&returnUrl=viewTransmittedMt";
    		break;
    	case "Discarded MTs":
    		returnUrl = "&returnUrl=viewDiscardedMt";
    		break;
    	default:
    		returnUrl = "&returnUrl=viewUnactedMt";
			break;
    }
    
    destinationUrl += returnUrl;
    
    mLoadPopup(mSave_div, mBg);
    mCenterPopup(mSave_div, mBg);
}

function disableConfirmPopup(){
	mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
}

function setUpMtMonitoring(){
	var mtMonitoringUrl=unactedOutgoingMtUrl;
	

	setupJqGridWidthPagerHidden('grid_list_mt_monitoring_inquiry', {width: 780, height: 565, loadui: "disable", scrollOffset:0, rowNum: 30, shrinkToFit: false},
			[['refNumber', 'Reference Number', 150],
			['mtType','MT Type', 85, 'center'],
			['dateTsdApproval','Date / Time', 200, 'center'],
			['status','Status', 100, 'center'],
			['action', 'Action', 220, 'center'],
			['referenceType', 'Import Type',30, 'left', 'hidden'],
			['documentType','Document Type', 30,'left', 'hidden'],
			['serviceType','Service Type',30, 'left', 'hidden']], 'grid_pager_mt_monitoring_inquiry', mtMonitoringUrl);
}

function onViewOutgoingMt(id) {
    var gotoUrl = viewMtUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"OUTGOING";

    location.href = gotoUrl;
}

function onTransmitMt(id) {
    var gotoUrl = transmitUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"OUTGOING";

    //location.href = gotoUrl;
    openConfirmPopup(gotoUrl);
}

function onDiscardMt(id) {
    var gotoUrl = discardUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"OUTGOING";

    //location.href = gotoUrl;
    openConfirmPopup(gotoUrl);
}

function onReverseMt(id) {
    var gotoUrl = reverseUrl;

    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"OUTGOING";

    //location.href = gotoUrl;
    openConfirmPopup(gotoUrl);
}

function onConfirmClick(){
	location.href=destinationUrl;
}

function closeOnlineReportsPopUp() {
	mDisablePopup($("#telecomReportsPopup"), $("#popupBackground_telecom_reports"));
}

function transmitAllMt(){
	location.href = transmitAllMtsUrl;
}

function initMtMonitoring(){
	setUpMtMonitoring();
	$("#btnAlertConfirm").click(onConfirmClick);
	$("#btnAlertNo").click(disableConfirmPopup);
	$("#transmitAll").click(transmitAllMt);
}

$(initMtMonitoring);