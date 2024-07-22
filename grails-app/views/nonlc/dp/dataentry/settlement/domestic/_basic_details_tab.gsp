<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
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

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description?.contains('BOOKING')}">
<%--        <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>
<table class="tabs_forms_table">
    <g:if test="${reverseDE}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td class="input_width"><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}" readonly="readonly"/></td>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Date</span></td>
		<td><g:textField class="input_field" name="etsDate" value="${etsDate}" readonly="readonly"/></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField class="input_field" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Buyer CIF Number</span></td>
		<td><g:textField class="input_field" name="importerCifNumber" value="${importerCifNumber}" readonly="readonly"/></td>
		<td><span class="field_label">Outstanding Draft Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingAmount" value="${outstandingAmount}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Buyer Name</span></td>
		<td><g:textArea class="textarea" name="importerName" value="${importerName}" rows="2" maxlength="60"/></td>
		<td><span class="field_label">Negotiation Currency</span></td>
		<td><g:textField class="input_field" name="negotiationCurrency" value="${negotiationCurrency}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Buyer Address</span></td>
		<td rowspan="2"><g:textArea name="importerAddress" class="textarea" value="${importerAddress}" rows="4"/></td>
		<td><span class="field_label">Negotiation Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td/>
		<td><span class="field_label">Value Date</span></td>
		<td><g:textField class="datepicker_field" name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	
	<tr>
		<td class="label_width valign_top"><span class="field_label">Seller Name</span></td>
		<td><g:textArea class="textarea" name="sellerName" value="${sellerName ?: beneficiaryName}" readonly="readonly" rows="2"/></td>
		<g:if test="${!settleFlag || settleFlag != 'Y'}">
			<td><span class="field_label">Settlement Amount</span></td>
			<td><g:textField class="input_field_right numericCurrency" name="productAmount" value="${productAmount}" readonly="readonly"/></td>
		</g:if>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Seller Address</span></td>
		<td><g:textArea name="sellerAddress" class="textarea" value="${sellerAddress ?: beneficiaryAddress}" readonly="readonly" rows="4"/></td>
		<g:if test="${!settleFlag || settleFlag != 'Y'}">
			<td><span class="field_label">Settlement Mode</span></td>
			<td><g:textField class="input_field" name="settlementMode"  value="${settlementMode}" readonly="readonly"/></td>
		</g:if>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<g:if test="${true == reverseDE}">
	<script>
		$(function(){
				$("#body_forms a").not("ul#tabs a,.select2-choice,#add_instruction").remove();
		
	    		$("#body_forms :input").each(function(){
	    			if($(this).attr("type") == "text" || $(this).attr("type") == "textarea") {
	    				$(this).attr("readonly", "readonly");
	    				if($(this).hasClass("datepicker_field")) {
	    					$(this).datepicker("destroy");
	    					$(this).removeClass("datepicker_field").addClass("input_field");
	    				}
	    			}else if($(this).attr("type")=="button" || $(this).attr("type")=="submit") {
	    				if(($(this).parents().is($("#makerButton"))) || 
    						($(this).parents().is($("#checkerButton"))) ||
    						($(this).parents().is($("#approverButton"))) ||
    						$(this).parents().is($("#add_instruction_buttons"))){
	    					//empty block pass-through
	    				}else{
	    					$(this).remove();
	    				}
	    			}else if($(this).hasClass("select2_dropdown")){
	    				$(this).select2("disable");
	    			}else{
	                    if ($(this).attr("type") != "hidden") {
	                        $(this).attr("disabled","disabled");
	                    }
	    			}
	    		});
	    		
	    		//instructions_and_routing_buttons
	   			$("#makerButton *").removeAttr("disabled");
	   			$("#checkerButton *").removeAttr("disabled");
	   			$("#approverButton *").removeAttr("disabled");
	    		
	    		//grids grids grids
	    		//$("div#body_forms div[class^=grid_wrapper]").block({message:null,overlayCSS:{cursor:"default",opacity:0.2,"z-index":2}});
	    		
	    		$("div#grid_list_instructions_routing_remarks_div").unblock();
		});
	</script>
</g:if>