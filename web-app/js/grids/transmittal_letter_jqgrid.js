var clientDocumentsGrid = '#grid_list_clients_documents';
$(document).ready(function(){
	initializeGrids();
});

function setUpDetailsTransmittalGrids(){
	var clients_documents_url = transmittalLettersUrl;
	var transmittal_letter__url = addedLetterUrl;
//	setupJqGridPagerNotSortable('grid_list_clients_documents', {width: 600, height: "auto", scrollOffset:1, multiselect:true, loadComplete: setupTransmittalLetter},
    setupClientsDocumentsGrid('grid_list_clients_documents', {
            width: 600,
            height: "auto",
            loadui: "disable",
            scrollOffset: 1,
            multiselect:true,
            loadComplete: setupTransmittalLetter
        },
			[['clientsDocuments', 'Client\'s Documents'],
			['originalClientsDocuments', 'Original Copy'],
			['duplicateClientsDocuments', 'Duplicate Copy']], clients_documents_url, [1,2], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], 'text');
	
//	setupJqGridPagerNotSortable('grid_list_transmittal_letter', {width: 600, scrollOffset:1, loadComplete: setupAddedTransmittalLetters},

    var array = new Array();
    for (var ctr = 1; ctr <= 1000; ctr++) { // temp workaround: removed pager
        array.push(ctr);
    }

    setupTransmittalLetterGrid('grid_list_transmittal_letter', {width: 600, loadui: "disable", scrollOffset:1, loadComplete: setupAddedTransmittalLetters,onSortCol:stopSorting},
			[['descriptionTransmittal', 'Description'],
			['originalTransmittal', 'Original Copy'],
			['duplicateTransmittal', 'Duplicate Copy'],
			['editTransmittal', 'Edit'],
//			['deleteTransmittal', 'Delete']], 'grid_pager_transmittal_letter', transmittal_letter__url, [1,2], [1,2,3,4,5,6,7,8,9,10,11], 'text');
            ['deleteTransmittal', 'Delete']], 'grid_pager_transmittal_letter', transmittal_letter__url, [1,2], array, 'text');
}

//have to stop sorting. it adds a null entry to transmittal grid when
//the header is clicked. onChangeCopies(id) is tied to loadComplete event
//so it is fired when user clicks the header (<_<`)
function stopSorting(){
	return 'stop';
}


function setupTransmittalLetter() {
    $(".defCopy").autoNumeric({mDec: 0});

    $.post(savedTransmittalLetterUrl, {}, function(data) {
        for(var i in data.transmittalLetterCode) {
            $("#grid_list_clients_documents").jqGrid("setSelection", data.transmittalLetterCode[i], false);
//            jQuery("#grid_list_clients_documents").restoreRow(data.transmittalLetterCode[i]);
        }
    });
}

function setupAddedTransmittalLetters() {

//    $(".newCopy").autoNumeric({mDec: 0});
//
//    $(".newCopy").focusout(function() {
//        var id = $(this).closest('tr').attr("id");
//        alert(id)
//        onChangeCopies(id);
//    });
    var id = $("#grid_list_transmittal_letter").jqGrid("getGridParam", "selrow");
    onChangeCopies(id);

    $.post(getAllAddedLetterUrl, {}, function(data) {
        var arr = new Array();

        for(var i in data.addedLettersList) {
            var addedLetter = {
                letterDescription: data.addedLettersList[i].letterDescription,
                letterType: data.addedLettersList[i].letterType,
                originalCopy: data.addedLettersList[i].originalCopy,
                duplicateCopy: data.addedLettersList[i].duplicateCopy
            }

            arr.push(addedLetter);
        }

        $("#addedTransmittalLetterList").val(JSON.stringify(arr));
    })
}

function onChangeCopies(id) {
    var data = $("#grid_list_transmittal_letter").jqGrid("getRowData", id);

//    var container = "#tempContainer";
//    $(data.originalTransmittal).appendTo(container);
//    $(data.duplicateTransmittal).appendTo(container);
//
//    var originalCopy
//    var duplicateCopy
//
//    $("#tempContainer > :input").each(function() {
//        if($(this).attr("name") == "originalCopy") {
//            originalCopy = $(this).val();
//        }
//
//        if($(this).attr("name") == "duplicateCopy") {
//            duplicateCopy = $(this).val();
//        }
//    });
//
//    $("#tempContainer").empty();

    var addData = {
        id: id,
        letterDescription: data.descriptionTransmittal,
        originalCopy: data.originalTransmittal,
        duplicateCopy: data.duplicateTransmittal
//        originalCopy: originalCopy,
//        duplicateCopy: duplicateCopy
    }

    var reloadUrl = addedLetterUrl;
    reloadUrl += "?updatedLetter="+JSON.stringify(addData);

    $("#grid_list_transmittal_letter").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");
}

function initializeGrids(){
	setUpDetailsTransmittalGrids();
}