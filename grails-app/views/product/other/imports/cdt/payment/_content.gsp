<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _content.gsp


>--%>

<%--
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Updated by:] Cedrick Nungay
	[Date Updated:] 01/11/2018
	Program [Revision] Details: Added title for Importer's email address and RM/BM email address, and changes value for email status.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _content.gsp


>--%>

<script type="text/javascript">
    var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';

    $(document).ready(function() {
        productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
        productChargeUrl += "&referenceType=" + $("#referenceType").val();
        productChargeUrl += "&serviceType="+$("#serviceType").val();
        productChargeUrl += "&form="+$("#form").val();

        setupJqGridWidthNoPagerHidden('grid_list_payment_cdt', {width : 780, height: 100, scrollOffset : 0, loadComplete: updateTotalsCdt,
            gridComplete: function() {
                enableDisableAccountingentriesLink();
                showDebitMemo();
                }},
                [['accountNumber', 'Account Number', 120, 'left'],
                    ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                    ['settlementCurrency', 'Refund Currency', 120, 'center'],
                    ['amountSettlement', 'Amount (in Settlement Currency)', 220, 'right'],
                    ['deletePaymentSummary','Delete', 40, 'center'],
                    ['status','Status', 60, 'center'],
                    ['pay', '&nbsp;', 70, 'center'],
                    ['tradeSuspenseAccount', 'tradeSuspenseAccount', 1, 'center', 'hidden'],
                    ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                    ['accountName', 'Account Name', 1, 'center', 'hidden'],
                    ['referenceId', 'Reference ID', 1, 'center', 'hidden'],
                    ['paidDate', 'Paid Date', 1, 'center', 'hidden']], productChargeUrl);
    });
</script>
<form id="basicDetailsTabForm" action="${cdtAction}" method="POST">
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="iedieirdNumber" value="${iedieirdNumber}" />
<g:hiddenField name="processingUnitCode" value="${session.unitcode}" />
<g:hiddenField name="paymentRequestType" value="${paymentRequestType}" />
%{--<g:hiddenField name="e2mStatus" value="${e2mStatus}" />--}%
<g:hiddenField name="tin" value="${tin}" />
<g:hiddenField name="ccn" value="${ccn}" />

<g:hiddenField name="cifNumber" value="${cifNumber}" />
<g:hiddenField name="settlementCurrency" value="PHP" />
<g:hiddenField name="casaAccountNumberCdt" value="${casaAccountNumber}" />
<g:hiddenField name="cdtPaymentClientName" value="${clientName}" />
<g:hiddenField name="cdtPaymentPaidDate" value="" />
<g:hiddenField name="cdtBankChargeDefaultValue" value="${bankCharge ?: '0.00'}" />

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> Client Name </span></td>
        <td class="input_width">
            <g:textField name="clientName" value="${clientName}" class="input_field" readonly="readonly"/>
            <g:hiddenField name="tinNo" value="${tin}" />
        </td>
        <td class="label_width"><span class="field_label"> CIF Number </span></td>
       	<td class="input_width"><g:textField class="input_field_normal_case" readonly="readonly" name="cifNumberField" value="${cifNumber}" /></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> AAB Ref Code </span></td>
        <td class="input_width">
            <g:textField name="agentBankCode" value="${agentBankCode}" class="input_field" readonly="readonly"/>
        </td>
        <td class="label_width"><span class="field_label"> CIF Name </span></td>
       	<td class="input_width"><g:textField class="input_field_normal_case" readonly="readonly" name="cifNameField" value="${cifName}" /></td>
    </tr>
