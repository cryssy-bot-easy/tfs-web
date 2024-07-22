 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: unacted_utility.js
 */

function onViewClick(id, grid_id) {

    var grid = $("#" + grid_id).jqGrid("getRowData",id);
    var etsUrl = viewEtsUrl;

    etsUrl += '?serviceType='+grid.serviceType;
    etsUrl += '&documentType='+grid.documentType;
    etsUrl += '&documentClass='+grid.documentClass;
    etsUrl += '&documentSubType1='+grid.documentSubType1;
    etsUrl += '&documentSubType2='+grid.documentSubType2;
    etsUrl += '&etsNumber='+grid.etsNumber;

    if ('undefined' != typeof sessionGroup && sessionGroup != 'BRANCH'){
    	etsUrl += "&viewMode=viewMode";    	
    }

    // this is for reversal
    if (grid.serviceType.indexOf("_REVERSAL") != -1) {
        if (sessionGroup == "TSD") {
            etsUrl += "&reversalEtsNumber="+grid.reversalEtsNumber;
        } else {
            etsUrl += "&reversalEtsNumber="+id;
        }
    }

    location.href = etsUrl;
}

function onEtsClick(id, grid_id) {

    var grid = $("#" + grid_id).jqGrid("getRowData",id);
    var etsUrl = viewEtsUrl;

    etsUrl += '?serviceType='+grid.serviceType;
    etsUrl += '&documentType='+grid.documentType;
    etsUrl += '&documentClass='+grid.documentClass;
    etsUrl += '&documentSubType1='+grid.documentSubType1;
    etsUrl += '&documentSubType2='+grid.documentSubType2;
    etsUrl += '&etsNumber='+grid.etsNumber;

    location.href = etsUrl;
}


function onDataEntryClick(id, grid_id) {

	
    var grid = $("#" + grid_id).jqGrid("getRowData",id);


    var dataEntryUrl = viewDataEntryUrl;
    
    dataEntryUrl += '?serviceType='+grid.serviceType;
    dataEntryUrl += '&documentType='+grid.documentType;
    dataEntryUrl += '&documentClass='+grid.documentClass;
    dataEntryUrl += '&documentSubType1='+grid.documentSubType1;
    dataEntryUrl += '&documentSubType2='+grid.documentSubType2;
    dataEntryUrl += '&tradeServiceId='+id;
    dataEntryUrl += "&serviceInstructionId="+grid.etsNumber;
    dataEntryUrl += "&statusInquiry="+grid.status;
    if ('undefined' != typeof acc_userRole && acc_userRole == 'TSDO'){
    	dataEntryUrl += "&hasRoute=true";
    	if(grid.documentClass in {AR:1, AP:1}){
    		dataEntryUrl += '&viewMode=viewMode';
    	}
    }
    
    
 // this is for reversal
    if (grid.serviceType.indexOf("_REVERSAL") != -1) {
        if (sessionGroup == "TSD") {
        	dataEntryUrl += "&reversalEtsNumber="+grid.reversalEtsNumber;
        } else {
        	dataEntryUrl += "&reversalEtsNumber="+id;
        }
    }
    location.href = dataEntryUrl;
}



function onDataEntrycdtClick(id, grid_id,sType) {


	
	
    var grid = $("#" + grid_id).jqGrid("getRowData",id);

    var dataEntryUrl = viewDataEntryUrl;
	
    dataEntryUrl += '?serviceType='+sType;
    dataEntryUrl += '&documentType='+grid.documentType;
    dataEntryUrl += '&documentClass='+"CDT";
    dataEntryUrl += '&documentSubType1='+grid.documentSubType1;
    dataEntryUrl += '&documentSubType2='+grid.documentSubType2;
    dataEntryUrl += '&tradeServiceId='+id;
    dataEntryUrl += "&serviceInstructionId="+grid.etsNumber;
    dataEntryUrl += "&statusInquiry="+grid.status;
    if ('undefined' != typeof acc_userRole && acc_userRole == 'TSDO'){
    	dataEntryUrl += "&hasRoute=true";
    	if(grid.documentClass in {AR:1, AP:1}){
    		dataEntryUrl += '&viewMode=viewMode';
    	}
    }
    
    
 // this is for reversal
    if (grid.serviceType.indexOf("_REVERSAL") != -1) {
        if (sessionGroup == "TSD") {
        	dataEntryUrl += "&reversalEtsNumber="+grid.reversalEtsNumber;
        } else {
        	dataEntryUrl += "&reversalEtsNumber="+id;
        }
    }
    location.href = dataEntryUrl;
}


function onViewChargesClick(id, grid_id) {
    var grid = $("#" + grid_id).jqGrid("getRowData",id);
    var paymentProcessingUrl = viewChargesUrl;

    paymentProcessingUrl += '?serviceType='+grid.serviceType;
    paymentProcessingUrl += '&documentType='+grid.documentType;
    paymentProcessingUrl += '&documentClass='+grid.documentClass;
    paymentProcessingUrl += '&documentSubType1='+grid.documentSubType1;
    paymentProcessingUrl += '&documentSubType2='+grid.documentSubType2;
    paymentProcessingUrl += '&tradeServiceId='+id;
    paymentProcessingUrl += "&serviceInstructionId="+grid.etsNumber;
    
    //check if user is in view mode. acc_userRole in _accordion_url.gsp
    if('undefined' !== typeof acc_userRole && acc_userRole.indexOf("TSD") != -1 && "TSDM" != acc_userRole){
    	paymentProcessingUrl += '&viewMode=viewMode';
    }
    location.href = paymentProcessingUrl;
}