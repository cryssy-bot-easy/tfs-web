$(document).ready(function(){
	$("#saveOutgoingMt").on("click",function(e){
		
		//all outgoing MT has this validation function on each basic details utility
		//return if MT has errors
		if(validateOutgoingMt()){
			return;
		}else {
			//load loading gif, to prevent successive clicking of save button
			mCenterPopup($("#loading_div"), $("#loading_bg"));
		    mLoadPopup($("#loading_div"), $("#loading_bg"));
		}
		
		$("form#basicDetailsTabForm").submit();
//		mCenterPopup($("#mtPopup"), $("#alert_confirmation_bg"));
//		mLoadPopup($("#mtPopup"), $("#alert_confirmation_bg"));
	});
	
	$("#mtCancel").on("click",function(e){
		mDisablePopup($("#mtPopup"), $("#alert_confirmation_bg"));
	});
	
	$("#mtConfirm").on("click",function(e){
		$("form#basicDetailsTabForm").submit();
	});
	
	$("#cancelOutgoingMtPopup").on("click",function(e){
	    var cancel_div = $("#popup_save_confirmation");
	    var cancel_bg = $("#confirmation_background");
	    
	    mCenterPopup(cancel_div, cancel_bg);
	    mLoadPopup(cancel_div, cancel_bg);
	    $("#btnAlertNo").focus();
	});

    $(".openSaveConfirmation").click(function() {
        var mSave_div = $("#popup_save_confirmation");
        var mBg = $("#confirmation_background");

        mLoadPopup(mSave_div, mBg);
        mCenterPopup(mSave_div, mBg);
    });

	$("#btnAlertConfirm").click(function(){
		switch(formId){
			case "#basicDetailsTabForm":
				if('undefined' !== typeof acc_userRole && acc_userRole.indexOf("TSD") != -1){
					location.href=unactedTransactionsUrlTsd + "?tsdLabelText=Auxiliary Products&tsdTableId=grid_list_auxiliary_import_unacted_main";
				}else{
					location.href=unactedTransactionsUrlBranch;
				}				
				break;
			case "#instructionsAndRoutingTabForm":
				mDisablePopup($("#popup_save_confirmation"), $("#confirmation_background"));
				mCenterPopup($("#loading_div"), $("#loading_bg"));
				mLoadPopup($("#loading_div"), $("#loading_bg"));
                if (activePopupDiv) {
                    var postUrl = "";

                    if('editInstructions' == $("#instructionAction").val()) {
                        postUrl = updateRemarksUrl
                    }else{
                        postUrl = addRemarksUrl
                    }

                    postUrl + "?referenceType=OUTGOING_MT";
                    var params = {
                        referenceType : "OUTGOING_MT",
                        serviceType: "CREATE",
                        tradeServiceId: $("#outgoingTradeServiceId").val(),
                        form: "instructionsAndRouting",
                        comment: $("#addInstruction").val(),
                        cifNumber: $("#cifNumber").val(),
                        statusAction: $("#statusAction").val(),
                        message: $("#message").val().toUpperCase(),
                        id : rowId
                    }

                    disablePopup(activePopupDiv, activePopupBg);

                    $.post(postUrl, params, function(data) {
                        var mSave_div = $("#popup_save_confirmation");
                        var mBg = $("#confirmation_background");

                        mDisablePopup(mSave_div, mBg);

                        var gridRemarksUrl = getRemarks;

                        gridRemarksUrl += "?referenceType=OUTGOING_MT";

                        $("#instructionAction").val("");
                        $('#grid_list_instructions_routing_remarks').jqGrid('setGridParam', {url: gridRemarksUrl, page: 1}).trigger("reloadGrid");
                    });
                } else {
                    var i_userRole=$('<input/>',{type:'hidden',name:'userRole',id:'userRole',value:acc_userRole});
                    var i_labelText=$('<input/>',{type:'hidden',name:'tsdLabelText',id:'tsdLabelText',value:'Auxiliary Products'});
                    var i_tableId=$('<input/>',{type:'hidden',name:'tsdTableId',id:'tsdTableId',value:'grid_list_auxiliary_import_unacted_main'});

                    $("#instructionsAndRoutingTabForm").append(i_userRole);
                    $("#instructionsAndRoutingTabForm").append(i_labelText);
                    $("#instructionsAndRoutingTabForm").append(i_tableId);
                    $("#instructionsAndRoutingTabForm").submit();
                }
				break;
		}
	});
	
	$("#btnAlertNo").click(function(){
		mDisablePopup($("#popup_save_confirmation"), $("#confirmation_background"));
	});
	
	$("#btnAlertOk").click(function(){
		mDisablePopup($("#popup_alert_dv"),$("#popup_alert_bg"));
	});
	
	//initialize form id
	if($("#basicDetailsTabForm").length > 0){
		$("#basicDetailsTab").click(function(){
			formId="#basicDetailsTabForm";
		});
	}
	if($("#instructionsAndRoutingTabForm").length > 0){
		$("#instructionsTab").click(function(){
			formId="#instructionsAndRoutingTabForm";
		});
	}
});


function viewOutgoingMt(messageType){
	var url=generateOutgoingMtUrl;
	url+="?messageType=" + messageType;
	url+="&newWindow=true";
	url+="&outgoingTradeServiceId="+$("#outgoingTradeServiceId").val();
	window.open(url, "_blank", "scrollbars=yes, status=yes, width=550, height=350");
}

function triggerAlertMessage(alertMessage) {
    var mSave_div = $("#popup_alert_dv");
    var mBg = $("#popup_alert_bg");
    $("#alertMessage").html(alertMessage);
    
    mCenterPopup(mSave_div, mBg);
    mLoadPopup(mSave_div, mBg);
    $("#btnAlertOk").focus();
}
