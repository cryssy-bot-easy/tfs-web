<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: 
		1. Batch - Error in Executing Allocation File (Redmine# 4183)
		2. Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 03/13/2017 (tfs-web Rev# 7433)
		2. 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Updated the validation for required field.
		2. Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _instructions_and_routing_tab.gsp
--%>

<g:javascript src="popups/add_instruction_popup.js" />
<g:javascript src="popups/alert_utility.js" />
<script type="text/javascript">
    var retrieveChargesOverridenFlag = '${g.createLink(controller:'instructionsAndRouting', action:'getChargesOverridenFlag')}';

    <%--Used by instructions_routing_jqgrid.js--%>
    var getRemarks = '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
    <%--Variable for hovered item in remarks grid--%>
    var saveUrl = "XXX";
    var updateUrl = "XXX";
    var updateStatusUrl = '${g.createLink(controller:'product', action:'dummyUpdate')}';
    var rowId='';
    var inquireFacilityBalance = '${g.createLink(controller: 'facility', action: 'inquireFacilityBalance')}';
    var getFacilityBalanceResult = '${g.createLink(controller: 'facility', action: 'getFacilityBalanceRequest')}'

    var getCurrentSystemDateUrl = '${g.createLink(controller:'facility', action:'getCurrentDate')}';

    var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';

    var checkPaymentStatusOfPaymentsUrl = '${g.createLink(controller: "chargesPayment", action: "checkPaymentStatusOfPayments")}';
    var checkUnpaidPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'checkUnpaidPayments')}';
    
    var _validateSavedChargesPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedChargesPayments')}';
    var validateSavedChargesPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedChargesPayments2')}';

    var validateCutOffTimeUrl = '${g.createLink(controller: 'instructionsAndRouting', action: 'validateCutOffTime')}';

    
</script>

<g:javascript src="grids/instructions_routing_jqgrid.js" />
<g:if test="${!windowed}">
    <g:javascript src="utilities/ets/commons/instructions_and_routing_tab_utility.js" />
</g:if>


<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="instructionsAndRouting" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="documentNumber" value="${documentNumber}" />
<g:hiddenField name="allTabSaved" value="${allTabSaved ?: "Y"}" />

<ul class="buttons">
    <li><a href="javascript:void(0)" id="add_instruction"> </a></li>
    <li>Add</li>
</ul>
<br />

<span class="title_label"> Instructions/Remarks </span>
<div class="grid_wrapper" id="grid_list_instructions_routing_remarks_div">
    %{--JQGRID--}%
    <table id="grid_list_instructions_routing_remarks">
    </table>
    <div id="grid_pager_instructions_routing_remarks"></div>
</div>
<br />
<br />

<g:hiddenField name="statusAction" value="" />
<br />

