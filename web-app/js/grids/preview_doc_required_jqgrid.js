	
	function setupPreviewDocumentRequiredGrids(){
		var preview_doc_required_url = addedDocumentsUrl;
		
		setupJqGridPagerNotSortable('preview_doc_required_list', {width: 780, scrollOffset:0, loadui: "disable", loadComplete: getAllAddedDocs, shrinkToFit: false},
						[['description', 'Description', 665, 'left'],
						['editDocument', 'Edit', 35, 'center'],
						['deleteDocument', 'Delete', 50, 'center']], 'preview_doc_required_pager', preview_doc_required_url);
	}

    function getAllAddedDocs() {
        $.post(getAllAddedDocumentsUrl, {}, function(data) {
            var arr = new Array();
            
            for(var i in data.addedList) {
                var addedDocument = {
                    description: data.addedList[i].description,
                    requiredDocumentType: data.addedList[i].requiredDocumentType
                }
                arr.push(addedDocument);
            }
            $("#addedDocumentsList").val(JSON.stringify(arr));
        })
    }

	function initPreviewDocumentRequiredGrid() {
		setupPreviewDocumentRequiredGrids();
	}

	$(initPreviewDocumentRequiredGrid);
