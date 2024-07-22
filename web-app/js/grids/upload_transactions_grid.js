
 /**
	PROLOGUE:
	 * 	(revision)
		SCR/ER Number:
		SCR/ER Description:
		[Revised by:] Cedrick Nungay
		[Date Revised:] 10/23/2017
		Program [Revision] Details: Added toggle on disabling re-send button.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: upload_transactions_grid.js
 */

function setupUploadTransactions(){
	//var uploadTransactionsUrl = '';
	
	setupJqGridWidthPagerHidden('cdt_list_upload_transactions', {width: 780, loadui: "disable", scrollOffset:0, sortable: false},
					[['iedNumber', 'IED/IERD No.'],
					['aabNumber', 'AAB Ref No.'],
					['importerName', 'Importer\'s Name'],
					['tfsCdtAmount', 'TFS CDT Amount', 85, 'right', (title.indexOf("Upload Transactions")!=-1 ? 'hidden' : '')],
					['cdtAmount', 'e2m CDT Amount', 85, 'right', ''],
					['requestType', 'Request Type', 85, 'center'],
					['collectionStatus', 'Status in e2m', 75, 'center', ''],
                    ['receivedDate', 'Received Date', 75, 'center', ''],
					['tfsCollectionStatus', 'Status in TFS', 75, 'center', (title.indexOf("Upload Transactions")!=-1 ? 'hidden' : '')],
					['collectionAction', 'Action']], 'cdt_pager_upload_transactions', searchCdtPaymentUrl + ("?headerTitle=" + title));

    var postUrl = searchCdtPaymentUrl;
    postUrl += ("?headerTitle=" + title)
    // postUrl += "?"+$("#cdtPaymentInquiryForm").serialize();
    

    $("#cdt_list_upload_transactions").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}
function setResendEmailTable(){

	
	var postUrl = searchCdtEmailTableUrl;
    postUrl += ("?headerTitle=" + title);
    
    setupJqGridWidthPagerHidden('setResendEmailList', { width : 780, height: 'auto', rowNum: 'auto', loadonce:true, multiselect: true,
    	loadComplete: function(data) {
    		$("tr.jqgrow > td[aria-describedby='setResendEmailList_emailStatus']", setupJqGridWidthPagerHidden[0]).each(function(index, element) {
    			var current = $(element);
                $(current.parent().children().first().children().first()).prop("disabled", current.html() === "E-mail sent");
                $(current.parent().children().first().children().first()).prop("checked", current.html() !== "E-mail sent");
            });
//    			add onclick toggle on checkbox
    		var checkboxes = $('#setResendEmailList > tbody > tr.jqgrow > td > input[type=checkbox]');
    		var hasEnabledcheckbox = false;
    		checkboxes.each(function() {
    			var checkbox = $(this);
    			
    			
    			$('#cb_setResendEmailList').attr('checked', true);
    			
    			checkbox.click(function() {
    				$('#resendEmail').attr('disabled', true);
    				checkboxes.each(function() {
	    				if ($(this).prop('checked')) {
	    					$('#resendEmail').attr('disabled', false);
	    					return;
	    				}
    				});
    				if (!$(this).prop('checked')) {
    					$('#cb_setResendEmailList').attr('checked', false);
    				}
    			});
    			
    			if (!$(this).prop('disabled')){
    				hasEnabledcheckbox = true;
    			}
            });
    		
    		$('#cb_setResendEmailList').attr('disabled', !hasEnabledcheckbox);
    		$('#cb_setResendEmailList').attr('checked', hasEnabledcheckbox);
    		$('#resendEmail').attr('disabled', !hasEnabledcheckbox);
    	},
    	beforeSelectRow: function(rowid, e) {
            var cbsdis = $("tr#"+rowid+".jqgrow > td > input.cbox:disabled", setupJqGridWidthPagerHidden[0]);
            if (cbsdis.length === 0) {
                return true;
            } else {
                return false;
            }
        },

    	onSelectAll: function(aRowids,status,rowid, e) {
    	    if (status) {
    	        var cbs = $("tr.jqgrow > td > input.cbox:disabled", setupJqGridWidthPagerHidden[0]);
    	        cbs.removeAttr("checked");
    	        var chx = $("tr.jqgrow:has(td > input.cbox:not(:checked))", setupJqGridWidthPagerHidden[0] )
    	        chx.removeAttr('aria-selected', false);
    	        chx.removeClass('ui-state-highlight', '');
    	        $('#resendEmail').attr('disabled', false);
    	    } else {
    	    	$('#resendEmail').attr('disabled', true);
    	    }
    	}},		
					[ 
					['iedieirdNumber', 'IED/IERD No.', 40],
					['emailAddress', 'Email Addresses', 70],
					['emailStatus', 'Status', 30],
					['sentTime', 'Email Sent Timestamp',75]], 'cdt_pager_email_table', searchCdtEmailTableUrl + ("?headerTitle=" + title));

    $("#setResendEmailList").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}


function onViewPayment(){
	var url = "";
	
	url = payDutiesAndTaxesUrl;
	url += '?serviceType='+"Customs Duties and Taxes";
	url += '&documentType='+"Collection";
	url += '&referenceType='+"Pay Duties and Taxes";
//	url += '&username='+$("#username").val();
	location.href = url;
}

function initUploadTransactions(){
	setupUploadTransactions();
	setResendEmailTable();
	
//	var gridList = $('#cdt_list_upload_transactions');
//
//	gridList.addRowData("1", {requestType:"Advanced",emailed:"Sent",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("2", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("3", {requestType:"Advanced",emailed:"Failed",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("4", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
//	gridList.addRowData("5", {requestType:"Advanced",collectionStatus:"New",collectionAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onViewPayment()\">pay</a>"});
	
}

$(initUploadTransactions);

