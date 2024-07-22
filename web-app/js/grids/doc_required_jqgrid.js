function setupDocumentRequiredGrids(){
    var doc_required_url = documentsRequiredUrl;

    setupJqGridWidthNoPagerHiddenNotSortable('doc_required_list', {width: 780, multiselect: true, scrollOffset:0, height: "auto", loadui: "disable", loadComplete: setSelected},
	                 [['description', 'Documents'],
		             ['edit', 'Edit', 10, 'center']], doc_required_url);
}

function setSelected() {
    $.post(savedDocumentsRequiredUrl, {}, function(data) {
        for(var i in data.documentCode) {
            $("#doc_required_list").jqGrid("setSelection", data.documentCode[i]);
        }
    });
}

function initDocumentRequiredGrid() {
    setupDocumentRequiredGrids();
}

$(initDocumentRequiredGrid);
