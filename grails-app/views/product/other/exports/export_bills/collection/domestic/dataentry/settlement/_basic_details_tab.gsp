<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<g:hiddenField name="buyerName" value="${buyerName}"/>
<g:hiddenField name="sellerName" value="${sellerName}"/>
<g:hiddenField name="bookingCurrency" id="bookingCurrencyHidden" value="${bookingCurrency}" />
<g:hiddenField name="loanAmount" id="loanAmountHidden" value="${loanAmount}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/> </td>
        <td><span class="field_label">Reimbursing Bank<span class="asterisk">*</span></span></td>
        <td><input class="tags_cbcode select2_dropdown bigdrop required" name="reimbursingBank" id="reimbursingBank" /></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/> </td>
		<td><span class="field_label small_margin_left">Account Type</span></td>
        <td>
            <input type="radio" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if><g:else>disabled="disabled"</g:else>/>RBU
            <input type="radio" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if><g:else>disabled="disabled"</g:else>/>FCDU
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
		<input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        <input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
        <input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
        <td><span class="field_label small_margin_left">Account Number</span></td>
        <%-- <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field" /></td> --%>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td colspan="2"/>
		<td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
	</tr>
</table>
<br>

<span class="tab_titles"> DBC Details </span>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
	</tr>
</table>
<br>

<span class="tab_titles"> DBP Details </span>
<table class="tabs_forms_table">
    <tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="bpCurrency" readonly="readonly" value="${bpCurrency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="bpAmount" readonly="readonly" value="${bpAmount}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Proceeds Amount (in Negotiation Currency)<span class="asterisk"> * </span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="proceedsAmount" value="${proceedsAmount}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Amount for Credit </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amountForCredit" readonly="readonly" value="${amountForCredit}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> With 2% CWT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Export proceeds to be </span> <br />
			<span class="field_label"> remitted via PDDTS? </span>
		</td>
		<td class="input_width">
		  	<g:radioGroup name="exportViaPddtsFlag" labels="['Yes','No']" values="[1, 0]" value="${exportViaPddtsFlag ?: 0}">
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		</td>
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
    function setConfirmOnly() {
        var confirmOnly = $("#confirmOnly").attr("checked");

        if (confirmOnly == "checked") {
            $("#confirmOnlyFlag").val("true");
        } else {
            $("#confirmOnlyFlag").val("false");
        }
    }

    $(document).ready(function() {
    	$("#reimbursingBank").setDepositoryBankDropdownWithCurrency($("#currency").val()).select2('data',{id: '${reimbursingBank}'});
        $("#proceedsAmount").change(function() {
        	var creditAmount;
        	
            if ($("#proceedsAmount").val() != "") {
                //var amountVar = $("#amount").val().replace(/,/g,"");
                var bpAmountVar = $("#bpAmount").val().replace(/,/g,"");
                var proceedsAmountVar = $("#proceedsAmount").val().replace(/,/g,"");

                //var amount = parseFloat(amountVar);
                var bpAmount = parseFloat(bpAmountVar);
                var proceedsAmount = parseFloat(proceedsAmountVar);

                //var receivableAmount = amount - bpAmount;
                //if (proceedsAmount < receivableAmount) {
                if($("#bpCurrency").val()){
	                if (proceedsAmount < bpAmount) {
	                    creditAmount = 0;
	                //} else if (proceedsAmount >= receivableAmount) {
	                } else if (proceedsAmount >= bpAmount) {
	                    creditAmount = proceedsAmount-bpAmount;
	                }
                } else {
                    creditAmount = proceedsAmount;
                }

                $("#amountForCredit").val(formatCurrency(creditAmount));
            } else {
                $("#amountForCredit").val("");
            }
        });
//
//        $("#confirmOnly").click(setConfirmOnly);
//        setConfirmOnly();

            $("#reimbursingBank").on("change", function(e) {
    	    	var data = $("#reimbursingBank").select2('data');
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
            $.post(autoCompleteDepositoryBankUrl, {starts_with: '${reimbursingBank}'}, function(jsonData){
    			if(jsonData.success){
    				if(jsonData.total == 1){
    					var data = jsonData.results[0];
    					$("#reimbursingBank").val(data.id);
    					$("#glCode").val(data.glcode);
    		        	$("#tempfcdu").val(data.fcduAccount);
    		            $("#temprbu").val(data.rbuAccount);
    		            $("#tempfcdugl").val(data.glcodefcdu);
    		            $("#temprbugl").val(data.glcoderbu);

    		            if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
    		            	$("#accountType[value=RBU]").removeAttr('disabled');
    		            	$("#accountType[value=FCDU]").removeAttr('disabled');
    		            	
        		           	if('${accountType}'){
        		           		$("#accountType[value=${accountType}]").attr('checked',true);
    		    	            $("#accountType[value=${accountType}]").click();
           		           	}
    		    	        if($("#temprbugl").val() == "") {
    		    	            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
    		    	            $("#accountType[value=FCDU]").attr('checked',true);
    		    	            $("#accountType[value=FCDU]").click();
    		    	        }
    		    	
    		    	        if($("#tempfcdugl").val() == "") {
    		    	            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
    		    	            $("#accountType[value=RBU]").attr('checked',true);
    		    	            $("#accountType[value=RBU]").click();
    		    	        }
    		            }
    				}
    			}
    		});

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