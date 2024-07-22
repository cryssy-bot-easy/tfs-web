/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/31/12
 * Time: 2:41 PM
 * To change this template use File | Settings | File Templates.
 */

/** Created by: Rafael Ski Poblete 
 * Date : 8/28/18
 * Description : Changed requiredDocDescription to accept Z character set.
*/

function deleteAddedDocsRequired(id) {
    docReqSaveType = "adddelete";

    $("#requiredDocId").val(id);
    action = "save";
//    onSaveClick();
    confirmAlert();
}

function editAddedDocsRequired(id) {
    docReqSaveType = "addedit";

    var data = $("#preview_doc_required_list").jqGrid("getRowData", id);

    $("#requiredDocId").val(id);
    $("#requiredDocDescription").val(data.description.replace(/<BR>/gmi,"\n"));

    centerPopup("popup_docsRequired", "add_docsRequired_bg");
    loadPopup("popup_docsRequired", "add_docsRequired_bg");
}

function editDocsRequired(id) {
	//check if the row is selected
	if($.inArray(id,$("#doc_required_list").jqGrid("getGridParam","selarrrow")) < 0){
		$("#alertMessage").text("This row is not selected");
		triggerAlert();
		return;
	}

	docReqSaveType = "edit";
    
    var data = $("#doc_required_list").jqGrid("getRowData", id);
 
    $("#requiredDocId").val(id);
    $("#requiredDocumentCode").val(data.documentCode);
    $("#additionalCondition").limitCharAndLines(65, 100, 'Z');
    $("#requiredDocDescription").val(data.description.replace(/<BR>/gmi,"\n"));

    centerPopup("popup_docsRequired", "add_docsRequired_bg");
    loadPopup("popup_docsRequired", "add_docsRequired_bg");
}

function closeRequiredDocsPopup() {
    docReqSaveType = "";
    disablePopup("popup_docsRequired", "add_docsRequired_bg");
    $("#requiredDocId, #requiredDocumentCode, #requiredDocDescription").val("");
}

function openRequiredDocsPopup() {
    docReqSaveType = "add";

    $("#requiredDocId, #requiredDocumentCode, #requiredDocDescription").val("");

    centerPopup("popup_docsRequired", "add_docsRequired_bg");
    loadPopup("popup_docsRequired", "add_docsRequired_bg");
}

function initializeRequiredDocsPopup() {
    $("#close_docsRequired_close, #close_docsRequired").click(closeRequiredDocsPopup);
    $("#btnAddConditionRequiredDoc").click(openRequiredDocsPopup);
    $("#requiredDocDescription").limitCharAndLines(65, 100, 'Z');
}

$(initializeRequiredDocsPopup);
