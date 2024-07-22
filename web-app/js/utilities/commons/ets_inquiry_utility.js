// clears search parameters
function onResetEtsBtn() {
	var postUrl = branchEtsInquiryUrl;
	postUrl += "?unitcode="+unitcode;
	var grid = null;
	
	if($("#grid_list_ets_inquiry_branch").length > 0) {
		grid = $("#grid_list_ets_inquiry_branch");
	} else {
		grid = $("#grid_list_ets_inquiry_main");
	}
	
	grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
//    $("#etsNumber, #cifName, #transactionType, #status, #etsDate, #cifNumber, #ccbdBranchUser").val("");
}

$("#basicDetailsTabForm").change()

function onSearchEtsBtn() {
    var postUrl = branchEtsInquiryUrl;
    postUrl += "?"+$("#etsInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;

    if($("#grid_list_ets_inquiry_branch").length > 0) {
        grid = $("#grid_list_ets_inquiry_branch");
    } else {
        grid = $("#grid_list_ets_inquiry_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertEtsCount}).trigger("reloadGrid");
}

function alertEtsCount(){
	var grid;
	
	if ($("#grid_list_ets_inquiry_branch").length > 0) {
		grid = $("#grid_list_ets_inquiry_branch");
	} else {
		grid = $("#grid_list_ets_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function onViewEtsClick(id) {

    var grid = null;

    if($("#grid_list_ets_inquiry_branch").length > 0) {
        grid = $("#grid_list_ets_inquiry_branch");
    } else {
        grid = $("#grid_list_ets_inquiry_main");
    }

    var data = grid.jqGrid('getRowData',id);

    var gotoUrl = viewEtsUrl;
    gotoUrl += "?serviceType="+data.serviceType;
    gotoUrl += "&documentClass="+data.documentClass;
    gotoUrl += "&documentType="+data.documentType;
    gotoUrl += "&documentSubType1="+data.documentSubType1;
    gotoUrl += "&documentSubType2="+data.documentSubType2;
    gotoUrl += "&etsNumber="+id;
    gotoUrl += "&viewMode=viewMode";

    if (data.serviceType.toUpperCase().indexOf("REVERSAL") != -1) {
        gotoUrl += "&reversalEtsNumber="+id;
    }

    location.href = gotoUrl;
}

function onReverseClick(id){
    var grid = null;

    if($("#grid_list_ets_inquiry_branch").length > 0) {
        grid = $("#grid_list_ets_inquiry_branch");
    } else {
        grid = $("#grid_list_ets_inquiry_main");
    }

    var data = grid.jqGrid('getRowData',id);

    $.post(getHasReversalUrl, {serviceInstructionId: id, serviceType: data.serviceType.toUpperCase()}, function(data) {

        if (data.hasReversal == "false") {
//            var data = grid.jqGrid('getRowData',id);
            var data = grid.jqGrid('getRowData',id);

            var gotoUrl = reverseEtsUrl;
            gotoUrl += "?serviceType="+(data.serviceType.toUpperCase().indexOf("_REVERSAL") < 0 ? data.serviceType.toUpperCase() + "_REVERSAL" : data.serviceType);
            gotoUrl += "&documentClass="+data.documentClass;
            gotoUrl += "&documentType="+data.documentType;
            gotoUrl += "&documentSubType1="+data.documentSubType1;
            gotoUrl += "&documentSubType2="+data.documentSubType2;
            gotoUrl += "&reverseEts=true";
            gotoUrl += "&etsNumber="+id;
            gotoUrl += "&username="+username;
            gotoUrl += "&unitcode="+unitcode;
//    alert(gotoUrl);
            location.href = gotoUrl;
        } else {
            triggerAlertMessage("There is an ongoing Reversal Transaction.");
        }
    });
}

function setupProductType() {
    var options;
    var transactions = {
        ADJUSTMENT : "ADJUSTMENT",
        AMENDMENT : "AMENDMENT",
        CANCELLATION_LC : "CANCELLATION",
        NEGOTIATION : "NEGOTIATION",
        NEGOTIATION_DISCREPANCY : "NEGOTIATION DISCREPANCY",
        OPENING : "OPENING",
        UA_LOAN_MATURITY_ADJUSTMENT : "UA LOAN MATURITY ADJUSTMENT",
        UA_LOAN_SETTLEMENT : "UA LOAN SETTLEMENT",
        SETTLEMENT: "SETTLEMENT"
    }

    var product = $("#product").val();

    switch (product) {
        case "LC":
        case "INDEMNITY":
       
            options = {
                    CASH : "CASH",
                    REGULAR: "REGULAR",
                    STANDBY: "STANDBY"
            }

            $("#documentClass").val(product);
            $("#documentSubType1").val("");
            $("#serviceType").val("");

            if ($("#documentClass").val() == "INDEMNITY") {
                transactions = {
                    ISSUANCE : "INDEMNITY ISSUANCE",
                    CANCELLATION : "INDEMNITY CANCELLATION"
                }
            }

            break;
        case "NON-LC":
        
            if ($("#documentType").val() == "DOMESTIC") {
                options = {
                    DP : "DOCUMENTS AGAINST PAYMENT"
                }
            } else {
                options = {
                    DA : "DOCUMENTS AGAINST ACCEPTANCE",
                    DP : "DOCUMENTS AGAINST PAYMENT",
                    DR : "DIRECT REMITTANCE",
                    OA : "OPEN ACCOUNT SETTLEMENT"
                }

                if ($("#documentClass").val() == "DA") {
                    transactions = {
//                        NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
//                        NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
                        SETTLEMENT: "SETTLEMENT"
//                        CANCELLATION: "CANCELLATION"
                    }
                } else if ($("#documentClass").val() == "DP" ||
                    $("#documentClass").val() == "DR" ||
                    $("#documentClass").val() == "OA") {
                    transactions = {
//                        NEGOTIATION: "NEGOTIATION",
                        SETTLEMENT: "SETTLEMENT"
//                        CANCELLATION: "CANCELLATION"
                    }
                }
            }
//            $("#documentClass").val("");
            $("#documentSubType1").val("");
            $("#serviceType").val("");
            break;
        case "IMPORT_ADVANCE":
        case "EXPORT_ADVANCE":
            $("#documentClass").val("");
            $("#documentSubType1").val("");
            $("#serviceType").val("");
            break;
        case "EXPORT_BILLS":
            options = {
                BP : "BILLS PURCHASED",
                BC : "BILLS FOR COLLECTION"
            }
            $("#documentClass").val("");
            $("#documentSubType1").val("");
            $("#serviceType").val("");
            break;
        case "AUXILLARY_IMPORT_PRODUCTS":
            options = {
                MDA : "MD APPLICATION",
                MDC : "MD COLLECTION",
                ARS : "AR SETTLE",
                APR : "AP REFUND",
                IP : "IMPORT ADVANCE PAYMENT",
                IR : "IMPORT ADVANCE REFUND",
                PC : "PAYMENT OF OTHER IMPORT CHARGES",
                CORRES : "SETTLEMENT OF ACTUAL CORRES CHARGES"
            }
            $("#documentClass").val("");
            $("#documentSubType1").val("");
            $("#serviceType").val("");
            break;
    }

    // product type
    $("#productType").empty();
    $('#productType').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
    $.each(options, function(val, text) {
        $('#productType').append(
            $('<option></option>').val(val).html(text)
        );
    });

    // transaction type
    $("#transactionType").empty();
    $('#transactionType').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
    $.each(transactions, function(val, text) {
        $('#transactionType').append(
            $('<option></option>').val(val).html(text)
        );
    });
}

function changeProductType() {
    switch (this.value) {
        case "CASH":
        case "REGULAR":
        case "STANDBY":
            $("#documentSubType1").val(this.value);
            break;
        case "DA":
            $("#documentClass").val("DA");
//            $("#documentSubType1").val("SETTLEMENT");
            var transactions = {
//                NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
//                NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
                SETTLEMENT: "SETTLEMENT"
//                CANCELLATION: "CANCELLATION"
            }
            $("#transactionType").empty();
            $('#transactionType').append(
                $('<option></option>').val("").html("SELECT ONE...")
            );
            $.each(transactions, function(val, text) {
                $('#transactionType').append(
                    $('<option></option>').val(val).html(text)
                );
            });
            break;
        case "DP":
            $("#documentClass").val("DP");
//            $("#documentSubType1").val("SETTLEMENT");
            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT"
//                CANCELLATION: "CANCELLATION"
            }
            $("#transactionType").empty();
            $('#transactionType').append(
                $('<option></option>').val("").html("SELECT ONE...")
            );
            $.each(transactions, function(val, text) {
                $('#transactionType').append(
                    $('<option></option>').val(val).html(text)
                );
            });
            break;
        case "DR":
            $("#documentClass").val("DR");
//            $("#documentSubType1").val("SETTLEMENT");
            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT"
//                CANCELLATION: "CANCELLATION"
            }
            $("#transactionType").empty();
            $('#transactionType').append(
                $('<option></option>').val("").html("SELECT ONE...")
            );
            $.each(transactions, function(val, text) {
                $('#transactionType').append(
                    $('<option></option>').val(val).html(text)
                );
            });
            break;
        case "OA":
            $("#documentClass").val("OA");
//            $("#documentSubType1").val("SETTLEMENT");
            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT"
//                CANCELLATION: "CANCELLATION"
            }
            $("#transactionType").empty();
            $('#transactionType').append(
                $('<option></option>').val("").html("SELECT ONE...")
            );
            $.each(transactions, function(val, text) {
                $('#transactionType').append(
                    $('<option></option>').val(val).html(text)
                );
            });
            break;
        case "MDC":
            $("#documentClass").val("MD");
            $("#documentSubType1").val("COLLECTION");
            break;
        case "MDA":
            $("#documentClass").val("MD");
            $("#documentSubType1").val("APPLICATION");
            break;
        case "ARS":
            $("#documentClass").val("AR");
            $("#documentSubType1").val("SETTLE");
            break;
        case "APR":
            $("#documentClass").val("AP");
            $("#documentSubType1").val("REFUND");
            break;
        case "BP":
        case "BC":
        case "IP":
        case "IR":
        case "PC":
        case "CORRES":
            $("#documentClass").val("");
            $("#documentSubType1").val("");
            break;
    }
}

function changeTransactionType() {
    $("#serviceType").val(this.value);

    if (this.value == "CANCELLATION_LC") {
        $("#serviceType").val("CANCELLATION");
    }
}

function initializeBranchEtsInquiry() {
    $("#resetEtsBtn").click(onResetEtsBtn);
    $("#searchEtsBtn").click(onSearchEtsBtn);

    $("#product").change(setupProductType);
    $("#productType").change(changeProductType);
    $("#documentType").change(setupProductType);
    $("#transactionType").change(changeTransactionType);
}

$(initializeBranchEtsInquiry);