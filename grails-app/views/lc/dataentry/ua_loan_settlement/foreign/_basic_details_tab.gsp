<%@ page import="net.ipc.utils.DateUtils" %>
<%@ page import="net.ipc.utils.NumberUtils" %>
<%@ page import="java.lang.Double" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
			
<%--for AMLA--%>
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
<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagFxCurrency}"/>
<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="productCurrency" value="${productCurrency ?: uaLoanCurrency}"/>
<g:hiddenField name="productAmount" value="${productAmount ?: uaLoanAmount}" />

<g:hiddenField name="tempfcdu" value="${tempfcdu}" />
<g:hiddenField name="temprbu" value="${temprbu}" />
<g:hiddenField name="tempfcdugl" value="${tempfcdugl}" />
<g:hiddenField name="temprbugl" value="${temprbugl}" />

<g:hiddenField name="negotiatingBank" value="${negotiatingBank}"/>
<g:hiddenField name="negotiatingBanksReferenceNumber" value="${negotiatingBanksReferenceNumber}"/>
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" value="${etsNumber}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" value="${etsDate}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Type</span></td>
		<td><g:textField name="type" class="input_field" value="${lcType}" readonly="readonly"/></td>
		<td><span class="field_label">FXLC Amount</span></td>
		<td><g:textField name="outstandingBalance" class="input_field_right" value="${NumberUtils.currencyFormat(new Double(outstandingBalance ?: 0.00))}" readonly="readonly"/></td>	
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
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField name="currency" class="input_field" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label">Negotiation Number</span></td>
		<td><g:textField name="negotiationNumber" class="input_field" value="${negotiationNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC-UA Loan Currency</span></td>
		<td><g:textField name="fxUaLoanCurrency" class="input_field" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label">FXLC UA Loan Amount</span></td>
		<td><g:textField name="amount" class="input_field_right" value="${NumberUtils.currencyFormat(new Double(amount ?: 0.00))}" readonly="readonly"/></td>
	</tr>
<%--HERE--%>
	<tr>
		<td colpsan="2"> <p class="p_header"> Reimbursing Bank </p> </td>
	</tr>
	<tr>
		<td><span class="field_label"> Reimbursing Bank <span class="asterisk">*</span></span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop required" name="reimbursingBank" id="reimbursingBank" />
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><g:textField id="reimbursingBankName" name="reimbursingBankName" value="${reimbursingBankName}" class="input_field"  readonly="readonly"/></td>
	</tr>
	<tr>
        <td><span class="field_label small_margin_left">Account Type <span class="asterisk">*</span></span></td>
        <td id="reimbursingAccountTypeWrapper">
        	<input type="radio" class="required" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
        	<input type="radio" class="required" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label small_margin_left">Reimbursing Bank Account Number</span></td>
        <td><input id="reimbursingBankAccountNumber" name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}" class="input_field required" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label small_margin_left">GL Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label small_margin_left">Reimbursing Currency</span></td>
        <td><g:textField id="reimbursingCurrency" name="reimbursingCurrency" value="${reimbursingCurrency}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Generate MT</span></td>
		<td>
            <g:radioGroup labels="['MT202','None']" values="['MT202','NONE']"  value="${generateMt ?: 'NONE'}" name="generateMt" >
				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
			</g:radioGroup>
		</td>
	</tr>


<%--    %{--removed as of 18.Jul.2013--}%--%>
<%--	%{--<tr>--}%--%>
<%--		%{--<td><span class="field_label">Negotiation Facility Type/ID</span></td>--}%--%>
<%--		%{--<td colspan="2">--}%--%>
<%--			%{--<g:select from="${['FD5','FTF'] }" value="${negotiationFacilityType}" noSelection="${['':'SELECT ONE...']}" name="negotiationFaciltyType" class="select_dropdown_medium"/>--}%--%>
<%--			%{--<g:textField name="negotiationFacilityTypeId" value="${negotiationFacilityTypeId}" class="input_field_medium numberFormat-11"/>--}%--%>
<%--			%{--<a href="javascript:void(0)" class="popup_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>--}%--%>
<%--		%{--</td>--}%--%>
<%--	%{--</tr>--}%--%>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/facility_id_popup"/>
<g:javascript src="popups/dialog_facility_id.js" />
<g:javascript src="utilities/validation/validate_fx_ua_loan_settlement.js"/>


<script>
	$(function(){
		var commodityCode = $('#commodityCode').val(),
	        splittedCommodity;
		
		$("#reimbursingBank").setDepositoryBankDropdownWithCurrency($("#currency").val()).select2('data',{id: '${reimbursingBank}'});
		$("#reimbursingBank").val("${reimbursingBank}");
		$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

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

		if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").attr('checked',true);
            $("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").click();
        }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
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


	    $("#reimbursingBank").on("change", function(e) {
	        var data = $("#reimbursingBank").select2('data');
	        if(data != null){
	            $("#glCode").val(data.glcode);
	            $("#reimbursingCurrency").val(data.currency);
	            $("#reimbursingBankName").val(data.label);
	            $("#tempfcdu").val(data.fcduAccount);
	            $("#temprbu").val(data.rbuAccount);
	            $("#tempfcdugl").val(data.glcodefcdu);
	            $("#temprbugl").val(data.glcoderbu);

	            $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
	            $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
//	            $("#glCode").val('');
	            $("#reimbursingBankAccountNumber").val('');
	        }else{
	            $("#glCode").val('');
	            $("#reimbursingCurrency").val('');
	            $("#reimbursingBankName").val('');
	            $("#tempfcdu").val('');
	            $("#temprbu").val('');
	            $("#tempfcdugl").val('');
	            $("#temprbugl").val('');
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
	    
	});
</script>