/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/12/12
 * Time: 1:34 PM
 * To change this template use File | Settings | File Templates.
 */

function setupDataEntryAsEtsTabs() {
    // count number of tabs
    var numOftabs = $("#tabs li").length;
    var tabsToDisable = new Array()

    // lists all tabs to disable
    for(var ctr = 1; ctr < numOftabs; ctr++) {
        tabsToDisable.push(ctr)
    }

    if(referenceType == "ETS") {
        var etsNumber = $("#etsNumber").val();

        //if(referenceType == "ETS")
        // enables other tabs if ets number exist
        if(!etsNumber){
            $("#tab_container").tabs({disabled: tabsToDisable})
        }
    } else if(referenceType == "DATA_ENTRY") {
        var tradeServiceId = $("#tradeServiceId").val();

        //if(referenceType == "ETS")
        // enables other tabs if ets number exist
        if(!tradeServiceId){
            $("#tab_container").tabs({disabled: tabsToDisable})
        }
    }
}

$(setupDataEntryAsEtsTabs);
