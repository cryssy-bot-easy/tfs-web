<%-- 
(revision)
    SCR/ER Number: SCR_IBD-17-1122-01
    SCR/ER Description: Changes on screen
    [Revised by:] Jaivee Hipolito
    [Date revised:] 12/11/2017
    Program [Revision] Details: Change O/S FXLC Balance to Outstanding LC Amount,
            O/S LC - Cash(added), O/S LC – Regular(added), O/S Balance (less IC Amount) to Outstanding LC Amount),
            Remove condition of Outstanding LC Amount if totalIcAmount is 0.
    Member Type: Groovy Server Pages (GSP)
    Project: WEB
    Project Name: _basic_details_tab.gsp

    SCR/ER Number: 
    SCR/ER Description: Negotiation Discrepancy
    [Revised by:] Cedrick C. Nungay
    [Date revised:] 09/28/2017
    Program [Revision] Details: Removed required validation on IC Number.
    Member Type: Groovy Server Pages (GSP)
    Project: WEB
    Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/ets/commons/basic_details.js" />
<g:javascript src="temp_validation/validation_negotiation.js" />
<g:javascript src="jquery.limit-1.2.source.js"/>

<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="tempfcdu" value="${tempfcdu}" />
<g:hiddenField name="temprbu" value="${temprbu}" />
<g:hiddenField name="tempfcdugl" value="${tempfcdugl}" />
<g:hiddenField name="temprbugl" value="${temprbugl}" />

<%-- For AMLA --%>
<g:hiddenField name="amlaRemittanceFlag" value="${amlaRemittanceFlag}" />
<g:hiddenField name="amlaCheckFlag" value="${amlaCheckFlag}" />
<g:hiddenField name="amlaCashFlag" value="${amlaCashFlag}" />
<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />
<g:hiddenField name="amlaRemittanceFlagPhp" value="${amlaRemittanceFlagPhp}" />
<g:hiddenField name="amlaCheckFlagPhp" value="${amlaCheckFlagPhp}" />
<g:hiddenField name="amlaCashFlagPhp" value="${amlaCashFlagPhp}" />
<g:hiddenField name="amlaCasaFlagPhp" value="${amlaCasaFlagPhp}" />
<g:hiddenField name="amlaRemittanceFlagFx" value="${amlaRemittanceFlagFx}"/>
<g:hiddenField name="amlaCheckFlagFx" value="${amlaCheckFlagFx}"/>
<g:hiddenField name="amlaCashFlagFx" value="${amlaCashFlagFx}"/>
<g:hiddenField name="amlaCasaFlagFx" value="${amlaCasaFlagFx}"/>
<g:hiddenField name="amlaRemittanceFlagAmount" value="${amlaRemittanceFlagAmount}"/>
<g:hiddenField name="amlaCheckFlagAmount" value="${amlaCheckFlagAmount}"/>
<g:hiddenField name="amlaCashFlagAmount" value="${amlaCashFlagAmount}"/>
<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>
<%--<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>--%>
<g:hiddenField name="amlaCasaFlagFxCurrency" value="${amlaCasaFlagFxCurrency}"/>
<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>