</table>
<span class="title_label">Importer Contact Person</span><br /><br />
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> Importer Contact Person </span></td>
        <td class="input_width"><g:textField class="input_field" readonly="readonly" name="contactPerson" value="${contactPerson}" /></td>
        <td class="label_width"><span class="field_label"> Name of RM/BM with Unit/Branch </span></td>
        <td class="input_width">
            %{--<g:textField class="input_field" readonly="readonly"  name="clientName" value="${clientName}" />--}%
            <g:textField class="input_field" readonly="readonly"  name="rmbmBranch" value="${rmbmBranch ?: ((accountOfficer ?: "") + " (" + (ccbdBranchUnitCode ?: "") + ")")}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Importer Contact Numbers </span></td>
        <td class="input_width"><g:textField class="input_field" readonly="readonly" name="phoneNumber" value="${phoneNumber}" /></td>
        <td class="label_width"><span class="field_label"> RM/BM Email Address </span></td>
        <td class="input_width"><input type="text" class="input_field_normal_case" readonly="readonly" name="rmbmEmail" title="${rmbmEmail?.toString()}" value="${rmbmEmail}" /></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Importer Email Address </span></td>
        <td class="input_width"><input type="text" class="input_field_normal_case" readonly="readonly" name="email" title="${importersEmail?.toString()}" value="${importersEmail}" /></td>
        <td class="label_width"><span class="field_label"> Email Status </span></td>
        <td class="input_width"><g:textField class="input_field_normal_case" readonly="readonly" name="e2mStatus" value="${emailStatus}" /></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> e2M Status </span></td>
        <td class="input_width"><g:textField class="input_field_normal_case" readonly="readonly" name="e2mStatus" value="${e2mStatus}" /></td>
    </tr>
</table><br />
<span class="title_label">Custom Duties Tax Payment Details</span><br /><br />
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> CDT Amount </span></td>
        <td class="input_width"><g:textField class="input_field_right numericCurrency" readonly="readonly" name="amount" value="${amount}" /></td>
        <td class="label_width"><span class="field_label"> Final Duty Amount </span></td>
        <td class="input_width"><g:textField class="input_field_normal_case numericCurrency" readonly="readonly" name="finalDutyAmount" value="${finalDutyAmount}" /></td>
    </tr>
    <g:if test="${!("ADVANCE".equals(paymentRequestType) && amount == 0)}">
        <tr>
            <td class="label_width"><span class="field_label"> Bank Charge <span class="asterisk">*</span></span></td>
            <td class="input_width">
                <g:textField class="input_field_right numericCurrency" name="defaultBankCharge" value="${(bankCharge != null)? bankCharge : defaultBankCharge}" />
            </td>
            <td class="label_width"><span class="field_label"> Final Tax Amount </span></td>
        	<td class="input_width"><g:textField class="input_field_normal_case numericCurrency" readonly="readonly" name="finalDutyAmount" value="${finalTaxAmount}" /></td>
        </tr>
    </g:if>
    <tr>
        <td class="label_width"><span class="field_label"> Total Amount Due</span></td>
        <td class="input_width">
            <g:textField class="input_field_right numeric_fifteen right numericCurrency" readonly="readonly" name="totalAmountDue" value="${totalAmountDue ?:
                ((amount ?: 0) + ((!("ADVANCE".equals(paymentRequestType) && amount == 0)) ? (defaultBankCharge ?: 0) : 0))}"/>
        </td>
        <td class="label_width"><span class="field_label"> Final Charges </span></td>
        <td class="input_width"><g:textField class="input_field_normal_case numericCurrency" readonly="readonly" name="finalDutyAmount" value="${finalCharges}" /></td>
    </tr>
    <tr>
		<g:if test="${tradeServiceId}">
		        <td class="long_width"><span class="field_label"> Amount of Payment<span class="asterisk">* </span></span></td>
		        <td class="input_width"><g:textField class="input_field_right numericCurrency" name="amountOfPayment" value="${totalAmountDue ?:
		            ((amount ?: 0) + ((!("ADVANCE".equals(paymentRequestType) && amount == 0)) ? (defaultBankCharge ?: 0) : 0))}"/></td>
		</g:if>
		<g:else>
			<td/>
			<td/>
		</g:else>
		<td class="label_width"><span class="field_label"> IPF Charges </span></td>
       	<td class="input_width"><g:textField class="input_field_normal_case numericCurrency" readonly="readonly" name="finalDutyAmount" value="${ipf}" /></td>
    </tr>
