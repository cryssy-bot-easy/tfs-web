

function onSaveAsPendingClick() {
    $("#saveAs").val("PENDING");
}



function onSaveAsDraftClick() {
    $("#saveAs").val("DRAFT");
}

function initializeButtonWrapper() {
    $("#saveAsPending").click(onSaveAsPendingClick);
    $("#saveAsDraft").click(onSaveAsDraftClick);
}



$(initializeButtonWrapper);
