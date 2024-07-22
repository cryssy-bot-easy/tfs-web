/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/31/12
 * Time: 2:41 PM
 * To change this template use File | Settings | File Templates.
 * 
 * Modified by: Rafael Ski Poblete
 * Date: 08/28/18
 * Details: Added Character and line limiter to additionalCondition popup.
 */

function deleteAddedAdditionalCondition(id) {
    addCondType = "adddelete";

    $("#conditionCode").val(id);
    action = "save";
//  onSaveClick();
	confirmAlert();
}

function editAddedAdditionalCondition(id) {
    addCondType = "addedit";

    var data = $("#add_conditions2_list").jqGrid("getRowData", id);

    $("#conditionCode").val(id);
    $("#additionalCondition").val(data.condition);

    centerPopup("popup_additionalCondition", "add_additionalCondition_bg");
    loadPopup("popup_additionalCondition", "add_additionalCondition_bg");
}

function editAdditionalCondition(id) {

	//check if the row is selected
	if($.inArray(id,$("#add_conditions1_list").jqGrid("getGridParam","selarrrow")) < 0){
		$("#alertMessage").text("This row is not selected");
		triggerAlert();
		return;
	}
	
    addCondType = "edit";

    var data = $("#add_conditions1_list").jqGrid("getRowData", id);

    $("#conditionCode").val(id);
    $("#additionalCondition").limitCharAndLines(65, 100, 'Z');
    $("#additionalCondition").val(data.condition);

    centerPopup("popup_additionalCondition", "add_additionalCondition_bg");
    loadPopup("popup_additionalCondition", "add_additionalCondition_bg");
}

function closeAdditionalConditionPopup() {
    addCondType = "";
    disablePopup("popup_additionalCondition", "add_additionalCondition_bg");
    $("#conditionCode, #additionalCondition").val("");
}

function openAdditionalConditionPopup() {
    addCondType = "add";

    $("#conditionCode, #additionalCondition").val("");

    centerPopup("popup_additionalCondition", "add_additionalCondition_bg");
    loadPopup("popup_additionalCondition", "add_additionalCondition_bg");
}

function initializeAdditionalConditionPopup() {
    $("#close_additionalCondition, #close_additionalCondition_close").click(closeAdditionalConditionPopup);
    $("#addAditionalConditionBtn").click(openAdditionalConditionPopup);
	$("#additionalCondition").limitCharAndLines(65, 100, 'Z');
}

$(initializeAdditionalConditionPopup);
