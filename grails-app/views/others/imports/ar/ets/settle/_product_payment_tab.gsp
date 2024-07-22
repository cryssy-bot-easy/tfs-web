<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="lcPayment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="reverseDE" value="${reverseDE}"/>
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:javascript src="grids/ar_settle_jqgrid.js" />
<script type="text/javascript">
	var paymentStatusUrl = '${g.createLink(controller:'otherCharges', action:'getPaymentStatus')}';
    var refundChargesUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
    refundChargesUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    refundChargesUrl += "&referenceType=" + $("#referenceType").val();

    refundChargesUrl += "&serviceType="+$("#serviceType").val();
    refundChargesUrl += "&form="+"basicDetails";
</script>
<span class="bold">Payment Details</span>

<g:hiddenField name="bookingDate" value="${bookingDate}" />
<g:hiddenField name="setupProductPayment" value="${setupProductPayment}" />

<table class="charges_table">
	<tr>
		<td><span class="field_label"> Nature of Transaction </span></td>
		<td colspan="2"><g:textField class="input_field" readonly="readonly" name="natureOfTransaction" value="${natureOfTransaction}" /></td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td><span class="field_label"> AR Currency / Amount </span></td>
		<td><g:textField class="input_field_short input_three" readonly="readonly" name="apCurrency" value="${apCurrency ?: currency}" />
			<g:hiddenField name="settlementCurrencyLc" value="${settlementCurrencyLc ?: currency}"/></td>
		<td><g:textField class="input_field_right numeric_fifteen numericCurrency" readonly="readonly" name="amountDue" value="${amountDue ?: amount ?: originalAmount}"/>
			<g:hiddenField name="amountBalance" value="${amountBalance}"/></td>
		
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td><span class="field_label"> Amount of Payment <br />(in Settlement Currency)<span class="asterisk">* </span></span></td>
		<td><g:textField class="input_field_short input_three" readonly="readonly" name="currency" value="${currency}" /></td>
		<td class="editable"><g:textField class="input_field_right numericCurrency" name="apAmount" value="${amountDue ?: amount ?: originalAmount}" /></td>
	</tr>
</table>
<br/>
<%-- <g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add AP Settlement"/> --%>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add AR Settlement" />
<br/>
<table class="charges_table">	

</table><br />
<span class="title_label"> Payment Summary for AR Settlement </span>
<div class="grid_wrapper">
    <g:if test="${referenceType.equalsIgnoreCase("ETS")}">
	    <table id="grid_list_refund_branch"></table>
    </g:if>

    <g:if test="${referenceType.equalsIgnoreCase("DATA_ENTRY")}">
        <table id="grid_list_refund_main"></table>
    </g:if>

    <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> Total Amount of Payment <br />(in Settlement Currency) </span></td>
        <td class="input_width"><g:textField class="input_field_right numericCurrency" readonly="readonly" name="totalAmountOfPayment" value="${totalAmountOfPayment ?: 0.00}"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Excess Amount <br />(in Settlement Currency) </span></td>
        <td class="input_width"><g:textField class="input_field_right numericCurrency" readonly="readonly" name="excessAmount" value=""/></td>
    </tr>
</table>
<br />
<g:if test="${!session['group']?.equalsIgnoreCase('TSD')}">
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>
<script>
	function validateBasicDetailsTab(buttonParentId){
		if(buttonParentId == 'cashLcPaymentTabForm'){
			if(parseFloat($("#amountDue").val().replace(/,/g, "")) > parseFloat($("#totalAmountOfPayment").val().replace(/,/g, ""))){
				triggerAlertMessage("Total Amount of Payment must be equal or greater than AR Amount.");
				_pageHasErrors = true;
			}
		}
	}
	$(function(){
		$("#totalAmountOfPayment").change(function(){
			if(parseFloat($(this).val().replace(/,/g,"")) >= parseFloat($("#amountDue").val().replace(/,/g,""))){
				$("#setupProductPayment").val(true);
			}else {
				$("#setupProductPayment").val("");
			}
		});	
	});
	
		$(function(){
		  $("#amountBalance").change(function(){
			if($(this).val() == "0.00"){
				$("#apAmount").val("0.00");
	       }else{
	        	$("#apAmount").val($("#amountBalance").val());
			 }
		});
	});
</script>