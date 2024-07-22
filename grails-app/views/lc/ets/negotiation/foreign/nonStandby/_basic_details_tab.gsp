<%-- 
(revision)
    SCR/ER Number: SCR_IBD-17-1122-01
    SCR/ER Description: Changes on screen
    [Revised by:] Jaivee Hipolito
    [Date revised:] 12/11/2017
    Program [Revision] Details: Change O/S FXLC Balance to Outstanding LC Amount,
            AP-Cash Amount to O/S LC - Cash, O/S LC – Regular(added), O/S Balance to Outstanding LC Amount),
            Remove condition of Outstanding LC Amount if totalIcAmount is 0.
    Member Type: Groovy Server Pages (GSP)
    Project: WEB
    Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/ets/commons/negotiation_utility.js" />
<g:javascript src="utilities/ets/commons/basic_details.js" />
<g:javascript src="temp_validation/validation_negotiation.js" />
<g:javascript src="jquery.limit-1.2.source.js"/>


<script type="text/javascript">
    var cashFlag = '${cashFlag}';

    function validate(evt) {
    	  var theEvent = evt || window.event;
    	  var key = theEvent.keyCode || theEvent.which;
    	  key = String.fromCharCode( key );
    	  var regex = /[0-9]|\./;
    	  if( !regex.test(key) ) {
    	    theEvent.returnValue = false;
    	    if(theEvent.preventDefault) theEvent.preventDefault();
    	  }
    	}

    $(document).ready(function() {
        var participantCode = $('#participantCode').val(),
            cifNumber = $('#cifNumber').val(),
            commodityCode = $('#commodityCode').val(),
            splittedCommodity;

        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

        // If participantCode has no value, try to get the corresponding code on cif table based on CIF number
        if (participantCode === null || participantCode === undefined || participantCode.length === 0) {
            $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $('#participantCode').val(data.results[0].id);
                }
            });
        }

        $("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });

        if(commodityCode) {
            $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                }
            });
        }

    });
</script>

<g:hiddenField name="cashAmount00" value="${cashAmount00}" />
<g:hiddenField name="cashAmount00ROUNDFLOOR" value="${cashAmount00ROUNDFLOOR}" />
<g:hiddenField name="cashAmountORIG" value="${cashAmountORIG}" />
<g:hiddenField name="totalNegotiatedCashAmountORIG" value="${totalNegotiatedCashAmountORIG}" />

<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

<g:hiddenField name="icCount" value="${icCount}" />

<g:hiddenField name="productAmount" value="${productAmount}" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />

<g:hiddenField name="positiveToleranceLimit" value="${positiveToleranceLimit}" />
<g:hiddenField name="negativeToleranceLimit" value="${negativeToleranceLimit}" />
<g:hiddenField name="partialShipment" value="${partialShipment}" />

<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
<g:hiddenField name="reimbursingBank" value="${reimbursingBank ?: reimbursingBankIdentifierCode}"/>
<g:hiddenField name="reimbursingBankName" value="${reimbursingBankName ?: reimbursingBankNameAndAddress}"/>
<g:hiddenField name="accountType" value="${accountType ?: reimbursingAccountType}"/>
<g:hiddenField name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}"/>
<g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency}"/>
</g:if>

<g:hiddenField name="cashFlag" value="${cashFlag}" />
<g:hiddenField name="shipmentNumber" value="${shipmentNumber ?: shipmentCount ? shipmentCount.intValue() + 1 : '1'}" />

<g:hiddenField name="totalIcAmount" value="${totalIcAmount}" />
<g:hiddenField name="totalIcCashAmount" value="${totalIcCashAmount}" />
<g:hiddenField name="icRegularAmount" value="${icRegularAmount}" />
<g:hiddenField name="icCashAmount" value="${icCashAmount}" />
<g:hiddenField name="outstandingBalanceLessIc" value="${outstandingBalanceLessIc}" />

