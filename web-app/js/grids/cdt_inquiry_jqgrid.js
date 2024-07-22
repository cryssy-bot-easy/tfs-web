
function setUpCdtInquiryGrid(){
	/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: cdt_inquiry_jqgrid.js
	 *
	 */


	var cdt_inquiry_grid_url =searchCdtPaymentUrl;
	
	setupJqGridWidthPagerHidden('grid_list_cdt_inquiry', {width: 780, height: 325, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['cdtPaymentReference', 'CDT Payment Reference',130, 'left'],
			 ['ieirdNo', 'IED/IEIRD No.',120, 'left'],
			 ['aabRefNo', 'AAB Ref No.', 120, 'left'],
			 ['importerName', 'Importer\'s Name',150,'left'],
			 ['cdtAmount', 'CDT Amount',100, 'right'],
			 ['requestType', 'Request Type'],
			 ['status', 'Status', 80, 'center'],
             ['receivedDate', 'Received Date', 80, 'center'],
             ['paidDate', 'Paid Date', 80, 'center'],
             ['refundDate', 'Refunded Date', 80, 'center'],
			 ['action', 'Action', 50, 'center'],
			 ['refund', 'Refund', 60, 'center']],'grid_pager_cdt_inquiry', cdt_inquiry_grid_url);

	
}

function onViewPayment(){
	var url = "";

	url = payDutiesAndTaxesUrl;
	url += '?serviceType='+"Customs Duties and Taxes";
	url += '&documentType='+"Collection";
	url += '&referenceType='+"Pay Duties and Taxes";
	url += '&documentClass='+"";
//	url += '&username='+$("#username").val();
	location.href = url;
}

function onViewRefund(){
	var url = "";
	
	url = collectionRefundUrl;
	url += '?serviceType='+"Customs Duties and Taxes";
	url += '&documentType='+"Collection";
	url += '&referenceType='+"Refund";
	location.href = url;
}


function initCdtInquiryGrid(){
	setUpCdtInquiryGrid();
}



$(initCdtInquiryGrid);