</table>
<br />
<g:if test="${tradeServiceId && amount != 0 && paymentviewMode == false}">

    <input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" />
    <br/>
    <span class="title_label">Payment Summary</span>
    <div class="grid_wrapper">
        <table id="grid_list_payment_cdt"></table>
        <%--	<div id="grid_pager_pay_duties_and_taxes"></div>--%>
        <g:hiddenField name="documentPaymentSummary" value="" />
    </div>
</g:if>
<g:else>
    <input style="display:none" type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" />
    <br/>
    <span style="display:none" class="title_label">Payment Summary</span>
    <div style="display:none" class="grid_wrapper">
        <table style="display:none" id="grid_list_payment_cdt"></table>
        <%--	<div id="grid_pager_pay_duties_and_taxes"></div>--%>
        <g:hiddenField name="documentPaymentSummary" value="" />
    </div>
    
</g:else>


<table class="tabs_forms_table">
    <g:if test="${tradeServiceId}">
        <tr>
            <td class="label_width"><span class="field_label"> Total Amount of Payment </span></td>
            <td class="input_width">
                <g:textField class="input_field_right" readonly="readonly" name="totalAmountOfPayment" value="${totalAmountOfPayment ?: '0.00'}"/>
            </td>
        </tr>
        <tr>
            <td class="label_width"><span class="field_label"> Remaining Balance </span></td>
            <td class="input_width">
                <g:textField class="input_field_right" readonly="readonly" name="remainingCDTBalance" value="${remainingCDTBalance ?: '0.00'}"/>
            </td>
        </tr>
    </g:if>
    <tr>
        <td class="label_width"><span class="field_label"> Document Number </span></td>
        <td class="input_width"><g:textField class="input_field numeric_fifteen right" name="documentNumber" value="${documentNumber}" /></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> CDT Transaction</span><br /><span class="field_label">Reference Number </span></td>
        <td class="input_width"><g:textField class="input_field numeric_fifteen right" readonly="readonly" name="transactionReferenceNumber" value="${transactionReferenceNumber ?: iedieirdNumber}" /></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> CDT Payment</span><br /><span class="field_label">Reference Number </span></td>
        <td class="input_width"><g:textField class="input_field numeric_fifteen right" name="paymentReferenceNumber" value="${paymentReferenceNumber}" readonly="readonly"/></td>
    </tr>
</table>


    <table class="buttons_for_grid_wrapper saveButtonsContainer">
        <g:if test="${amount == 0 && tradeServiceId}">
            <tr>
                <td>
                    <input type="button" id="tagAsPaid" class="input_button" value="PAY" />
                    <input type="button" id="tagAsNew" class="input_button_negative" value="NEW" />
                </td>
            </tr>
        </g:if>
        <tr>
            <td><g:if test="${paymentviewMode == false}">
            <input type="button" id="saveConfirmCdt" class="input_button" value="Save" />
            </g:if>
            
            </td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative cancelTransaction actionButton actionWidget" onclick="cdtInquiry();" value="Back" /></td>
        </tr>
    </table>
</form>