%{--<g:textField name="tradeProductNumber" value="${tradeProductNumber}" />--}%

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field length20" readonly="readonly" value="${lcNumber ?: documentNumber}"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field disabled length12" readonly="readonly" value="${serviceInstructionId}"/></td>
		<td><span class="field_label">FXLC Expiry Date </span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field length3" readonly="readonly" value="${processingUnitCode}"/></td>
		<td><span class="field_label">Negotiation Value Date </span></td>
        <td><g:textField class="input_field" name="negotiationValueDate" readonly='readonly' value="${negotiationValueDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
        <td class="label_width"> <span class="field_label"> Commodity Code </span> </td>
        <td class="input_width">
            <%-- Auto Complete 
            <input class="select2_dropdown required" name="commodity" id="commodity" /> --%>
            <input class="select2_dropdown" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
    </tr>
	<tr>
		<td><span class="field_label">FXLC Issue Date</span></td>
		<td><g:textField name="issueDate" class="input_field"  readonly="readonly" value="${issueDate}" /></td>
		<td><span class="field_label">IC Number</span></td>
        <td>
            %{--<g:select name="icNumber" from="${['OPTION 1', 'OPTION 2', 'OPTION 3']}" keys="${['OPTION1', 'OPTION2', 'OPTION3']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${icNumber}"/> --}%
            
                <g:select name="icNumber" from="${icNumbers}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${icNumber}"/>
        
        </td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Type</span></td>
		<td><g:textField name="type" class="input_field" value="${type}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label">Negotiation Currency</span></td>
        <td><g:textField name="negotiationCurrency" class="input_field length3"  readonly="readonly" value="${negotiationCurrency ?: currency}"/></td><%--changed value from negoCurrency to value of FXLC Currency  --%>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField name="originalCurrency" class="input_field length3" value="${originalCurrency ?: currency}" readonly="readonly" /></td>
        <td><span class="field_label">Negotiation Amount<span class="asterisk">*</span></span></td>
        <td><g:textField name="negotiationAmount" class="input_field_right amountFormat numericCurrency required" id='negotiationAmount' value="${negotiationAmount}" onkeypress="return isNumberKey(event)" onkeyup="this.value = numFormat(this.value)"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Amount</span></td>
		<td>
            %{--<g:hiddenField name="originalAmount" value="${originalAmount}"/>--}%
            <g:textField name="originalAmount" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${originalAmount}"/>
        </td>
        <g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
            <td><span class="field_label">Reimbursing Bank - Special Rate</span></td>
            <td><g:textField maxlength="9" name="reimbursingBankSpecialRate" class="input_field_right rateFormat" value="${reimbursingBankSpecialRate}" onkeypress="validate(event)"/></td>
        </g:if>
	</tr>
	<tr>
		<td><span class="field_label">Value Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="valueDate" class="datepicker_field required" id='valueDate' value="${valueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td><span class="field_label">Reimbursing Currency</span></td>
        <td><g:textField name="reimbursingCurrency" class="input_field length3" readonly="readonly" value="${reimbursingCurrency}"/></td>
	</tr>
	<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
		<tr>
			<td><span class="field_label">Outstanding LC Amount<br /></span><span class="field_label">(before IC Negotiation)</span></td>
	        <td><g:textField name="outstandingBalance" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
			<td><span class="field_label">Negotiating Amount</span><br /><span class="field_label">(in Reimbursing Currency)</span></td>
	        <td><g:textField name="negotiationAmountInReimbursingCurrency" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${negotiationAmountInReimbursingCurrency}"/></td>
		</tr>
	</g:if>
	<g:else>
		<g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency ?: originalCurrency ?: currency}"/>
		<g:hiddenField name="negotiationAmountInReimbursingCurrency" value="${negotiationAmountInReimbursingCurrency ?: negotiationAmount}"/>
	</g:else>
	<tr>
	   <g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
            <td><span class="field_label">O/S LC - Cash</span></td>
            <td><g:textField name="cashAmount" class="input_field_right numericCurrency" readonly="readonly" value="${cashAmount}"/></td>
            <td><span class="field_label">Overdrawn Negotiation Amount</span><br/><span class="field_label">(in Negotiation Currency)</span></td>
            <td><g:textField name="overdrawnAmount" class="input_field_right numericCurrency" readonly="readonly" value="${overdrawnAmount}" /></td>
        </g:if>
        <g:else>
            <td><g:hiddenField name="cashAmount" value="0"/></td>
            <td>&#160;</td>
            <g:hiddenField name="overdrawnAmount" class="input_field numericCurrency" readonly="readonly" value="${overdrawnAmount}" />
        </g:else>
	</tr>
	<tr>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
            <td><span class="field_label">O/S LC – Regular</span></td>
            <td><g:textField name="cashAmountRegular" class="input_field_right numericCurrency" readonly="readonly" value="${(outstandingBalance != null ? outstandingBalance as double : 0.0)-(cashAmount != null ? cashAmount as double : 0.0)}"/></td>
		</g:if>
	</tr>
   	<tr>
   		<td><span class="field_label" id="outstandingBalanceLessIcLabel">Outstanding LC Amount</span><br /><span class="field_label">(after IC Negotiation)</span></td>
        <td> <span id="outstandingBalanceLessIcField">
            <g:textField id="outstandingBalanceLessIc" name="outstandingBalanceLessIc" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${outstandingBalanceLessIc}"/>
        </span></td>
  			<td><span class="field_label">With 2% CWT? <span class="asterisk">*</span></span></td>
		<td>
          		 <g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}">
	       		 ${it.radio}&#160;<g:message code="${it.label}" />
	   		 </g:radioGroup>
		</td>
	</tr>
</table>
<br/>

<g:hiddenField name="negotiationBank" value="${negotiationBank}" />
<g:hiddenField name="negotiationBankRefNumber" value="${negotiationBankRefNumber}" />
<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />

<g:render template="/layouts/buttons_for_grid_wrapper" />