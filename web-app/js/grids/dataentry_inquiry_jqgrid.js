$(initDataEntryInquiry);

function setupDataEntryInquiryGrid(){
	var dataEntryInquiryGrid = dataEntryInquiryGridUrl;

    setupJqGridWidthPagerHidden('grid_list_dataentry_inquiry', {width: 780, height: 365, 
    	loadui: "disable", scrollOffset:0, rowNum: 20},
			[['unitCode', 'Unit Code', 125, 'center'],
 			 ['documentNumber', 'Document Number', 250],
			 ['etsNumber', 'e-TS Number'],
			 ['cifName', 'CIF Name', 300],
			 ['transactionName', 'Transaction Name'],
			 ['status', 'Status'],
			 ['lastUser', 'Last User'],
			 ['dateTime', 'Date/Time', 300],
			 ['view', 'View'],
			 ['serviceType','Service Type', 10, 'left','hidden'],
             ['documentType','Document Type', 10, 'left','hidden'],
             ['documentClass','Document Class', 10, 'left','hidden'],
             ['documentSubType1','SubType1', 10, 'left','hidden'],
             ['documentSubType2','SubType2', 10, 'left','hidden']], 'grid_pager_dataentry_inquiry', dataEntryInquiryGrid);
}

function searchDataEntry() {
    var postUrl = dataEntryInquiryGridUrl;
    
    if ($("#transactionType").val() == "CANCELLATION_LC") {
    	$("#serviceType").val("CANCELLATION");
    } else {
    	$("#serviceType").val($("#transactionType").val());
    }
    
    switch($("#productType").val()){
    	case "CASH":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("CASH");
    		break;
    	case "REGULAR":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("REGULAR");
    		break;
    	case "STANDBY":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("STANDBY");
    		break;
    	case "FIRST_ADVISING":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("FIRST_ADVISING");
    		break;
    	case "SECOND_ADVISING":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("SECOND_ADVISING");
    		break;
    	case "":
    		$("#documentClass").val($("#product").val());
    		$("#documentSubType1").val("");
    		break;
    	default:
    		$("#documentClass").val($("#productType").val());
    		$("#documentSubType1").val("");
    		break;
    }
    
    postUrl += "?"+$("#dataEntryInquiry").serialize();
    $("#grid_list_dataentry_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertDataEntryCount}).trigger("reloadGrid");
}

function alertDataEntryCount(){
	triggerAlertMessage($("#grid_list_dataentry_inquiry").jqGrid('getGridParam', 'records') + " record/s found.");
	$("#grid_list_dataentry_inquiry").jqGrid('setGridParam', {gridComplete: ""});
}


function resetDataEntry() {
//    $("#documentNumber, #cifName, #transactionName, #status").val("");

    var postUrl = dataEntryInquiryGridUrl;

    $("#grid_list_dataentry_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}

function initDataEntryInquiry(){
	

	setupDataEntryInquiryGrid();

    $("#dataEntryInquirySearch").click(searchDataEntry);
    $("#dataEntryInquiryReset").click(resetDataEntry);

    $("#product").change(setProduct);
    $("#documentType").change(setProductScope);
    $("#productType").change(setProductType);
    $("#transactionType").change(changeTransactionTypeProduct);
    
    $("#documentType").empty();
    $('#documentType').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
}

function onViewDataEntryClick(id) {
    var grid = $("#grid_list_dataentry_inquiry");

    var data = grid.jqGrid('getRowData',id);

    var gotoUrl = viewDataEntryUrl;
    gotoUrl += "?serviceType="+data.serviceType;
    gotoUrl += "&documentClass="+data.documentClass;
    gotoUrl += "&documentType="+data.documentType;
    gotoUrl += "&documentSubType1="+data.documentSubType1;
    gotoUrl += "&documentSubType2="+data.documentSubType2;
    gotoUrl += "&tradeServiceId="+id;
    gotoUrl += "&viewMode=viewMode";
    gotoUrl += "&hasRoute=false";
    
    location.href = gotoUrl;
}

function setProductType(){
	var product = $("#product").val();
    var scope = $("#documentType").val();
    var options = $("#productType").val();
    var transactions = $("#transactionType").val();
    
    switch(options){
	
		case "CASH":
		case "REGULAR":
		case "STANDBY":
			transactions = {
		        ADJUSTMENT : "ADJUSTMENT",
		        AMENDMENT : "AMENDMENT",
		        CANCELLATION_LC : "CANCELLATION",
		        NEGOTIATION : "NEGOTIATION",
		        NEGOTIATION_DISCREPANCY : "NEGOTIATION DISCREPANCY",
		        OPENING : "OPENING",
		        UA_LOAN_MATURITY_ADJUSTMENT : "UA LOAN MATURITY ADJUSTMENT",
		        UA_LOAN_SETTLEMENT : "UA LOAN SETTLEMENT"
		    }
			
			break;
    	case "DA":
    		transactions = {
                NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
                NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
                SETTLEMENT: "SETTLEMENT",
                CANCELLATION: "CANCELLATION"
            }
    		break;
    	case "DP":
    		if(scope == "DOMESTIC"){
    			transactions = {
    	                NEGOTIATION: "NEGOTIATION",
    	                SETTLEMENT: "SETTLEMENT"
    	    		}
    		}else{
    			transactions = {
    	                NEGOTIATION: "NEGOTIATION",
    	                SETTLEMENT: "SETTLEMENT",
    	                CANCELLATION: "CANCELLATION"
    	    		}
    		}
    		break;
    	case "DR":
    	case "OA":
    		transactions = {
                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT",
                CANCELLATION: "CANCELLATION"
    		}
    		break;
    	case "BP":
    		transactions = {
                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT"
    		}
    		break;
    	case "BC":
    		transactions = {
                NEGOTIATION: "NEGOTIATION",
                SETTLEMENT: "SETTLEMENT",
                CANCELLATION: "CANCELLATION"
    		}
			
			break;
    		
    	case "FIRST_ADVISING":
		case "SECOND_ADVISING":
			transactions = {
		        AMENDMENT_ADVISING : "AMENDMENT",
		        CANCELLATION_ADVISING : "CANCELLATION",
		        OPENING_ADVISING : "OPENING"
		    }
    	break;
			
    	default:
    			transactions = {}		
    		break;
    }
    

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

function setProductScope(){
	var product = $("#product").val();
    var scope = $("#documentType").val();
    var options = $("#productType").val();
    var transactions = $("#transactionType").val();
    	
    switch(scope){
	    case "FOREIGN" :
	    	if (product == "LC"){
	            options = {
	                    CASH : "CASH",
	                    REGULAR: "REGULAR",
	                    STANDBY: "STANDBY"
	                }
	    		transactions = {};
	    	}else if(product == "NON-LC"){
	    		options = {
	                    DA : "DOCUMENTS AGAINST ACCEPTANCE",
	                    DP : "DOCUMENTS AGAINST PAYMENT",
	                    DR : "DIRECT REMITTANCE",
	                    OA : "OPEN ACCOUNT SETTLEMENT"		
	    		}
	    	}else{
	            options = {
	                    BP : "BILLS PURCHASED",
	                    BC : "BILLS FOR COLLECTION"
	                }
	    	}
	    	break;
	    case "DOMESTIC" :
	    	if (product == "LC"){
	            options = {
	                    CASH : "CASH",
	                    REGULAR: "REGULAR",
	                    STANDBY: "STANDBY"
	                }
	    	}else if(product == "NON-LC"){
	    		options = {
	                    DP : "DOCUMENTS AGAINST PAYMENT",
	    		}
	    	}else{
	            options = {
	                    BP : "BILLS PURCHASED",
	                    BC : "BILLS FOR COLLECTION"
	                }
	    	}
	    	break;
	    default:
	    	options = {};
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

function setProduct(){
    var product = $("#product").val();
    var scope = $("#documentType").val();
    var options = $("#productType").val();
    var transactions = $("#transactionType").val();
	switch(product){
		case "LC":
		case "NON-LC":
		case "EXPORT_BILLS":
			scope = {
				DOMESTIC : "DOMESTIC",
        		FOREIGN : "FOREIGN"
        			};
			options = {};
			transactions = {};
			break;
		case "AUXILIARY_IMPORT_PRODUCTS":
			scope = {};
			options = {};
			transactions = {
					AP: "AP MONITORING REFUND",
					SETTLE: "AR MONITORING SETTLEMENT",
					SETUP: "AR MONITORING SETUP",
					SETTLEMENT: "SETTLEMENT OF ACTUAL CORRES CHARGES",
					REBATE: "REBATES",
					PAYMENT: "PAYMENT OF OTHER IMPORT CHARGES",
					COLLECTION: "MD COLLECTION",
					CDT: "CDT",
					MDR: "MD REFUND",
					REFUND: "REFUND OF OTHER IMPORT CHARGES"
			};
			break;
			
		case "AUXILIARY_EXPORT_PRODUCTS":
			scope = {};
			options = {};
			transactions = {
					REFUNDEX: "REFUND OF OTHER EXPORT CHARGES",
					PAYMENTEX: "PAYMENT OF OTHER EXPORT CHARGES"
			};
			break;
			
		case "INDEMNITY":
			scope = {};
			options = {};
			transactions = {
					ISSUANCE: "INDEMNITY ISSUANCE",
					CANCELLATION: "INDEMNITY CANCELLATION"
			};
			break;
		case "IMPORT_ADVANCE":
		case "EXPORT_ADVANCE":
			scope = {};
			options = {};
			transactions = {
					PAYMENT: "PAYMENT",
					REFUND: "REFUND"
			};
			break;
		case "EXPORT_ADVISING":
			scope = {};
			options = {
					FIRST_ADVISING: "FIRST ADVISING",
					SECOND_ADVISING: "SECOND ADVISING"
			}
			break;
			
		default :
			scope = {};
			options = {};
			transactions = {};
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
    
    // document type
    $("#documentType").empty();
    $('#documentType').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
    $.each(scope, function(val, text) {
        $('#documentType').append(
            $('<option></option>').val(val).html(text)
        );
    });
}


//function setupProductTypeProduct(){
//    var options;
//    var transactions = {
//        ADJUSTMENT : "ADJUSTMENT",
//        AMENDMENT : "AMENDMENT",
//        CANCELLATION_LC : "CANCELLATION",
//        NEGOTIATION : "NEGOTIATION",
//        NEGOTIATION_DISCREPANCY : "NEGOTIATION DISCREPANCY",
//        OPENING : "OPENING",
//        UA_LOAN_MATURITY_ADJUSTMENT : "UA LOAN MATURITY ADJUSTMENT",
//        UA_LOAN_SETTLEMENT : "UA LOAN SETTLEMENT"
//    }
//
//    var product = $("#product").val();
//    var scope = $("#documentType").val();
//    
//    switch (product) {
//        case "LC":
//        case "INDEMNITY":
//            options = {
//                CASH : "CASH",
//                REGULAR: "REGULAR",
//                STANDBY: "STANDBY"
//            }
//            
//            scope = {
//        		DOMESTIC : "DOMESTIC",
//        		FOREIGN : "FOREIGN"
//        			
//        	}
//            if ($("#documentClass").val() == "INDEMNITY") {
//                transactions = {
//                    ISSUANCE : "INDEMNITY ISSUANCE",
//                    CANCELLATION : "INDEMNITY CANCELLATION"
//                }
//            }
//            break;
//            
//        case "NON-LC":
//        	alert("NONLC")
//        	scope = {
//        		DOMESTIC : "DOMESTIC",
//        		FOREIGN : "FOREIGN"
//        			
//        	}
//
//        	
//            if ($("#documentType").val() == "DOMESTIC") {
//                options = {
//                    DP : "DOCUMENTS AGAINST PAYMENT"
//                }
//               
//            } else {
//                options = {
//                    DA : "DOCUMENTS AGAINST ACCEPTANCE",
//                    DP : "DOCUMENTS AGAINST PAYMENT",
//                    DR : "DIRECT REMITTANCE",
//                    OA : "OPEN ACCOUNT SETTLEMENT"
//                }
//                if ($("#documentClass").val() == "DA") {
//                    transactions = {
//                        NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
//                        NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
//                        SETTLEMENT: "SETTLEMENT",
//                        CANCELLATION: "CANCELLATION"
//                    }
//                } else if ($("#documentClass").val() == "DP" ||
//                    $("#documentClass").val() == "DR" ||
//                    $("#documentClass").val() == "OA") {
//                    transactions = {
//                        NEGOTIATION: "NEGOTIATION",
//                        SETTLEMENT: "SETTLEMENT",
//                        CANCELLATION: "CANCELLATION"
//                    }
//                } else {
//                    transactions = {
//                        NEGOTIATION: "NEGOTIATION",
//                        NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
//                        NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
//                        SETTLEMENT: "SETTLEMENT",
//                        CANCELLATION: "CANCELLATION"
//                    }
//                }
//            }
//            break;
//            
//        case "IMPORT_ADVANCE":
//        	
//        	options = {}
//        	scope = {}
//        	transactions = {
//        		PAYMENT : "PAYMENT",
//        	    REFUND : "REFUND"
//        	}
//
//        	break;
//        	
//        case "EXPORT_ADVANCE":
//        	scope={}
//        	options={}
//        	transactions={
//        			PAYMENT : "PAYMENT",
//        	        REFUND : "REFUND"
//            	}
//            break;
//            
//        case "EXPORT_BILLS":
//        	scope = {
//        			DOMESTIC: "DOMESTIC",
//        			FOREIGN: "FOREIGN"
//        	}
//            options = {
//                BP : "BILLS PURCHASED",
//                BC : "BILLS FOR COLLECTION"
//            }
//            break;
//            
//        case "AUXILIARY_IMPORT_PRODUCTS":
//        	scope = {}
//            options = {
//                MD : "MD COLLECTION / APPLICATION",
//                AR : "AR",
//                AP : "AP",
//                IMPORT_ADVANCE : "IMPORT ADVANCE / REFUND",
//                IMPORT_CHARGES : "PAYMENT OF OTHER IMPORT CHARGES",
//                CORRES_CHARGE : "SETTLEMENT OF ACTUAL CORRES CHARGES",
//                REBATE : "REBATES"
//            }
//            transactions = {}
//            break;
//            
//        case "EXPORT_ADVISING":
//        	scope={}
//        	options={
//        		FIRST_ADVISING:"FIRST ADVISING",
//        		SECOND_ADVISING:"SECOND ADVISING"
//        	}
//        	transactions={
//        		OPENING: "OPENING",
//        		AMENDMENT: "AMENDMENT",
//        		CANCELLATION: "CANCELLATION"
//        	}
//        	break;
//    }
//    // product type
//    $("#productType").empty();
//    $('#productType').append(
//        $('<option></option>').val("").html("SELECT ONE...")
//    );
//    $.each(options, function(val, text) {
//        $('#productType').append(
//            $('<option></option>').val(val).html(text)
//        );
//    });
//
//    // transaction type
//    $("#transactionType").empty();
//    $('#transactionType').append(
//        $('<option></option>').val("").html("SELECT ONE...")
//    );
//    $.each(transactions, function(val, text) {
//        $('#transactionType').append(
//            $('<option></option>').val(val).html(text)
//        );
//    });
//    
//    // document type
////    $("#documentType").empty();
////    $('#documentType').append(
////        $('<option></option>').val("").html("SELECT ONE...")
////    );
////    $.each(scope, function(val, text) {
////        $('#documentType').append(
////            $('<option></option>').val(val).html(text)
////        );
////    });
//}

//function changeProductTypeProduct() {
//    switch (this.value) {
//        case "CASH":
//        case "REGULAR":
//        case "STANDBY":
//            $("#documentSubType1").val(this.value);
//            break;
//        case "DA":
//            $("#documentClass").val("DA");
//            //$("#documentSubType1").val("SETTLEMENT");
//            var transactions = {
//                NEGOTIATION_ACCEPTANCE: "NEGOTIATION ACCEPTANCE",
//                NEGOTIATION_ACKNOWLEDGEMENT: "NEGOTIATION ACKNOWLEDGEMENT",
//                SETTLEMENT: "SETTLEMENT",
//                CANCELLATION: "CANCELLATION"
//            }
//            $("#transactionType").empty();
//            $('#transactionType').append(
//                $('<option></option>').val("").html("SELECT ONE...")
//            );
//            $.each(transactions, function(val, text) {
//                $('#transactionType').append(
//                    $('<option></option>').val(val).html(text)
//                );
//            });
//            break;
//        case "DP":
//            $("#documentClass").val("DP");
//            //$("#documentSubType1").val("SETTLEMENT");
//            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
//                SETTLEMENT: "SETTLEMENT",
//                CANCELLATION: "CANCELLATION"
//            }
//            $("#transactionType").empty();
//            $('#transactionType').append(
//                $('<option></option>').val("").html("SELECT ONE...")
//            );
//            $.each(transactions, function(val, text) {
//                $('#transactionType').append(
//                    $('<option></option>').val(val).html(text)
//                );
//            });
//            break;
//        case "DR":
//            $("#documentClass").val("DR");
//            //$("#documentSubType1").val("SETTLEMENT");
//            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
//                SETTLEMENT: "SETTLEMENT",
//                CANCELLATION: "CANCELLATION"
//            }
//            $("#transactionType").empty();
//            $('#transactionType').append(
//                $('<option></option>').val("").html("SELECT ONE...")
//            );
//            $.each(transactions, function(val, text) {
//                $('#transactionType').append(
//                    $('<option></option>').val(val).html(text)
//                );
//            });
//            break;
//        case "OA":
//            $("#documentClass").val("OA");
//            //$("#documentSubType1").val("SETTLEMENT");
//            var transactions = {
//                NEGOTIATION: "NEGOTIATION",
//                SETTLEMENT: "SETTLEMENT",
//                CANCELLATION: "CANCELLATION"
//            }
//            $("#transactionType").empty();
//            $('#transactionType').append(
//                $('<option></option>').val("").html("SELECT ONE...")
//            );
//            $.each(transactions, function(val, text) {
//                $('#transactionType').append(
//                    $('<option></option>').val(val).html(text)
//                );
//            });
//            break;
//        case "MDC":
//            $("#documentClass").val("MD");
//            $("#documentSubType1").val("COLLECTION");
//            break;
//        case "MDA":
//            $("#documentClass").val("MD");
//            $("#documentSubType1").val("APPLICATION");
//            break;
//        case "ARS":
//            $("#documentClass").val("AR");
//            $("#documentSubType1").val("SETTLE");
//            break;
//        case "APR":
//            $("#documentClass").val("AP");
//            $("#documentSubType1").val("REFUND");
//            break;
//        case "BP":
//        	$("#documentClass").val("BP");
//        	
//            var transactions = {
//                    NEGOTIATION: "NEGOTIATION",
//                    SETTLEMENT: "SETTLEMENT"
//                }
//                $("#transactionType").empty();
//                $('#transactionType').append(
//                    $('<option></option>').val("").html("SELECT ONE...")
//                );
//                $.each(transactions, function(val, text) {
//                    $('#transactionType').append(
//                        $('<option></option>').val(val).html(text)
//                    );
//                });
//        	break;
//        case "BC":
//        	$("#documentClass").val("BC");
//        	var transactions;
//        	if("FOREIGN" == $("#documentType").val()){
//        		transactions = {
//        				NEGOTIATION: "NEGOTIATION",
//        				SETTLEMENT: "SETTLEMENT",
//        				CANCELLATION: "CANCELLATION"
//        		};
//        	}else{
//        		transactions = {
//        				NEGOTIATION: "NEGOTIATION",
//        				SETTLEMENT: "SETTLEMENT"
//        		};
//        	}
//            $("#transactionType").empty();
//            $('#transactionType').append(
//                $('<option></option>').val("").html("SELECT ONE...")
//            );
//            $.each(transactions, function(val, text) {
//                $('#transactionType').append(
//                    $('<option></option>').val(val).html(text)
//                );
//            });
//        	break;
//        case "IP":
//        case "IR":
//        case "PC":
//        case "CORRES":
//            $("#documentClass").val("");
//            $("#documentSubType1").val("");
//            break;
//        case "FIRST_ADVISING":
//        	$("#documentSubType1").val("FIRST_ADVISING");
//        	break;
//        case "SECOND_ADVISING":
//        	$("#documentSubType1").val("SECOND_ADVISING");
//        	break;
//    }
//    
//}

function changeTransactionTypeProduct() {
//    $("#serviceType").val(this.value);
//
//    if (this.value == "CANCELLATION_LC") {
//        $("#serviceType").val("CANCELLATION");
//    }
}