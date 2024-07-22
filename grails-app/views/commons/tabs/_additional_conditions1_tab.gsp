<%-- 
(revision)
[Modified by:] Rafael Ski Poblete
[Date Modified:] 8/28/2018
[Description: ] Removed "charges" radio button and table grid to UI.
                Added Narrative for MT740.
                
[Date Modified:] 9/03/2018
[Description: ] Removed "charges" and "narrative" radio button and replaced by narrative checkbox.
                Added functionalities to Narrative checkbox. --%>
<script type="text/javascript">
    var additionalConditionsUrl = '${g.createLink(controller: "additionalCondition", action: "findAllAdditionalConditions")}';
    var savedAdditionalConditionUrl = '${g.createLink(controller: "additionalCondition", action: "findAllSavedAdditionalConditions")}';
    var addedConditionUrl = '${g.createLink(controller: "additionalCondition", action: "findAllAddedConditions")}';
    var getAllAddedConditionUrl = '${g.createLink(controller: "additionalCondition", action: "getAllAddedConditions")}';

    var swiftChargesUrl = '${g.createLink(controller: "swiftCharge", action: "displayAllSwiftCharges")}';
    var savedSwiftChargesUrl = '${g.createLink(controller: "swiftCharge", action: "getAllSavedSwiftCharges")}';
</script>

<g:javascript src="grids/additional_conditions1_jqgrid.js" />
<g:javascript src="grids/additional_conditions2_jqgrid.js" />
<g:javascript src="grids/swift_narrative_option_jqgrid.js"/>
<%-- For Amendment --%>
<g:javascript src="utilities/dataentry/commons/additionalCheckBoxFunction1.js" />
<g:if test="${serviceType == 'Amendment' }">
<g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />
</g:if>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="additionalConditions1" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="swiftNarrativeRadio" value="${swiftNarrativeRadio}"/>
<g:hiddenField name="reimbursingBank" value="${reimbursingBankIdentifierCode}"/>
<g:hiddenField name="destinationBank" value="${destinationBank}"/>
<g:hiddenField name="swiftChargesList" value="" />

<table>
	<tr>
		<td> <span class="field_label"> Discrepancy Currency <span class="asterisk">*</span> </span> </td>
		<td> 
			<%-- <g:select name="discrepancyCurrency" value="${discrepancyCurrency ?: 'USD'}" from="${['USD', 'EUR', 'YEN']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown_medium" /> --%>
		  
		   	<%-- Auto Complete --%>
		   	<input class="tags_currency select2_dropdown bigdrop required" name="discrepancyCurrency" id="discrepancyCurrency" />
		</td>
	</tr>
	<tr>
		<td> <span class="field_label"> Discrepancy Amount<span class="asterisk">*</span> </span> </td>
		<td> <g:textField name="discrepancyAmount" value="${discrepancyAmount ?: 60}" class="input_field_right numericCurrency" /> </td>
	</tr>
</table>
<%-- FOR OTHER SERVICE TYPE EXCEPT AMENDEMENT --%>
<g:if test="${serviceType != 'Amendment' }">	
    <p class="p_header">Additional Conditions</p>
	<div class="grid_wrapper">
		<table id="add_conditions1_list"></table>
		<div id="add_conditions1_pager"></div>
        <g:hiddenField name="additionalConditionsList" value="" />
	</div>
	<br/>
	<span class="right_indent">
		<input type="button" id="addAditionalConditionBtn" value="Add Conditions" class="input_button_long" />
	</span>
	<br/>
	<br/>
	<div class="grid_wrapper">
		<table id="add_conditions2_list"></table>
		<div id="add_conditions2_pager"></div>
        <g:hiddenField name="addedAdditionalConditionsList" value="" />
	</div>
	<br/>
	<%--<span class="right_indent"> Bug #3204
		<input type="button" id="popup_btn_preview_req_doc2" value="Preview Required Documents in SWIFT" class="input_button_long2" />
	</span>--%>
</g:if>

<%-- FOR AMENDMENT ONLY --%>

<g:if test="${serviceType == 'Amendment' }">
    <p class="p_header">Additional Conditions</p>
    <div class="grid_wrapper">
        <table id="add_conditions1_list"></table>
        <div id="add_conditions1_pager"></div>
        <g:hiddenField name="additionalConditionsList" value="" />
    </div>
    <br/>
    <span class="right_indent">
        <input type="button" id="addAditionalConditionBtn" value="Add Conditions" class="input_button_long" />
    </span>
    <br/>
    <br/>
    <div class="grid_wrapper">
        <table id="add_conditions2_list"></table>
        <div id="add_conditions2_pager"></div>
        <g:hiddenField name="addedAdditionalConditionsList" value="" />
    </div>

	<br/>
</g:if>
<br/>
<br/>
<p class="p_header">Charges <g:if test="${(reimbursingBankIdentifierCode) && reimbursingBankIdentifierCode != destinationBank}"><span class="asterisk">*</span></g:if></p>
<div class="swift-narrative-option">
	<br/>
	<label>
    <input type="checkbox" value="NARRATIVE" id="swiftNarrativeCheckbox" />
    &#160;Narrative
    </label>
    <br/>
    <g:select name="narrativeCharges" disabled="disabled" from="${['BENEFICIARY','APPLICANT']}" value="${narrativeCharges ?: 'BENEFICIARY'}" class="select_dropdown" />
	<div class="narrative-option small_margin_left">
		<g:textArea name="additionalNarrative" class="amendment_narrative" disabled="disabled" rows="5" cols="102" value="${additionalNarrative ?: 'All charges outside the Philippines are for the account of the beneficiary including reimbursing charges.'}"/>
	</div>
</div>
<br/>

<div>
	<p class="p_header">Narrative for MT740</p>
		<g:textArea name="narrativeFor740" class="narrativeFor740" value="${narrativeFor740}"/>
	<br/>
</div>

<g:render template="../commons/popups/addedit_condition_popup" />

<%-- commented out since it is not applicable --%>
<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>

<div id="domMessage" style="display:none;">
    <h1>We are processing your request.  Please be patient.</h1>
</div>

<script>
    $(document).ready(function() {
    	$("#narrativeFor740").limitCharAndLines(100,65,'Z');
<%--        $("#discrepancyCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${discrepancyCurrency}'});--%>
        $("#discrepancyCurrency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${discrepancyCurrency ?: 'USD'}'});
        
        if(${swiftNarrativeRadio?.equals("NARRATIVE") ? true : false}) {
            $('#swiftNarrativeCheckbox').prop('checked', true);
            $("#additionalNarrative").removeAttr("disabled");
            $("#narrativeCharges").removeAttr("disabled");
            $(".swiftGrid").block({message: null, fadeIn: 1});
        } else {
            $('#swiftNarrativeCheckbox').prop('checked', false);
            $("#additionalNarrative").attr("disabled", "disabled");
            $("#narrativeCharges").attr("disabled", "disabled");
            $('#swiftNarrativeRadio').val("");
        }
        
        $("#swiftNarrativeCheckbox").on("click", function(e) {
            if(document.getElementById('swiftNarrativeCheckbox').checked) {
                $("#additionalNarrative").removeAttr("disabled");
                $("#narrativeCharges").removeAttr("disabled");
                $(".swiftGrid").block({message: null, fadeIn: 1});
                $('#swiftNarrativeRadio').val("NARRATIVE");
            } else { 
                $("#additionalNarrative").attr("disabled", "disabled");
                $("#narrativeCharges").attr("disabled", "disabled");
                $('#swiftNarrativeRadio').val("");
            }
        });
	});
</script>
