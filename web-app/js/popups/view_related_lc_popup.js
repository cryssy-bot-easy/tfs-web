function extractLetterOfCredit() {
    var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");

    $.post(extractDataFromRelatedLcUrl, {documentNumber: id}, function(data) {
        $("#importerCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: data.lc.importerCbCode});
        $("#exporterCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: data.lc.exporterCbCode});
        var importerCifNumber = data.lc.importerCifNumber ? data.lc.importerCifNumber : data.lc.applicantCifNumber;
        if (importerCifNumber != "" && importerCifNumber != null) {
        	$("#importerCifNumber").val(importerCifNumber);
        }
        $("#importerName").val(data.lc.importerName ? data.lc.importerName : data.lc.applicantName);
        $("#importerAddress").val(data.lc.importerAddress ? data.lc.importerAddress : data.lc.applicantAddress);
        $("#exporterName").val(data.lc.exporterName ? data.lc.exporterName : data.lc.beneficiaryName);
        $("#exporterAddress").val(data.lc.exporterAddress ? data.lc.exporterAddress : data.lc.beneficiaryAddress);
        $("#generalDescriptionOfGoods").val(data.lc.generalDescriptionOfGoods);
        $("#relatedLcDescriptionOfGoods").val(data.lc.generalDescriptionOfGoods);

        if ($("#applicantName").length > 0 && $("#applicantAddress").length > 0 && $("#applicantCifNumber").length > 0) {
            var applicantCifNumber = data.lc.applicantCifNumber;
            var applicantName = data.lc.applicantName;
            var applicantAddress = data.lc.applicantAddress;

            if (applicantCifNumber == "" || applicantCifNumber == undefined) {
                applicantCifNumber = data.lc.importerCifNumber;
            }

            if (applicantName == "" || applicantName == undefined) {
                applicantName = data.lc.importerName;
            }

            if (applicantAddress == "" || applicantAddress == undefined) {
                applicantAddress = data.lc.importerAddress;
            }

            $("#applicantCifNumber").val(applicantCifNumber);
            $("#applicantName").val(applicantName);
            $("#applicantAddress").val(applicantAddress);
        }

        if ($("#beneficiaryName").length > 0 && $("#beneficiaryAddress").length > 0) {
            var beneficiaryName = data.lc.beneficiaryName;
            var beneficiaryAddress = data.lc.beneficiaryAddress;

            if (beneficiaryName == "" || beneficiaryName == undefined) {
                beneficiaryName = data.lc.exporterName;
            }

            if (beneficiaryAddress == "" || beneficiaryAddress == undefined) {
                beneficiaryAddress = data.lc.exporterAddress;
            }

            $("#beneficiaryName").val(beneficiaryName);
            $("#beneficiaryAddress").val(beneficiaryAddress);
        }
    });
}

function extractAllDocumentsRequired(){
	var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");
	var doc_required_url = extractDocumentsRequiredUrl;
	
	$("#doc_required_list").jqGrid("setGridParam", {url: doc_required_url+"?relatedLcNumber="+id, page: 1, loadComplete: extractRelatedLcDocumentsRequired}).trigger("reloadGrid");
	
}

function extractRelatedLcDocumentsRequired() {	
	var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");
	$.post(extractRelatedLcDocumentsRequiredUrl, {documentNumber: id}, function(data) {
		$("#doc_required_list").jqGrid('resetSelection');
        for(var i in data.documentCode) {
        	$("#doc_required_list").jqGrid("setSelection", data.documentCode[i]);
        }
    }).done(function(){
    	var requiredDocuments = $("#doc_required_list").jqGrid("getGridParam","selarrrow");
        var requiredDocumentsList = new Array();

        for(var i in requiredDocuments) {
        	var id = requiredDocuments[i]
        	var data = $("#doc_required_list").jqGrid("getRowData", id);
            var requiredDocumentItem = {documentCode: id, description: data.description};
            	requiredDocumentsList.push(requiredDocumentItem);
        }
        $("#relatedRequiredDocumentsList").val(JSON.stringify(requiredDocumentsList));
    });
}

function extractPreviewDocumentRequiredGrids(){
	var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");
	var preview_doc_required_url = extractAddedDocumentsUrl;

	$("#preview_doc_required_list").jqGrid("setGridParam", {url: preview_doc_required_url+"?documentNumber="+id+"&deleteDocuments=deleteDocuments", page: 1, loadComplete: extractAllAddedDocs}).trigger("reloadGrid");
}

function extractAllAddedDocs() {

    $.post(extractAllAddedDocumentsUrl, {}, function(data) {
        var arr = new Array();
        
        for(var i in data.addedList) {
            var addedDocument = {
                description: data.addedList[i].description,
                requiredDocumentType: data.addedList[i].requiredDocumentType
            }
            arr.push(addedDocument);
        }
        $("#relatedAddedDocumentsList").val(JSON.stringify(arr));
    });
}

function extractAdditionalCondition() {
	var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");
	
    $.post(extractAdditionalConditionUrl, {documentNumber: id}, function(data) {
    	$("#add_conditions1_list").jqGrid('resetSelection');
        for(var i in data.conditionCode) {
            $("#add_conditions1_list").jqGrid("setSelection", data.conditionCode[i]);
        }
    }).done(function(){
    	var requiredDocuments = $("#add_conditions1_list").jqGrid("getGridParam","selarrrow");
        var requiredDocumentsList = new Array();

        for(var i in requiredDocuments) {
            var id = requiredDocuments[i]

            var data = $("#add_conditions1_list").jqGrid("getRowData", id);

            var requiredDocumentItem = {conditionCode: id, condition: data.condition};

            requiredDocumentsList.push(requiredDocumentItem);
        }
        
        $("#relatedAdditionalConditionsList").val(JSON.stringify(requiredDocumentsList));
    });
}

function extractAddConditions2Grids(){
	var id = $("#grid_list_related_lcs").jqGrid("getGridParam", "selrow");
	var add_conditions2_url = extractAddedConditionUrl;

	$("#add_conditions2_list").jqGrid("setGridParam", {url: add_conditions2_url+"?documentNumber="+id+"&deletedCondition=deletedCondition", page: 1, loadComplete: extractAllAddedAdditionalCondition}).trigger("reloadGrid");
	
}

function extractAllAddedAdditionalCondition() {

    $.post(extractAllAddedConditionUrl, {}, function(data) {
    	 var arr = new Array();

         for(var i in data.addedConditionsList) {
             var addedConditions = {
                 condition: data.addedConditionsList[i].condition,
                 conditionType: data.addedConditionsList[i].conditionType
             }

             arr.push(addedConditions);
         }

         $("#relatedAddedAdditionalConditionsList").val(JSON.stringify(arr));
    });
}

$(document).ready(function(){
	var wrapper_div=$("#related_lc_popup").attr("id");
	var div_bg=$("#related_lc_bg").attr("id");
	
	$("#popup_btn_view_related_lc").click(function(){
		$("#popup_header_viewRelatedLc").text("Related LCs");

        $("#grid_list_related_lcs").jqGrid('setGridParam', {url: relatedLcUrl, page: 1}).trigger("reloadGrid");

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$(".close_viewRelatedLc").click(function(){
		disablePopup(wrapper_div,div_bg);
	});

	$("#selectRelatedLc").click(function(){
    	extractLetterOfCredit();
    	extractAllDocumentsRequired();
    	extractPreviewDocumentRequiredGrids();
    	extractAdditionalCondition();
    	extractAddConditions2Grids();
   });
	
});