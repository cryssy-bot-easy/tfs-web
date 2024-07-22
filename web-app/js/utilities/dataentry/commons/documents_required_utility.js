function onEditRequiredDoc(id){
	var grid = $("#doc_required_list").jqGrid("getRowData",id);
	
	$("#requiredDocListPopupField").val(grid.documents);
}

function onSaveRequiredDoc() {
	// TODO add documents required command
	alert('save required doc')
	disablePopup("requiredDocListPopup", "requiredDocListPopup_bg");
}

function initializeDocumentsRequiredUtility() {
	
	//for amendment dataentry
	if(serviceType == 'Amendment'){
		
		var documentsRequiredVal = $("#documentsRequiredFrom").val();
		$("#documentsRequiredTo").attr("readonly","readonly");
		
		$("#documentsRequiredRow").click(function (){
			if($("#documentsRequiredRow").attr("checked")=="checked"){
				$("#documentsRequiredTo").removeAttr("readonly","readonly");
				$("#documentsRequiredTo").val(documentsRequiredVal);
			}else{
				$("#documentsRequiredTo").attr("readonly","readonly");
			}
		});
		
	// for other serviceType
	}else{
		$("#btnRequiredDocSave").click(onSaveRequiredDoc);
	}
	
}

$(initializeDocumentsRequiredUtility);