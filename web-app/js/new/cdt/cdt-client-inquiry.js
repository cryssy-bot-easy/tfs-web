/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/2/13
 * Time: 3:12 PM
 * To change this template use File | Settings | File Templates.
 */

function viewCdtClient(id) {
   location.href = viewCdtClientUrl+"?agentBankCode="+id;
}

function searchCdtClientInquiry() {
    var postUrl = searchCdtClientUrl;
    postUrl += "?"+$("#cdtClientInquiryForm").serialize();
    $("#grid_list_client_file_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertCdtClientCount}).trigger("reloadGrid");
}

function alertCdtClientCount(){
	triggerAlertMessage($("#grid_list_client_file_inquiry").jqGrid('getGridParam', 'records') + " record/s found.");
	$("#grid_list_client_file_inquiry").jqGrid('setGridParam', {gridComplete: ""});
}

function resetCdtClientInquiry() {
    $("#importerName").val("");
    $("#aabRefCode").val("");
    $("#customsClientNumber").val("");
    $("#importerTin").val("");
    
    var postUrl = searchCdtClientUrl;

    $("#grid_list_client_file_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}

$(document).ready(function() {

    $("#searchCdtClientBtn").click(searchCdtClientInquiry);
    $("#resetCdtClientBtn").click(resetCdtClientInquiry);

})