<g:if test="${session['userrole']['id']?.equalsIgnoreCase("BRM") || ((session['userrole']['id']?.equalsIgnoreCase("TSDM")) && (request.forwardURI.find("/ets/") == null)) || (session['userrole']['id']?.equalsIgnoreCase("TSDO") && session.dataEntryModel?.status?.equalsIgnoreCase("PENDING"))}">
    <table id="makerButton">
        <tr>
            <td><span class="field_label"> Route To </span></td>
            <td>
                <g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown not" />
            </td>
            <%-- <td><input type="button" class="input_button_negative button_override openConfirmRoute etsButtons" value="Abort" id="btnAbort" /></td> --%>

            <td>
                <g:if test="${session.dataEntryModel?.tsdInitiated != "true"}" >
                    <input type="button" class="input_button_negative button_override openConfirmRoute2 etsButtons" value="Abort" id="btnAbort" />
                </g:if>
                <g:else>
                    <input type="button" class="input_button_negative button_override abort dataEntryButtons" value="Abort" id="btnAbort" />
                </g:else>
            </td>
            <td>
                <g:if test="${session.dataEntryModel?.tsdInitiated != "true" && session.model?.tsdInitiated != "true" && session['userrole']['id']?.equalsIgnoreCase("TSDM")}" >
                    <input type="button" class="input_button_negative3 button_override returnTransaction dataEntryButtons" value="Return eTS to Branch" id="btnReturnEtsToBranch" />
                </g:if>
                    <input type="button" class="input_button_negative2 button_override openConfirmRoute dataEntryButtons" value="Disapprove" id="btnDisapprove" />
                
            </td>
            <td><g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
            %{--checks if service type is cancellation--}%
                <g:if test="${!(serviceType?.equalsIgnoreCase("CANCELLATION"))}">
                %{--checks if payment status is paid if service type is not cancellation--}%
                %{--enables prepare button if payment status is paid--}%
                <%--                    <g:if test="${paymentStatus?.equalsIgnoreCase("PAID") || paymentStatus?.equalsIgnoreCase("NO_PAYMENT_REQUIRED") || !(documentClass?.equalsIgnoreCase("LC") || documentClass?.equalsIgnoreCase("INDEMNITY")) }">--%>
                <g:if test="${'EXPORT_ADVISING'.equalsIgnoreCase(documentClass)}">
                    <g:if test="${approvedOnce}">
                        <g:if test="${'PAID'.equalsIgnoreCase(paymentStatus)}">
                            <input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="a" />
                        </g:if>
                        <g:else>
                            <input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="b"/>
                        </g:else>
                    </g:if>
                    <g:elseif test="${(serviceType?.equalsIgnoreCase('OPENING_ADVISING') && documentSubType1?.equalsIgnoreCase('FIRST_ADVISING')) ||
						(serviceType?.equalsIgnoreCase('CANCELLATION_ADVISING') && documentSubType1?.equalsIgnoreCase('FIRST_ADVISING')) || 
						serviceType?.equalsIgnoreCase('AMENDMENT_ADVISING') }">
                        <input type="button" class="input_button2 button_override checkMtAndRequired" value="Prepare" id="btnPrepare" prepareType="c" />
                    </g:elseif>
                    <g:else>
                        <input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="d" />
                    </g:else>
                </g:if>
                <g:elseif test="${documentClass?.equalsIgnoreCase('CORRES_CHARGE') && serviceType.equalsIgnoreCase('SETTLEMENT') && withoutReference == true}">
					<input type="button" class="input_button2 button_override route openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="i" />
                </g:elseif>
                <g:elseif test="${documentClass?.equalsIgnoreCase('CDT') && serviceType.equalsIgnoreCase('REMITTANCE')}">
                    <g:if test="${'PAID'.equalsIgnoreCase(paymentStatus) || 'NO_PAYMENT_REQUIRED'.equalsIgnoreCase(paymentStatus)}">
                       <input type="button" class="input_button2 button_override route openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="j" />
                    </g:if>
                    <g:else>
                        <input type="button" class="input_button2 button_override route openConfirmRoute" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="k"/>
                    </g:else>
                </g:elseif>
                <g:else>
                    <g:if test="${'PAID'.equalsIgnoreCase(paymentStatus) || 'NO_PAYMENT_REQUIRED'.equalsIgnoreCase(paymentStatus)}">
                        <input type="button" class="input_button2 button_override route openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="e" />
                    </g:if>
                    <g:else>
                        <input type="button" class="input_button2 button_override route openConfirmRoute" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="f"/>
                    </g:else>
                </g:else>
                <%--					</g:if>--%>
                <%--                    %{--disables prepare button if payment status is unpaid--}%--%>
                <%--                    <g:else>--%>
                <%--							<input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" disabled="disabled" />--%>
                <%--					</g:else>--%>

                <%--    COMMENTED-OUT:BLOCKER        --%>
                <%--                    <g:if test="${paymentStatus?.equalsIgnoreCase("PAID") || paymentStatus?.equalsIgnoreCase("NO_PAYMENT_REQUIRED") || !(documentClass?.equalsIgnoreCase("LC") || documentClass?.equalsIgnoreCase("INDEMNITY")) }">--%>
                <%--	<input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" /> --%>
                <%--					</g:if>--%>
                <%--                    %{--disables prepare button if payment status is unpaid--}%--%>
                <%--                    <g:else>--%>
                <%--							<input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" disabled="disabled" />--%>
                <%--					</g:else>--%>


                </g:if>
            %{--enables prepare button if service type is cancellation--}%
                <g:else>
                    <input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="g"/>
                </g:else>
            </g:if> <g:else>
                <input type="button" class="input_button2 button_override openConfirmRoute" value="Prepare" id="btnPrepare" prepareType="h"/>
            </g:else></td>
        </tr>
    </table>
</g:if>

<g:if test="${params.mode=="dev"}">
    '${session}'
    <br>
    <br>
    '${session['userrole']['id']}'
</g:if>

