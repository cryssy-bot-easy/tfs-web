function onUploadAttachedFile() {
	if($("#fileLocation").val()==""){
		$("#alertMessage").text("Please select a File");
		triggerAlert();
		return;
	}
	
	var postUrl = uploadDocumentUrl;

	var params = {
            serviceType: $("#serviceType").val(),
            documentType: $("#documentType").val(),
            documentClass: $("#documentClass").val(),
            documentSubType1: $("#documentSubType1").val(),
            documentSubType2: $("#documentSubType2").val(),
            etsNumber: $("#etsNumber").val(),
            tradeServiceId:$("#tradeServiceId").val(),
            //form: "attachedDocuments",
            form: "attachedDocumentsTabForm",            
			docType: $("#docType").val(),
			fileDirectory: $("#fileLocation").val(),
			enctype:"multipart/form-data" 
	}
	
	$("#attachedDocumentsTabForm").submit();
}

function initializeAttachedDocumentsTab() {
	$("#uploadAttachedFile").click(onUploadAttachedFile);
}

$(initializeAttachedDocumentsTab);