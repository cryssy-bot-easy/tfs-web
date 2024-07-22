function setupAddConditions2Grids(){
    var add_conditions2_url = addedConditionUrl;

    setupJqGridPagerNotSortable('add_conditions2_list', {width: 780, scrollOffset:0, loadui: "disable", loadComplete: getAllAddedAdditionalCondition,
    	rowNum: 50, scroll: true},
	    [['condition', 'Condition'],
	    ['edit', 'Edit', 10],
        ['deleteFile', 'Delete', 10]], 'add_conditions2_pager', add_conditions2_url);
}

function getAllAddedAdditionalCondition() {
    $.post(getAllAddedConditionUrl, {}, function(data) {
        var arr = new Array();

        for(var i in data.addedConditionsList) {
            var addedConditions = {
                condition: data.addedConditionsList[i].condition,
                conditionType: data.addedConditionsList[i].conditionType
            }

            arr.push(addedConditions);
        }

        $("#addedAdditionalConditionsList").val(JSON.stringify(arr));
    })
}


function initAddConditions2Grid() {
    setupAddConditions2Grids();
}

$(initAddConditions2Grid);