<g:if test="${(session['userrole']['id']?.equalsIgnoreCase("BRO") && session.etsModel?.approvalMode?.equals("CHECK")) || ((session['userrole']['id']?.equalsIgnoreCase("TSDO")) && (session.dataEntryModel?.approvalLevel == 1 || session.model?.approvalLevel == 1) && (request.forwardURI.find("/ets/") == null) && !((session.dataEntryModel?.status?.equalsIgnoreCase("PENDING") || session.model?.status?.equals("PENDING")) || (session.dataEntryModel?.status?.equalsIgnoreCase("POSTED") || session.model?.status?.equals("POSTED")))) || (session.dataEntryModel?.status == 'PREPARED' || session.model?.status?.equals("PREPARED"))}">
    <table id="checkerButton">
        <tr>
            <td><span class="field_label"> Route To </span></td>
            <td>
                <g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown" />
            </td>
            <td><input type="button" class="input_button_negative button_override openConfirmRoute" value="Return" id="btnReturnChecker" /></td>
        %{--${session.postAuthority} | ${session.signingLimit} | ${session.amountToCheck}--}%
            <g:if test="${session.postAuthority == true}">
                <g:if test="${session.signingLimit >= session.amountToCheck}">
                    <td><input type="button" class="input_button_long button_override openConfirmRoute dataEntryButtons" value="Assume Posting Authority" id="btnPreApprove" /></td>
                </g:if>
            </g:if>

            <td><input type="button" class="button_override input_button openConfirmRoute" value="Check" id="btnCheck" /></td>
        </tr>
    </table>
</g:if>

<g:if test="${(session['userrole']['id']?.equalsIgnoreCase("BRO") && session.etsModel?.approvalMode?.equals("APPROVE")) || ((session['userrole']['id']?.equalsIgnoreCase("TSDO")) && ((session.dataEntryModel?.approvalLevel > 1 || session.model?.approvalLevel > 1)) && (request.forwardURI.find("/ets/") == null)) || (session.dataEntryModel?.status?.equals("POSTED") || session.model?.status?.equals("POSTED"))}">
    <table id="approverButton">
        <tr>
            <g:if test="${(session['userrole']['id']?.equalsIgnoreCase("TSDO")) && (session.dataEntryModel?.approverLevel < 4 || session.model?.approvalLevel < 4)}">

                <g:if test="${session.amountToCheck > session.signingLimit}" >
                    <td>
                        <g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown" />
                    </td>
                </g:if>

            </g:if>
            <td><input type="button" class="input_button_negative button_override openConfirmRoute" value="Return" id="btnReturnApprover" /></td>
            <g:if test="${!documentClass in ['EXPORT_ADVANCE','EXPORT_ADVISING','BP','BC','']}">
            	<td><input type="button" class="input_button_negative2 button_override openConfirmRoute etsButtons" value="Disapprove" id="btnDisapprove" /></td>
			</g:if>
            <g:if test="${(session.dataEntryModel?.status?.equals("PRE_APPROVED") || session.model?.status?.equals("PRE_APPROVED")) || (session.dataEntryModel?.status?.equals("APPROVED") || session.model?.status?.equals("APPROVED")) || (session.dataEntryModel?.status?.equals("POSTED") || session.model?.status?.equals("POSTED"))}">
                <td><input type="button" class="input_button2 button_override openConfirmRoute dataEntryButtons" value="Post Approve" id="btnPostApprove" /></td>
            </g:if>
            <g:else>
                <td><input type="button" class="input_button2 button_override openConfirmRoute" value="Approve" id="btnApprove" /></td>
            </g:else>
        </tr>
    </table>
</g:if>
<br />
<br />
<br />
<br />
<br />
<br />
<span class="title_label">Routing Information</span>
<div class="grid_wrapper">
    %{--JQGRID--}%
    <table id="grid_list_instructions_routing_information"></table>
    <div id="grid_pager_instructions_routing_information"></div>
</div>

<g:render template="../product/commons/popups/confirm_alert" model="[confirmId: 'confirmRoute', cancelId: 'routeCancel', confirmDivId: 'routeDiv', confirmBgId: 'routeBg']" />

<g:render template="../commons/popups/add_instruction_popup" />
<g:render template="../commons/popups/over_availment_popup" />


<script type="text/javascript">
var validateCorresUrl = '${g.createLink(controller: "corresCharge", action: "validateCorresChargeTSDInit")}';

if (!window.console) {
    console = {
        log: function(){
            // do nothing
            // this is to avoid errors in ie7
        }
    };
}