<script type="text/javascript">

	function onCheckAmountOfPayment() {
        if ($("#popup_btn_mode_of_payment_charges").length > 0) {
            if($("#amountOfPayment").val() != ""){
                $("#popup_btn_mode_of_payment_charges").removeAttr("disabled");
            } else {
                $("#popup_btn_mode_of_payment_charges").attr("disabled", "disabled");
            }
        }
	}

    function onDefaultBankChargeChange() {
        //var cdtAmountBankChargeSum = "";
        //cdtAmountBankChargeSum = parseInt($("#amount").val().split(',').join('')) + parseInt($("#defaultBankCharge").val().split(',').join(''));
        var amount = parseFloat($("#amount").val().replace(/,/g, ""));
        var defaultBankCharge = 0;

        if ($("#defaultBankCharge").length > 0 && $("#defaultBankCharge").val() != "") {
            defaultBankCharge = parseFloat($("#defaultBankCharge").val().replace(/,/, ""));
        }

        var cdtAmountBankChargeSum = amount + defaultBankCharge;
        $("#amountOfPayment, #totalAmountDue").val(formatCurrency(cdtAmountBankChargeSum));
    }

    $(document).ready(function() {
        formId = "#basicDetailsTabForm";
        $("#saveConfirmCdt").click(function() {
			var aabRefCodeValidation = false;
			$.post('${g.createLink(controller: "cdt", action: "validateAabRefCode")}', 
					{aabRefCode: $("#agentBankCode").val()},
				function(data){
					console.log(JSON.stringify(data));
					if (JSON.stringify(data) == "[]"){
						triggerAlertMessage("Invalid AABREFCODE.");
						console.log("1");
					}else{
						aabRefCodeValidation = true;
						console.log("2");
					}
			}).done(function(){
				$.post('${g.createLink(controller: "cif", action: "validateCifCDT")}',
	                    {cifNumber: $("#cifNumberField").val()},
	            	function(data) {
			    	    if (aabRefCodeValidation == true && ($("#cifNumberField").val()=="NONE" || $("#cifNumberField").val() == "")){
	            	        $(".saveAction").show();
	        		        $(".cancelAction").hide();
	        	        	$("#basicDetailsTabForm").submit();
					  	}else if (aabRefCodeValidation == true && JSON.stringify(data.sibsStatus) == '[null]'){
					  		triggerAlertMessage("CIF not found in SIBS.");	
	                	}else if (aabRefCodeValidation == true && JSON.stringify(data.sibsStatus) != '[null]'){
	            	        $(".saveAction").show();
	        		        $(".cancelAction").hide();
	        	        	$("#basicDetailsTabForm").submit();
		                }
	        	});
			});
        });

        $("#cancelConfirmCdt").click(function() {
        	$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#cdtDiv"), $("#cdtBg"));
            mLoadPopup($("#cdtDiv"), $("#cdtBg"));
        });

        if ($("#defaultBankCharge").length > 0) {
            $("#defaultBankCharge").change(onDefaultBankChargeChange);
            onDefaultBankChargeChange();
        }

        onCheckAmountOfPayment();
		$("#amountOfPayment").change(onCheckAmountOfPayment);

        if ($("#tagAsPaid").length > 0) {
            $("#tagAsPaid").click(function() {
                $.post('${g.createLink(controller: "cdt", action: "tagAsPaid")}',
                        {iedierdNumber: $("#iedieirdNumber").val(), tradeServiceId: $("#tradeServiceId").val()},
                function(data) {
                    $("#paymentReferenceNumber").val("");
                    if (data.success == true) {
                        triggerAlertMessage("Transaction successful.");
                        $("#paymentReferenceNumber").val(data.paymentReferenceNumber);
                        $("#tagAsPaid").hide();
                        $("#tagAsNew").show();
                    } else {
                        triggerAlertMessage(data.message);
                        $("#tagAsPaid").show();
                        $("#tagAsNew").show();
                    }
                });
            });
        }

        if ($("#tagAsNew").length > 0) {
            $("#tagAsNew").click(function() {
                $.post('${g.createLink(controller: "cdt", action: "tagAsNew")}',
                        {iedierdNumber: $("#iedieirdNumber").val(), tradeServiceId: $("#tradeServiceId").val()},
                        function(data) {
                            $("#paymentReferenceNumber").val("");
                            if (data.success == true) {
                                triggerAlertMessage("Transaction successful.");
                                $("#tagAsPaid").show();
                                $("#tagAsNew").hide();
                            } else {
                                triggerAlertMessage(data.message);
                                $("#paymentReferenceNumber").val(data.paymentReferenceNumber);
                                $("#tagAsPaid").hide();
                                $("#tagAsNew").show();
                            }
                        });
            });
        }

        if($("#tagAsPaid").length > 0 && $("#tagAsNew").length > 0) {
            if (${"PAID".equals(status)}) {
                $("#tagAsPaid").hide();
                $("#tagAsNew").show();
            } else {
                $("#tagAsPaid").show();
                $("#tagAsNew").hide();
            }
        }
    });
</script>