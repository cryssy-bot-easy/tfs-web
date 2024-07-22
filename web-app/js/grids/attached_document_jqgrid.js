function setupAttachDocumentGrids(){
	var attachedDocumentGridUrl = attachedDocumentsUrl;
	
	setupJqGridWidthPagerHidden('grid_list_attached_documents', {width: 780, loadui: "disable", scrollOffset:0},
					[['documentType', 'Document Type', 20],
					['fileName', 'File Names' , 55],
					['dateTimeUploaded', 'Date & Time Uploaded', 20],
					['viewFile', 'View', 5, 'center'],
					['deleteFile', 'Delete', 5, 'center']], 'grid_pager_attached_documents', attachedDocumentGridUrl);
}

// view action
function onViewFileClick(id) {
	// TODO view action here
	alert("view " + id+ " action here");
}

function onViewFileClicked(id,grid_id,tradeServiceId) {

    var postUrl = downloadDocumentUrl;
    postUrl += '?id=' + id;
    postUrl += '&tradeServiceId=' + tradeServiceId;
    postUrl = encodeURI(postUrl);
    window.open(postUrl);
}

function onDeleteFileClicked(id,grid_id,tradeServiceId) {

    var params = {
        id: id,
        tradeServiceId: tradeServiceId
    }

    $.post(deleteDocumentUrl,params,function(data) {

        // alert("data.success = " + data.success)
        if (data.success == true) {
            $("#"+grid_id).jqGrid("delRowData",id);
            $("#alertMessage").text("Attachment deleted.");
            // $("#alertMessage").text("Attachment deleted: id = " + id + ", filename = " + filename);
        } else {
            $("#alertMessage").text("(data.success=false) Failed to delete attachment: " + data.message);
        }

    }).fail(function() {
        $("#alertMessage").text("(fail function) Failed to delete attachment.");
    });

    triggerAlert();
}



// inserts to attached documents grid
//function insertToAttachedDocsGrid() {
//	var gridList = $('#grid_list_attached_documents');
//
//	gridList.addRowData("1", {documentType:"Contract", fileName:"<a href=\"javascript:void(0)\" onclick=\" var id='1'; onViewFileClick(id);\" style=\"color: blue\">contract2012.doc</a>",dateTimeUploaded:"18 Jun 2012 - 11:30:07 AM",deleteFile:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\" onClick=\"var id='1'; onDeleteFileClick(id);\">delete</a>" });
//	gridList.addRowData("2", {documentType:"Bill of Lading",fileName:"<a href=\"javascript:void(0)\" onclick=\" var id='2'; onViewFileClick(id);\" style=\"color: blue\">BL101.pdf</a>", dateTimeUploaded:"20 Jun 2012 - 09:45:13 AM",deleteFile:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\" onClick=\"var id='2'; onDeleteFileClick(id);\">delete</a>" });
//	gridList.addRowData("3", {documentType:"Letter of Credit", fileName:"<a href=\"javascript:void(0)\" onclick=\" var id='3'; onViewFileClick(id);\" style=\"color: blue\">iccap-letter.doc</a>",dateTimeUploaded:"21 Jun 2012 - 03:05:28 PM",deleteFile:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\" onClick=\"var id='3'; onDeleteFileClick(id);\">delete</a>" });
//	gridList.addRowData("4", {documentType:"Contract", fileName:"<a href=\"javascript:void(0)\" onclick=\" var id='4'; onViewFileClick(id);\" style=\"color: blue\">contract.pdf</a>",dateTimeUploaded:"26 Jun 2012 - 08:04:28 AM",deleteFile:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\" onClick=\"var id='4'; onDeleteFileClick(id);\">delete</a>" });
//}

function initAttachedDocumentsGrid() {
	setupAttachDocumentGrids();

	// remove when backend is ready
//	insertToAttachedDocsGrid();
}

$(initAttachedDocumentsGrid);