function triggerError(obj, error) {
	var text = error > 0 ? "Please fill in all the required fields in all tabs." : "";
    if(obj.length > 0) {
    	text = text + "\r\nPlease save first the following field:";
    	for(var i = 0; i < obj.length; i++) {
    		text = text + "\r\n " + obj[i];
    	}
    } 
    $("#alertMessage").text(text);
    triggerAlert();
    return true;
}

    function showExcessAmountCharges() {
    	if($("#totalAmountDue").val() != ""){
			var computedTotalAmountDue = parseFloat($("#totalAmountDue").val().replace(/,/g,""));
	    	var computedTotalAmountOfPaymentCharges = parseFloat($("#totalAmountOfPaymentCharges").val().replace(/,/g,""));
	    	var computedExcessAmountCharges = computedTotalAmountOfPaymentCharges - computedTotalAmountDue;
			if(computedExcessAmountCharges > 0.00){
	    		$("#excessAmountCharges").val(formatCurrency(computedExcessAmountCharges));
	    		$("#amountOfPaymentCharges").val(formatCurrency(0));
			} else {
				$("#excessAmountCharges").val(formatCurrency(0));
				$("#amountOfPaymentCharges").val(formatCurrency(Math.abs(computedExcessAmountCharges)));
			}
		}
    }


    function validateExcessChargesValidationUtils(){
    	var excessChargesError=0;
    	var hasRemittanceOrCheckCash=false;
    	var hasRemittanceOrCheckCharges=false;
      
        //validate excess charges in charges payment tab
        if('undefined' !== typeof $("#grid_list_charges_payment")){
        	$.each($("#grid_list_charges_payment").jqGrid("getRowData"),function(idx,val){
        		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
        				val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
        			hasRemittanceOrCheckCharges=true;
        		}
        	});
        }
        
        if(!hasRemittanceOrCheckCharges && 'undefined' !== typeof $("#excessAmountCharges")){
        	if(parseInt($("#excessAmountCharges").val(),10) > 0){
        		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance or Check");
        		excessChargesError++;
        	}
        }

        if(excessChargesError > 0){
        	return false;
        }else{
        	return true;
        }
    }

// fix for darwin
var validatePaymentCount = 0;
var errorPaymentCount = 0;
function checkRequired() {
	validatePaymentCount = 0;
	errorPaymentCount = 0;
	if($("#grid_list_cash_payment_summary").length > 0){
		var postUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedProductPayments2')}';
		var paymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
		$.post(postUrl, {tradeServiceId: $("#tradeServiceId").val(), remainingBalanceLc: $("#remainingBalanceLc").val(), remainingBalance: $("#remainingBalance").val(), productPaymentSummary: JSON.stringify(paymentsummarydata)}, function(data){
			if(data.success == false || ($("#setupProductPayment").length > 0 && !$("#setupProductPayment").val())){
				triggerAlertMessage("Product Payment did not match.");
				errorPaymentCount++;
			}
		}).done(checkRequired2).always(checkRequiredFields);
	} else {
		checkRequiredFields()
		checkRequired2()
	}
}
function checkRequired2() {
	if (errorPaymentCount == 0) {
		if($("#grid_list_proceeds_payment_summary").length > 0){
			var postUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedProceedsPayments')}';
			var paymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
			$.post(postUrl, {tradeServiceId: $("#tradeServiceId").val(), remainingBalance: $("#remainingBalance").val(), proceedsPaymentSummary: JSON.stringify(paymentsummarydata)}, function(data){
				if(data.success == false){
					triggerAlertMessage("Proceeds Payment did not match.");
					errorPaymentCount++;
				}
			}).done(checkRequired3).always(checkRequiredFields);
		} else {
			checkRequiredFields()
			checkRequired3()
		}
	}
}

function checkRequired3() {
	if (errorPaymentCount == 0) {
		if ($("#chargesTab").length > 0 && !$("#chargesTab").is(":hidden")) {
			var postUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedCharges')}';
			var params = {tradeServiceId: $("#tradeServiceId").val()};

			$("#chargesTabForm :input").each(function () {
				if ($(this).attr("type") == "text" && $(this).parents("table").hasClass("charges_table") && $(this).attr("id") != "totalAmountCharges") {
					params[$(this).attr("id")] = $(this).val();
				}
			});

			$.post(postUrl, params, function (data) {
				var error = 0
				for (var key in data) {
					console.log(data[key]);
					error++;
				}
				if (error > 0) {
					triggerAlertMessage("Charges do not match. Please save.");
					errorPaymentCount++;
				}
			}).done(checkRequired4).always(checkRequiredFields);
		} else {
			checkRequiredFields()
			checkRequired4();
		}
	}
}

