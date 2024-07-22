function setupConditionsOriginalGrids(){
  var add_conditions1_original_url = originalConditionsUrl;

  setupJqGridWidthNoPagerHiddenNotSortable('add_conditions1_original_list', {width: 780, scrollOffset:0, height: "auto", loadui: "disable"},
    [['description', 'Original Conditions']], add_conditions1_original_url);
}

function initConditionsOriginalGrid() {
  setupConditionsOriginalGrids();
}

$(initConditionsOriginalGrid);
