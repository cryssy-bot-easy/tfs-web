function setupFacilityGrid(id, userParams, colModel, grid_pager_id,
                                    urlView) {
    var params = {
        url : urlView,
        datatype : "json",
        altRows : true,
        rowNum : 10,
        rowList : [ 10, 20, 30 ],
        pager : jQuery('#' + grid_pager_id),
        viewrecords : true,
        sortname : 'id',
        sortorder : "desc",
        width : 800,
        height : 250
    };

    if (userParams)
        $.extend(params, userParams);
    if (colModel) {
        var _colModel = [];
        for ( var i = 0; i < colModel.length; i++) {
            var col = colModel[i];

            try {
                _colModel.push({
                    name : col[0],
                    index : col[0],
                    label : col[1],
                    align : col[2],
                    hidden : col[3],
                    width : col[4]
                });
            } catch (e) {
                try {
                    _colModel.push({
                        name : col[0],
                        index : col[0],
                        label : col[1],
                        align : col[2],
                        hidden : col[3]
                    });
                } catch (e2) {
                    try {
                        _colModel.push({
                            name : col[0],
                            index : col[0],
                            label : col[1],
                            width : col[2]
                        });
                    } catch (e3) {
                        _colModel.push({
                            name : col[0],
                            index : col[0],
                            label : col[1]
                        });
                    }
                }
            }
        }
        params.colModel = _colModel;
    }
    return jQuery('#' + id).jqGrid(params);
}



function setupFacilityIdGrids(){
//	var pageUrl = ""

//    if($("#cifNumber").val() != "") {
//        pageUrl = facilitySearchUrl;
//        pageUrl += "?cifNumber="+$("#cifNumber").val().replace(/,/g,"");
//    }
    var pageUrl = facilitySearchUrl;
    if(typeof $("#mainCifNumberTo").val() != 'undefined'){
        if ($("#mainCifNumberTo").length > 0 && $("#mainCifNumberTo").val()) {
            if (serviceType.toUpperCase() == "ADJUSTMENT") {
                if($("#mainCifNumberTo").val() != "") {        	
                   	 if($("#documentSubType1").val()!="CASH"){
        		     pageUrl += "?cifNumber="+$("#mainCifNumberTo").val().replace(/,/g,"");
                  	 }
                }
	        }
	
	        if ($("#mainCifNumberFrom").length > 0 && $("#mainCifNumberFrom").val() != "") {
		            pageUrl += "?cifNumber="+$("#mainCifNumberFrom").val().replace(/,/g,"");
	        }
	
	        if ($("#cifNumberTo").length > 0 && $("#cifNumberTo").val() != "") {
		            pageUrl += "?cifNumber="+$("#cifNumberTo").val().replace(/,/g,"");
	        }
	
	        if ($("#cifNumberFrom").length > 0 && $("#cifNumberFrom").val() != "") {
		            pageUrl += "?cifNumber="+$("#cifNumberFrom").val().replace(/,/g,"");
            }
	
	//        if($("#mainCifNumberTo").val() != "") {
	//            pageUrl += "?cifNumber="+$("#mainCifNumberTo").val().replace(/,/g,"");
	//        } else if ($("#mainCifNumberFrom").val() != ""){
	//            pageUrl += "?cifNumber="+$("#mainCifNumberFrom").val().replace(/,/g,"");
	//        } else if ($("#cifNumberTo").val() != "") {
	//            pageUrl += "?cifNumber="+$("#cifNumberTo").val().replace(/,/g,"");
	//        } else {
	//            pageUrl += "?cifNumber="+$("#cifNumberFrom").val().replace(/,/g,"");
	//        }
	    } else {
	        if($("#mainCifNumber").length > 0) {
	            pageUrl += "?cifNumber="+$("#mainCifNumber").val().replace(/,/g,"");
	        } else {
	            pageUrl += "?cifNumber="+$("#cifNumber").val().replace(/,/g,"");
	        }
	    }
    }

    setupFacilityGrid('grid_list_facility_type', {width: 518, loadui: "disable", scrollOffset:0},
//   setupJqGridPagerWithHidden('grid_list_facility_type', {width: 518, loadui: "disable", scrollOffset:0},
			[['facityID', 'Facility ID'],
			['expiryDate', 'Expiry Dates'],
			['currency', 'Currency'],
            ['facilityType','Facility Type'],
            ['facilityReferenceNumber', 'Facility Reference Number'],
            ['balanceQueryId','Balance Query Id','center','hidden']], 'grid_pager_facility_type', pageUrl);
    
}

function validateFacilityExpiryDate(facilityExpiryDate) {
    var expiryDate = parseFacilityDate(facilityExpiryDate);

    $.post(getCurrentSystemDateUrl, {}, function(data) {
        var currentDate = new Date(data.currentSystemDate);

        if (expiryDate < currentDate) {
            return "failed";
        } else {
            return "success";
        }
    });
}

function triggerFacilityExpired() {
    $("#alertMessage").text("Facility is already expired. Please select another Facility.");
    triggerAlert();
    return true;
}