function checkRequired4() {

	if (errorPaymentCount == 0) {
		if($("#grid_list_charges_payment").length > 0 || $("#documentClass").val() == "EXPORT_ADVISING" || $("#documentClass").val() == "EXPORT_ADVANCE" || $("#documentClass").val() == "IMPORT_ADVANCE"){
			var postUrl = validateSavedChargesPaymentsUrl;
			var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData");
			$.post(postUrl, {tradeServiceId: $("#tradeServiceId").val(), chargesPaymentSummary: JSON.stringify(paymentsummarydata)}, function(data){
				if(data.success == false){
					triggerAlertMessage("Charges Payment did not match.");
					errorPaymentCount++;
				}
			}).always(checkRequiredFields);
		} else {
			if($("#documentClass").val() == "CORRES_CHARGE" && $("#referenceType").val() == "ETS" && $("#statusAction").val() != "Return"){
				checkSavedTabs()
			}		
			checkRequiredFields()
		}
	}
}

function checkSavedTabs(){
	if(errorPaymentCount == 0){
		if($("#allTabSaved").val() == "N"){
				triggerAlertMessage("Please save all tabs.");
				errorPaymentCount++;
		}
	}
}

function checkRequiredFields() {
	validatePaymentCount++;
	if (validatePaymentCount == 4){
		validatePaymentCount = 0;
		
		if(errorPaymentCount == 0){
			var error = 0, errorName = []

			$("#body_forms :input").each(function(){
				if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
					var dataOrig = $(this).attr("data-orig");
					console.log($(this).attr("name") + ": " + dataOrig);
					if ($(this).val() == "") {
						error ++;
						console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
					} if ((dataOrig === "" || dataOrig === "null") && '${referenceType}' === "DATA_ENTRY" && '${serviceType}' === "NEGOTIATION" && '${documentType}' === "FOREIGN" && '${documentClass}' === "BP") {
						errorName[errorName.length] = $(this).attr("name");
					}
				}
			});
			
			console.log("negotiation date: " + '${negotiationDate}');
			
			if (error > 0 || errorName.length > 0) {
				triggerError(errorName, error); // comment this if you want to remove required fields validation for all tabs
	//            openRouteAlert();
			} else {
if ($("#modeOfPaymentTab").length > 0 && $("#modeOfPaymentTab").is(":hidden") == false) {
        		showExcessAmountCharges();
           		if(!validateExcessChargesValidationUtils()){
            			return;
            		}
        	}
            	continueValidation()
			}
		}
	}
}

function continueValidation() {
        var documentsEnclosed = validateDocumentsEnclosed();

        if (documentsEnclosed == "failed") {
            triggerAlertMessage("Please complete the Documents Enclosed and Instructions Tab.");
        } else {

            if (typeof validateSavedDocEnclosedUrl !== "undefined") {
                var url = validateSavedDocEnclosedUrl;

                var params = {
                    docEnclosedIds: $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow").toString(),
                    instructionIds: $("#grid_list_instructions").jqGrid("getGridParam", "selarrrow").toString(),
                    addedInstructionIds: $("#grid_list_additional_conditions").jqGrid("getDataIDs").toString()
                }

                $.get(url, params, function(data) {

                    if (data.success == 'true') {
                        // special case for corres charge
                        $.post(validateCorresUrl, {documentClass: $("#documentClass").val(),
                            tradeServiceId: $("#tradeServiceId").val(),
                            netBillingAmount: $("#netBillingAmount").val()}, function(data) {
                            if (data.success == "true") {
								if($("#statusAction").val() != "Prepare" || referenceType != 'DATA_ENTRY' ){
                                	openRouteAlert();
                               	}else{
                               		checkUnpaidPayments();
                          		}
                            } else {
                                triggerAlertMessage("Net Billing Amount (in PHP) does not match.");
                            }
                        });
                    } else {
                        triggerAlertMessage("Document Enclosed does not match.");
                    }
                });
            } else {
                $.post(validateCorresUrl, {documentClass: $("#documentClass").val(),
                    tradeServiceId: $("#tradeServiceId").val(),
                    netBillingAmount: $("#netBillingAmount").val()}, function(data) {
                    if (data.success == "true") {
                        if($("#statusAction").val() != "Prepare" || referenceType != 'DATA_ENTRY' ){
                           	openRouteAlert();
                       	}else{
                       		checkUnpaidPayments();
                  		}
                    } else {
                        triggerAlertMessage("Net Billing Amount (in PHP) does not match.");
                    }
                });
            }
        }
//    }
}