<g:hiddenField name="totalIcAmount" value="${totalIcAmount}" />
<g:hiddenField name="totalIcCashAmount" value="${totalIcCashAmount}" />
<g:hiddenField name="icRegularAmount" value="${icRegularAmount}" />
<g:hiddenField name="icCashAmount" value="${icCashAmount}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width">
            <g:textField name="lcNumber" class="input_field" value="${lcNumber}" readonly="readonly" />
        </td>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField name="processingUnitCode" class="input_field unitCode" readonly="readonly" value="${processingUnitCode}"/>	</td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${etsNumber}"/></td>
		<td> <span class="field_label"> Shipment Number </span></td>
		<td><g:textField name="shipmentNumber" class="input_field" readonly="readonly" value="${shipmentNumber ?: '1'}"/></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span></span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
    </tr>
	<tr>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
		<td colpsan="2"> <p class="p_header"> Reimbursing Bank </p> </td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Expiry Date </span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
		<td><span class="field_label"> Reimbursing Bank <span class="asterisk">*</span></span></td>
        <td>
            <input class="tags_bank select2_dropdown bigdrop required" name="reimbursingBank" id="reimbursingBank" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>
		<td><g:textField name="type" class="input_field" value="${type}" readonly="readonly" /></td>
		<td> &nbsp; </td>
        <td><g:textField id="reimbursingBankName" name="reimbursingBankName" value="${reimbursingBankName}" class="input_field"  readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td><g:textField name="originalCurrency" class="input_field currency" value="${originalCurrency}" readonly="readonly" /></td>
		<td><span class="field_label small_margin_left">Account Type <span class="asterisk">*</span></span></td>
        <td id="reimbursingAccountTypeWrapper">
            <input type="radio" class="required" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" class="required" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> Original FXLC Amount </span></td>
		<td><g:textField name="originalAmount" class="input_field_right numericCurrency" value="${originalAmount}" readonly="readonly" /></td>
        <td class="label_width"><span class="field_label small_margin_left">Reimbursing Bank Account Number</span></td>
        <td><input id="reimbursingBankAccountNumber" name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}" class="input_field required" readonly="readonly" /></td>
	</tr>
	<tr>
        <td><span class="field_label">IC Number</span></td>
        <td><g:textField name="icNumber" class="input_field" readonly="readonly" value="${icNumber}"/></td>
        <td class="label_width"><span class="field_label small_margin_left">GL Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
	    <td><span class="field_label"> Negotiation Number </span></td>
        <td><g:textField name="negotiationNumber" class="input_field" readonly="readonly" value="${negotiationNumber}"/></td>
        <td class="label_width"><span class="field_label small_margin_left">Reimbursing Currency</span></td>
        <td><g:textField id="reimbursingCurrency" name="reimbursingCurrency" value="${reimbursingCurrency}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
        <td><span class="field_label"> Negotiation Currency </span></td>
        <td><g:textField name="negotiationCurrency" class="input_field currency" value="${negotiationCurrency}" readonly="readonly" /></td>
		<td><span class="field_label">Generate MT</span></td>
        <td>
            <g:radioGroup labels="['MT752','MT202','None']" values="['MT752','MT202','NONE']"  value="${generateMt ?: 'NONE'}" name="generateMt" >
                ${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
            </g:radioGroup>
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Amount </span></td>
		<td><g:textField name="negotiationAmount" class="input_field_right numericCurrency" readonly="readonly" value="${negotiationAmount}"/></td>
	    <td><span class="field_label"> Outstanding LC Amount </span><br /><span class="field_label"> (before IC Negotiation) </span></td>
        <td><g:textField name="outstandingBalance" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Overdrawn Amount</span></td>
		<td><g:textField name="overdrawnAmount" class="input_field_right numericCurrency" readonly="readonly" value="${overdrawnAmount}"/></td>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
            <td><span class="field_label">O/S LC - Cash</span></td>
            <td><g:textField name="cashAmount" class="input_field_right numericCurrency" readonly="readonly" value="${cashAmount}"/></td>
        </g:if>
        <g:else>
            <td><g:hiddenField name="cashAmount" value="0"/></td>`
            <td>&#160;</td>
        </g:else>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Type <span class="asterisk">*</span></span></td>
		<td><tfs:negotiationType name="negotiationType" class="select_dropdown required" value="${negotiationType}" /></td>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
            <td><span class="field_label">O/S LC – Regular</span></td>
           <td><g:textField name="cashAmountRegular" class="input_field_right numericCurrency" readonly="readonly" value="${(outstandingBalance != null ? outstandingBalance as double : 0.0)-(cashAmount != null ? cashAmount as double : 0.0)}"/></td>
        </g:if>
		</tr>
	<tr>
		<td><span class="field_label">BKE?</span></td>
		<td>
			<g:radioGroup name="bkeFlag" id="bkeFlag" labels="['Yes', 'No']" values="['Y','N']"  value="${bkeFlag ?: 'Y'}">
				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiating Bank <span class="asterisk">*</span></span></td>
		<td>
			<%-- <g:select name="negotiatingBank" class="select_dropdown" id='negotiatingBank'  noSelection="['':'Select One...']" value='${negotiatingBank}' from="${['NB1', 'NB2', 'NB3', 'NB4']}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop required" name="negotiatingBank" id="negotiatingBank" maxlength="12"/>
		</td>
		<td><span class="field_label" id="outstandingBalanceLessIcLabel">Outstanding LC Amount</span><br /><span class="field_label">(after IC Negotiation)</span></td>
        <td><span id="outstandingBalanceLessIcField">
                <g:textField id="outstandingBalanceLessIc" name="outstandingBalanceLessIc" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${outstandingBalanceLessIc}"/>
            </span>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiating Bank's <span class="asterisk">*</span> <br/>Reference Number</span></td>
		<td><g:textField maxlength="30" class="input_field required" name="negotiatingBanksReferenceNumber" value="${negotiatingBanksReferenceNumber}" onkeypress="return isAlphaNumericKey2(event)" id='negotiatingBanksReferenceNumber'/></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
    	var commodityCode = $('#commodityCode').val(),
    		splittedCommodity;
		
		<%-- $("#negotiatingBank").select2('data',{id: '${negotiatingBank}'}); --%>
        $("#negotiatingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiatingBank}'});
        <%-- $("#reimbursingBank").select2('data',{id: '${reimbursingBank}'}); --%>
        <%-- $("#reimbursingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingBank}'}); --%>
		
        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

	    if(commodityCode) {
	        $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    }

        $("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });
	    
    	if($("input[type=radio][name=bkeFlag]:checked").val() == "Y") {
			$("#negotiatingBank").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiatingBank}'});
		} else {
			$("#negotiatingBank").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val('${negotiatingBank}').select2('destroy');
		}
		$("input[type=radio][name=bkeFlag]").change(function() {
			if($("input[type=radio][name=bkeFlag]:checked").val() == "Y") {
    			$("#negotiatingBank").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiatingBank}'});
    		} else {
    			$("#negotiatingBank").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val('${negotiatingBank}').select2('destroy');
    		}
		});  

	    
        <%-- TEST --%>
        $("#reimbursingBank").setDepositoryBankDropdownWithCurrency($("#originalCurrency").val()).select2('data',{id: '${reimbursingBank}'});
        $("#reimbursingBank").val("${reimbursingBank}");
        	
		if($("#shipmentNumber").val() == "NaN" || $("#shipmentNumber").val() == "NAN") {
			$("#shipmentNumber").val("1");
		} 
		
		if($("#documentSubType1").val() == "CASH") {
			$("#negotiationType").val("CL");
			$("#negotiationType").attr("disabled", "disabled");
		} else if($("#documentSubType1").val() == "REGULAR" && $("#documentSubType2").val() == "SIGHT") {
			$("#negotiationType>option[value=CL]").hide();
			$("#negotiationType>option[value=UA]").hide();
		} else {
			$("#negotiationType").val("UA");
			$("#negotiationType").attr("disabled", "disabled");
		} 

		$.post(autoCompleteDepositoryBankUrl, {starts_with: '${reimbursingBank}', currency: $("#originalCurrency").val()}, function(jsonData){
			if(jsonData.success){
				if(jsonData.total == 1){
					var data = jsonData.results[0];
					$("#reimbursingBank").val(data.id);
					$("#glCode").val(data.glcode);
					$("#reimbursingBankName").val(data.label)
		        	$("#tempfcdu").val(data.fcduAccount);
		            $("#temprbu").val(data.rbuAccount);
		            $("#tempfcdugl").val(data.glcodefcdu);
		            $("#temprbugl").val(data.glcoderbu);

		            if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
		                if (($("#temprbugl").val()) && ($("#tempfcdugl").val())){
			                if('${accountType}' == 'FCDU'){
				                $("#accountType[value=FCDU]").attr('checked',true);
				                $("#accountType[value=FCDU]").click();
		                	} else {
				                $("#accountType[value=RBU]").attr('checked',true);
				                $("#accountType[value=RBU]").click();
			                }
		                } else {
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
					}
				}
			}
		});
    });

    $("#reimbursingBank").on("change", function(e) {
        var data = $("#reimbursingBank").select2('data');
        if(data != null){
            if (data.cb_creditor_code == null) {
                $("#alertMessage").text("CB Creditor Code cannot be null nor Zero.");
                triggerAlert();
                $("#reimbursingBank").select2('data', null)
                return;
            }
            $("#glCode").val(data.glcode);
            $("#reimbursingCurrency").val(data.currency);
            $("#reimbursingBankName").val(data.label);
            $("#tempfcdu").val(data.fcduAccount);
            $("#temprbu").val(data.rbuAccount);
            $("#tempfcdugl").val(data.glcodefcdu);
            $("#temprbugl").val(data.glcoderbu);

            $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
            $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
//            $("#glCode").val('');
            $("#reimbursingBankAccountNumber").val('');
        }else{
            $("#glCode").val('');
            $("#reimbursingCurrency").val('');
            $("#reimbursingBankName").val('');
            $("#tempfcdu").val('');
            $("#temprbu").val('');
            $("#tempfcdugl").val(null);
            $("#temprbugl").val(null);
            $("#reimbursingBankAccountNumber").val('');
            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
        }
        if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=RBU]").attr('checked',true);
            $("#accountType[value=RBU]").click();
        } else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
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
            $("#reimbursingBankAccountNumber").val($("#temprbu").val());
            $("#glCode").val($("#temprbugl").val());
        } else if($("input[name='accountType']:checked").val() == 'FCDU') {
            $("#reimbursingBankAccountNumber").val($("#tempfcdu").val());

            $("#glCode").val($("#tempfcdugl").val());
        }
    });
    
    
</script>