function onSelectFacility() {
    var id = $("#grid_list_facility_type").jqGrid("getGridParam", "selrow");

    var data = $("#grid_list_facility_type").jqGrid("getRowData", id);
    
    //check if facility id is expired
//    var tmp=data.expiryDate.split("/");

//    if(new Date(tmp[0]+"/"+tmp[1]+"/20"+tmp[2]) <= new Date(data.currentSystemDate)){
//        //alert("Facility ID has expired.");
//        triggerAlertMessage("Facility ID has expired.");
//        return;
//    }
    
    //var validFacilityExpiryDate = validateFacilityExpiryDate(data.expiryDate);

    var expiryDate = parseFacilityDate(data.expiryDate);
//    var facilityType = data.facilityType;

    $.post(getCurrentSystemDateUrl, {}, function(data2) {
        var currentDate = new Date(data2.currentSystemDate);

        if (expiryDate < currentDate) {
            //return "failed";
            triggerFacilityExpired();
        } else {
            //return "success";
            if(id != null) {
                if($("#facilityReferenceNumberTo").length > 0) {
                    $("#facilityReferenceNumberTo").val(data.facilityReferenceNumber);
                }else {
                    $("#facilityReferenceNumber").val(data.facilityReferenceNumber);
                }


                var facilityId = $("#grid_list_facility_type").jqGrid("getRowData", id).facityID;

                if($("#facilityIdTo").length > 0) {
//                    $("#facilityIdTo").val(id);

                    $("#facilityIdTo").val(facilityId);
                    $("#facilityTypeTo").val($("#grid_list_facility_type").jqGrid("getRowData",id).facilityType);
                } else {
//            		$(".facilityId.loanField").val(id);
                    $(".facilityId.loanField").val(facilityId);
//            		$("#facilityId").val(id);
                    $("#facilityId").val(facilityId);
                    $("#facilityType").val(data.facilityType);
                }

                if($("#negotiationFacilityId").length > 0) {
//                    $("#negotiationFacilityId").val(id);
                    $("#negotiationFacilityId").val(facilityId);
                }

                if($("#facilityBalance").length > 0) {
                    $("#facilityBalance").val(data.balance);
                }
                mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
//        disablePopup(activePopupDiv, activePopupBg);

            } else {
                $("#alertMessage").text("Please select a facility.");

                triggerAlert();
            }
        }
    });

//    if (validFacilityExpiryDate == "success") {
//    	if(id != null) {
//    		if($("#facilityReferenceNumberTo").length > 0) {
//    			$("#facilityReferenceNumberTo").val(data.facilityReferenceNumber);
//    		}else {
//    			$("#facilityReferenceNumber").val(data.facilityReferenceNumber);
//    		}
//
//
//
//    		if($("#facilityIdTo").length > 0) {
//    			$("#facilityIdTo").val(id);
//    			$("#facilityTypeTo").val($("#grid_list_facility_type").jqGrid("getRowData",id).facilityType);
//    		} else {
//    			$("#facilityId").val(id);
//    			$("#facilityType").val(data.facilityType);
//    		}
//
//    		if($("#negotiationFacilityId").length > 0) {
//    			$("#negotiationFacilityId").val(id);
//    		}
//
//    		if($("#facilityBalance").length > 0) {
//    			$("#facilityBalance").val(data.balance);
//    		}
//    		mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
////        disablePopup(activePopupDiv, activePopupBg);
//
//    		if($("#transactionSequenceNumber").length > 0){
//    			$.post(requestFacilityBalanceUrl, {
//    				facilityId : id,
//    				facilityType : data.facilityType,
//    				cifNumber : ($("#mainCifNumberTo").length > 0 && $("#mainCifNumberTo").val() != "") ? $("#mainCifNumberTo").val() : ($("#mainCifNumberFrom").length > 0) ? $("#mainCifNumberFrom").val() : $("#mainCifNumber").val()
//    			}, function(data) {
//    				if(data.status == 'success'){
//    					$("#transactionSequenceNumber").val(data.transactionSequenceNumber);
//    				}
//    			});
//    		}
//    	} else {
//    		$("#alertMessage").text("Please select a facility.");
//
//    		triggerAlert();
//    	}
//    } else {
//    	triggerFacilityExpired();
//    }
}

function _closeFacilityLookup(){
	mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
}

function checkFacilityBalance(){
    var id = $("#grid_list_facility_type").jqGrid('getGridParam','selrow');
    var selectedRow = $("#grid_list_facility_type").jqGrid('getRowData',id);
    var params = {
        balanceQueryRequestId : selectedRow.balanceQueryId
    }
    $.post(getFacilityBalance, params, function(data) {
        if(data.REQUEST_STATUS == 'Y'){
            $('#facilityBalance').val(data.FACILITY_BALANCE);
        }else if(data.REQUEST_STATUS == ' '){
            triggerAlertMessage('No Response from SIBS.');
        }else if(data.REQUESTATUS == 'N'){
            triggerAlertMessage('Transaction has been rejected');
        }
    });
}

function parseFacilityDate(input) {
	var parts = input.match(/(\d+)/g);
	// new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
	return new Date(parts[2], parts[0]-1, parts[1], 23, 59, 59); // months are 0-based
}

function init(){
    setupFacilityIdGrids();
    $(".facility_search_close").click(_closeFacilityLookup);
    $("#selectFacility").click(onSelectFacility);
    $("#checkBalance").click(checkFacilityBalance);
}

$(init);