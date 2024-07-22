function openAddNewDocumentPopup() {
    loadPopup("addNewDocumentPopup", "popupBackground_add_new_document");
    centerPopup("addNewDocumentPopup", "popupBackground_add_new_document");
    
    var selectedDocEnclosed = $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow");

    for (i in selectedDocEnclosed) {
        var id = selectedDocEnclosed[i];

        // applies changes on click save - start
        var obj = new Object();
        obj.keys = true;
        obj.oneditfunc = null;
        obj.successfunc = null;
        obj.url = documentsEnclosedUrl;
        obj.extraparam = null;
        obj.aftersavefunc = null;
        obj.errorfunc = null;
        obj.afterrestorefunc = null;
        obj.restoreAfterError = true;
        obj.mtype = "POST";

        $("#grid_list_documents_enclosed").saveRow(id, obj, undefined, undefined, undefined, undefined, undefined);
    }
    

    var arr1 = "";

    $.each(selectedDocEnclosed, function(id, val) {

        var documentSelected = $("#grid_list_documents_enclosed").jqGrid("getRowData", val);

        documentSelected["id"] = val;

        arr1 += JSON.stringify(documentSelected)+"|"
    });

    $("#documentsEnclosedList").val(arr1);

    // enclosedInstructions
    var selectedEnclosedInstr = $("#grid_list_instructions").jqGrid("getGridParam", "selarrrow");

    for (i in selectedEnclosedInstr) {
        var id = selectedEnclosedInstr[i];

        // applies changes on click save - start
        var obj = new Object();
        obj.keys = true;
        obj.oneditfunc = null;
        obj.successfunc = null;
        obj.url = enclosedInstructionsUrl;
        obj.extraparam = null;
        obj.aftersavefunc = null;
        obj.errorfunc = null;
        obj.afterrestorefunc = null;
        obj.restoreAfterError = true;
        obj.mtype = "POST";

        $("#grid_list_instructions").saveRow(id, obj, undefined, undefined, undefined, undefined, undefined);
    }

    var arr2 = "";

    $.each(selectedEnclosedInstr, function(id, val) {
        var instrSelected = $("#grid_list_instructions").jqGrid("getRowData", val);

        instrSelected["id"] = val;
        delete instrSelected.edit;

        arr2 += JSON.stringify(instrSelected)+"|"
    });

    $("#enclosedInstructionList").val(arr2);

    $(".saveAction").show();
}

function closeAddNewDocumentPopup() {
    $("#documentName").val("");
    disablePopup("addNewDocumentPopup", "popupBackground_add_new_document");
}

function saveEnclosedDocument() {
	var selectedDocEnclosed = $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow");

	var arr1 = "";
    for (i in selectedDocEnclosed) {
        var id = selectedDocEnclosed[i];

        if (arr1.length > 0){
        	arr1 += ", "        	
        }
        arr1 += id
    }

    $("#documentsEnclosedList").val(arr1);
    var params = {
        page: 1,
        postData: {documentName: function () {
            if ($("#documentName").val() != "") {
                return $("#documentName").val()
            } else {
                return ""
            }
        }}
    }

    $("#grid_list_documents_enclosed").jqGrid('setGridParam', params).trigger("reloadGrid");
    closeAddNewDocumentPopup();
}

function initializeAddNewDocument() {
    $("#add_new_document").click(openAddNewDocumentPopup);
    $(".popupClose_add_new_document").click(closeAddNewDocumentPopup);
    $("#save_new_document").click(saveEnclosedDocument);

    $("#add_new_condition").click(function() {
        $("#newInstruction").val("");
        loadPopup("popup_addNewInstruction", "addNewInstruction_bg");
        centerPopup("popup_addNewInstruction", "addNewInstruction_bg");
    });
}

$(initializeAddNewDocument);