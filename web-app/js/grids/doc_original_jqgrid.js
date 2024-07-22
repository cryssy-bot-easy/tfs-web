function setupDocumentOriginalGrids(){
  var doc_original_url = originalDocumentsUrl;

  setupJqGridWidthNoPagerHiddenNotSortable('doc_original_list', {width: 780, scrollOffset:0, height: "auto", loadui: "disable"},
    [['description', 'Original Documents']], doc_original_url);
}

function initDocumentOriginalGrid() {
  setupDocumentOriginalGrids();
}

$(initDocumentOriginalGrid);
