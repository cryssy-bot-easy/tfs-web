function validateRequiredMT103() {
    var errorMt = 0;

    $("#mt103TabForm :input").each(function() {

        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("requiredMT103") != -1) {
            if ($(this).val() == "") {
                errorMt ++;
            }
        }

    });

    if (errorMt > 0) {
        return "failed";
    } else {
        return "success";
    }
}