function checkUnpaidPayments() {
	$.post(checkUnpaidPaymentsUrl, {tradeServiceId: $("#tradeServiceId").val()}, function(data){
		if(data.success == "success"){
			openRouteAlert();
		} else {
			$("#btnPrepare").attr("disabled", "disabled");
			triggerAlertMessage(data.message);
		}
	});
}

function validateDocumentsEnclosed() {
	if ($("#grid_list_documents_enclosed").length > 0 &&
		$("#grid_list_additional_conditions").length > 0 &&
        $("#grid_list_instructions").length > 0) {
        var instructionsSelected = $("#grid_list_instructions").jqGrid("getGridParam", "selarrrow").length;
        var documentsEnclosedCount = $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow").length;
        var additionalConditions = $("#grid_list_additional_conditions").getGridParam("records");

        if (instructionsSelected > 0 || documentsEnclosedCount > 0 || additionalConditions > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

	    return "success";
}

function openRouteAlert() {
	$(".saveAction").show();
	$(".cancelAction").hide();
    mCenterPopup($("#routeDiv"), $("#routeBg"));
    mLoadPopup($("#routeDiv"), $("#routeBg"));
}

function onAbort() {
    var documentClass = $("#documentClass").val();
    var tradeServiceId = $("#tradeServiceId").val();

    $.post(checkPaymentStatusOfPaymentsUrl, {tradeServiceId: tradeServiceId, documentClass: documentClass}, function(data) {
        if (data.success == "success") {
            openRouteAlert();
        } else {
            triggerAlertMessage(data.message);
        }
    });
}

function checkMtAndRequired(){
	var msgType;
    var mtArray = [];

    $(".accordionActions a").filter(function () {
        if ("undefined" !== typeof $(this).attr("onclick") &&
            (($(this).css("display") != "none" && !$(this).is("a[class*='disable']")) || $(this).attr("class").indexOf("hideMe") != -1) &&
            $(this).attr("onclick").indexOf("goToViewMt(") != -1) {
            return $(this);
        } else {
            return false;
        }
    }).each(function () {
            msgType = $(this).attr("onclick").substring(11, 14);
            mtArray.push(msgType);
        });

    if (mtArray.length > 0) {
        mCenterPopup($("#loading_div"), $("#loading_bg"));
        mLoadPopup($("#loading_div"), $("#loading_bg"));

        $.post(checkMtUrl, {messages: mtArray.toString()},
            function (data) {
                mDisablePopup($("#loading_div"), $("#loading_bg"));
                if ("" != data.error) {
                    triggerAlertMessage(data.error);
                } else {
                    checkRequired();
                }
            }).fail(function () {
                mDisablePopup($("#loading_div"), $("#loading_bg"));
            });
    } else {
		checkRequired();
    }
}

function validatePayments() {
    var documentClass = $("#documentClass").val();
    var tradeServiceId = $("#tradeServiceId").val();

    $.post(checkPaymentStatusOfPaymentsUrl, {tradeServiceId: tradeServiceId, documentClass: documentClass}, function(data) {
        if (data.success == "success") {
            if($("#statusAction").val() != "Prepare" || referenceType != 'DATA_ENTRY' ){
            	openRouteAlert();
           	}else{
           		checkUnpaidPayments();
      		}
        } else {
            triggerAlertMessage(data.message);
        }
    });
}

$(document).ready(function() {
    $(".openConfirmRoute").click(checkRequired);
    $(".openConfirmRoute2").click(openRouteAlert);
    $(".abort").click(onAbort);
    $(".returnTransaction").click(validatePayments);
    $(".checkMtAndRequired").click(checkMtAndRequired);
    
    $("#confirmRoute").click(function() {
		mDisablePopup($("#routeDiv"), $("#routeBg"));
		mCenterPopup($("#loading_div"), $("#loading_bg"));
		mLoadPopup($("#loading_div"), $("#loading_bg"));
		$(this).parents("form").submit();
    });
    
    $("#btnApprove").click(function(){
		if (referenceType == "ETS"){
			$.post(validateCutOffTimeUrl,{}, function(data){
				if (data.cutOffStatus == true){
					$("#alertMessage").text("Warning: Transaction is beyond " + data.cutOffTime + " cut-off time.");
	            	triggerAlert();
				}
			});
		}
    });
    
});
</script>