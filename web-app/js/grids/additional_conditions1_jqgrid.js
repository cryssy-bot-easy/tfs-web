function setupAddConditions1Grids(){
    var add_conditions1_url = additionalConditionsUrl;

    setupJqGridWidthNoPagerHiddenNotSortable('add_conditions1_list', {width: 780, multiselect: true, scrollOffset:0, height: "auto", loadui: "disable", loadComplete: setAdditionalConditionSelected},
	    [['condition', 'Condition'],
		['edit', 'Edit', 10, 'center']], add_conditions1_url);
}

function setAdditionalConditionSelected() {
    $.post(savedAdditionalConditionUrl, {}, function(data) {
        for(var i in data.conditionCode) {
            $("#add_conditions1_list").jqGrid("setSelection", data.conditionCode[i]);
        }
    });
}

function initAddConditions1Grid() {
    setupAddConditions1Grids();
}

$(initAddConditions1Grid);
