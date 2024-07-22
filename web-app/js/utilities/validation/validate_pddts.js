if (!window.console) {
    console = {
        log: function () {
            // do nothing
            // this is to avoid errors in ie7
        }
    };
}

function validatePddts(buttonParentId) {
    var error = 0;

    $("#" + buttonParentId + " :input").each(function () {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
            if ($(this).val() == "") {
                error++;

                if (!window.console) {

                } else {
                    console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
                }

            }
        }
    });

    if (error > 0) {
        triggerAlertMessage("Please fill up all required fields.")
        _pageHasErrors = true;
    } else {
        _pageHasErrors = false;
    }
}