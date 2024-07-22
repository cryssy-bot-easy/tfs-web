<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="sellerName" value="${sellerName}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode ?: '909'}"/>
<%--<g:hiddenField name="corresCheck" value="${corresCheck ?: !corresBankCode ? 1 : 0}"/>--%>

<%--<g:hiddenField name="ebpSettlementFlag" id="ebpSettlementFlag" value="true" />--%>

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> <span class="field_label"> Document Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="tradeServiceReferenceNumber" readonly="readonly" value="${tradeServiceReferenceNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Process Date </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Payment Mode </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="paymentMode" readonly="readonly" value="${paymentMode}"/> </td>
    </tr>
</table>
<span class="tab_titles"> EBP Details </span>
<table class="tabs_forms_table">
<%--    <tr>--%>
<%--        <td class="label_width"> <span class="field_label"> Partial ? </span> </td>--%>
<%--        <td class="input_width">--%>
<%--            <g:checkBox name="partialNegoFlag" />--%>
<%--            <g:hiddenField id="partialNego" name="partialNego" value="${partialNego ?: "off"}" />--%>
<%--        </td>--%>
<%--    </tr>--%>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Currency </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Amount </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Proceeds Amount (in Negotiation Currency)<span class="asterisk"> * </span> </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="proceedsAmount" value="${proceedsAmount}" data-orig="${proceedsAmount}" onkeyup="validateProceedsAmt();" /> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Amount Due </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amountDue" id="amountDue" readonly="readonly" value="${amountDue}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Corres Bank </span> </td>
        <td class="input_width"> <g:textField class="select2_dropdown depoBankDd" name="corresBankCode" value="${corresBankCode}" data-orig="${corresBankCode}"/> </td>
    </tr>
    %{--<tr>--}%
        %{--<td class="label_width"> <span class="field_label"> Corres Bank's Account Number </span> </td>--}%
        %{--<td class="input_width"> <g:textField class="input_field" name="corresBankAccountNumber" readonly="readonly"/> </td>--}%
    %{--</tr>--}%
    <tr>
        <td><span class="field_label small_margin_left">Account Type</span></td>
        <td>
            <input type="radio" id="accountType" name="accountType" value="RBU" data-orig="${accountType}" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if><g:else>disabled="disabled"</g:else>/>RBU
            <input type="radio" id="accountType" name="accountType" value="FCDU" data-orig="${accountType}" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if><g:else>disabled="disabled"</g:else>/>FCDU

        </td>
    </tr>
    <tr>
        <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        <input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
        <input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
        <td><span class="field_label small_margin_left">Account Number</span></td>
        <%-- <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field" /></td> --%>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field" readonly="readonly" /></td>

    </tr>
    <tr>
        <td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
    </tr>
</table>
<br />
<span class="tab_titles"> Bills Purchased Loan to be Settled </span>
<br />
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> <span class="field_label"> PN Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="pnNumber" readonly="readonly" value="${pnNumber}"/> </td>
    </tr>

	<tr>
        <td class="label_width" style="display: none;"> <span class="field_label"> Advanced Corres Charge </span> </td>
        <td class="input_width" style="display: none;"> <g:textField class="input_field_right numericCurrency"name="advancedCorresCharge" id="advancedCorresCharge" data-orig="${advancedCorresCharge}" /></td>
    </tr>

	<tr>
        <td class="label_width" style="display: none;"> <span class="field_label"> Additional Corres Charge </span> </td>
        <td class="input_width" style="display: none;"> <g:textField class="input_field_right numericCurrency"name="additionalCorresCharge" id="additionalCorresCharge" data-orig="${additionalCorresCharge}" /></td>
    </tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
	<%-- 01102017 EBP Extraction - Case 11 --%>
	<%-- Validation: In EBP Settlement,  the proceeds amount (screen field is Proceeds Amount in Negotiation Currency) should be less than or equal to EBP Nego --%>
	function validateProceedsAmt(){
		var proceedsAmount = $("#proceedsAmount").val();
		var ebpNegoAmt = $("#amount").val();
		proceedsAmount = proceedsAmount.replace(/,/g, '');
		ebpNegoAmt = ebpNegoAmt.replace(/,/g, '');
		proceedsAmount = parseFloat(proceedsAmount);
		ebpNegoAmt = parseFloat(ebpNegoAmt);
		<%-- 05032017 RM 4215 Edit by Pat - Check if Prepare button is present in page and disable if proceeds exceed ebp nego amount --%>
		if( $("#btnPrepare").val() != undefined ){
			if ( proceedsAmount > ebpNegoAmt){
				triggerAlertMessage("Proceeds Amount cannot be greater than EBP Nego Amount.");
	<%--			$("#proceedsAmount").val("");--%>
	<%--			$("#proceedsAmount").val($("#amount").val());--%>
				$("#btnPrepare").attr("disabled", true);
				$("#saveConfirmBasicDetails").attr("disabled", true);
			} else if ( proceedsAmount == 0 ) {
				triggerAlertMessage("Proceeds Amount cannot be equal to zero.");
				$("#proceedsAmount").val("");
				$("#amountDue").val("");
			} else {
				$("#btnPrepare").removeAttr("disabled");
				$("#saveConfirmBasicDetails").removeAttr("disabled");
			} 
		}
	}		

	<%-- 05052017 RM 4125 Edit by Pat - When user presses Enter Key to save --%>
	$(document).keypress(function(e) {
	    if(e.which == 13) {
	    	if ( $("#proceedsAmount").val() > $("#amount").val()){
	    		triggerAlertMessage("Proceeds Amount cannot be greater than EBP Nego Amount.");
<%--				$("#proceedsAmount").val("");--%>
	<%--			$("#proceedsAmount").val($("#amount").val());--%>
				$("#btnPrepare").attr("disabled", true);
				$("#saveConfirmBasicDetails").attr("disabled", true);
			    e.preventDefault();
			} else {
				$("#btnPrepare").removeAttr("disabled");
				$("#saveConfirmBasicDetails").removeAttr("disabled");
			}
	    }
	});

    function computeCorresCharge() {
    	if ($("#paymentMode").val() != "LC" && parseFloat($("#proceedsAmount").val().replace(/,/g,"")) > parseFloat($("#amount").val().replace(/,/g,""))){
        	triggerAlertMessage("Proceeds amount cannot be greater than EBP amount.");
        	$(this).val("");
        	$("#amountForCredit").val("");
        } else {
	        var amount = parseFloat($("#amount").val().replace(/,/g,""));
	        var proceedsAmount = $("#proceedsAmount").val().replace(/,/g,"");
	
	        if (proceedsAmount == "") {
	            $("#amountDue").val("");
	            return;
	        }
	
	        var amountDue = amount - proceedsAmount;
	
	        if (amountDue < 0) {
	            amountDue = 0;
	        }
	        $("#amountDue").val(formatCurrency(amountDue));
        }
    }

    function setPartialNego() {
        var partialNegoFlag = $("#partialNegoFlag").attr("checked");

        if (partialNegoFlag == "checked") {
            $("#partialNego").val("on");
        } else {
            $("#partialNego").val("off");
        }
    }

    function setPartialNegoFlag() {
        var partialNego = $("#partialNego").val();

        $("#partialNegoFlag").removeAttr("checked");

        if (partialNego == "on") {
            $("#partialNegoFlag").attr("checked", "checked");
        }
    }

    $(document).ready(function() {

		<%-- Set initial value of additional corres charge --%>
<%--    	if( $("#additionalCorresCharge").val() != 'undefined' ){--%>
<%--      		$("#additionalCorresCharge").val($("#amountDue").val());--%>
<%--        }--%>

		<%-- 01232017 RM 4137 - Hide charges/nego payment tab in EBP Settlement--%>
		<%-- Trigger function only when basic details tab is not undefined and document class is BP and service type is SETTLEMENT --%>
<%--		if($("#basicDetailsTab").val() != 'undefined' && $("#documentClass").val() == "BP" && $("#serviceType").val() == "SETTLEMENT"){--%>
<%--			if($("#ebpSettlementFlag").val() == "true"){--%>
<%--				$("#cashLcPaymentTab").hide();--%>
				<%-- Remove required properties --%>
<%--				$("#passOnRateConfirmedByCash").removeClass("required");				--%>
<%--			}--%>
<%--		}--%>

		<%-- 01102017 RM 4122 - Call validation onload --%>
        if( $("#proceedsAmount").val() != "" ){
        	validateProceedsAmt();
        }

        //if($("#corresCheck").val() == 1){
<%--            $("#corresBankCode").toggleClass("input_field", false).toggleClass("select2_dropdown", true).removeAttr("readonly").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});--%>
            $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});
            $("#corresBankCode").on("change", function(e) {
    	    	var data = $("#corresBankCode").select2('data');
    		if(data != null){
    	        $("#glCode").val(data.glcode);
    	        $("#corresBankCurrency").val(data.currency);
    	        $("#corresBankName").val(data.label);
    	        $("#tempfcdu").val(data.fcduAccount);
    	        $("#temprbu").val(data.rbuAccount);
    	        $("#tempfcdugl").val(data.glcodefcdu);
    	        $("#temprbugl").val(data.glcoderbu);
    	
    	        $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
    	        $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
    	        $("#depositoryAccountNumber").val('');
    	    }else{
    	        $("#glCode").val('');
    	        $("#corresBankCurrency").val('');
    	        $("#corresBankName").val('');
    	        $("#tempfcdu").val('');
    	        $("#temprbu").val('');
    	        $("#tempfcdugl").val('');
    	        $("#temprbugl").val('');
    	    }
    		if($("#temprbugl").val() && $("#tempfcdugl").val()){
            	$("#accountType[value=RBU]").attr('checked',true);
                $("#accountType[value=RBU]").click();
            }else {
            if(!$("#temprbugl").val()) {
    	        $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
    	        $("#accountType[value=FCDU]").attr('checked',true);
    	        $("#accountType[value=FCDU]").click();
    	    }
    	
    	    if(!$("#tempfcdugl").val()) {
    	        $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
    	        $("#accountType[value=RBU]").attr('checked',true);
    	        $("#accountType[value=RBU]").click();
    	    }
    	    }
    	    });
            $("input[name='accountType']").on("click", function(e) {
    	        if($("input[name='accountType']:checked").val() == 'RBU') {
    	            $("#depositoryAccountNumber").val($("#temprbu").val());
    	            $("#glCode").val($("#temprbugl").val());
    	        } else {
    	            $("#depositoryAccountNumber").val($("#tempfcdu").val());
    	            $("#glCode").val($("#tempfcdugl").val());
    	        }
    	    });
        //}
    	$.post(autoCompleteDepositoryBankUrl, {starts_with: '${corresBankCode}'}, function(jsonData){
			if(jsonData.success){
				if(jsonData.total == 1){
					var data = jsonData.results[0];
					$("#corresBankCode").val(data.id);
					$("#glCode").val(data.glcode);
		        	$("#tempfcdu").val(data.fcduAccount);
		            $("#temprbu").val(data.rbuAccount);
		            $("#tempfcdugl").val(data.glcodefcdu);
		            $("#temprbugl").val(data.glcoderbu);

		            if($("#temprbugl").val() && $("#tempfcdugl").val()){
		            	$("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").attr('checked',true);
		                $("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").click();
		            }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
		    	        if(!$("#temprbugl").val()) {
		    	            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
		    	            $("#accountType[value=FCDU]").attr('checked',true);
		    	            $("#accountType[value=FCDU]").click();
		    	            $("#glCode").val($("#tempfcdugl").val())
		    	        }
		    	
		    	        if(!$("#tempfcdugl").val()) {
		    	            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
		    	            $("#accountType[value=RBU]").attr('checked',true);
		    	            $("#accountType[value=RBU]").click();
		    	            $("#glCode").val($("#temprbugl").val())
		    	        }
		            }
				}
			}
		});
        
        $("#proceedsAmount").change(computeCorresCharge);
        computeCorresCharge();
        $("#partialNegoFlag").click(setPartialNego);
        setPartialNegoFlag();

        $("#saveConfirmBasicDetails").click(function() {
        	if(validateExportTab("#basicDetailsTabForm") > 0){
        		triggerAlertMessage(val_msg);
        	} else {
            	mCenterPopup($("#loading_div"), $("#loading_bg"));
            	mLoadPopup($("#loading_div"), $("#loading_bg"));
	            $("#basicDetailsTabForm").submit();
        	}
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>