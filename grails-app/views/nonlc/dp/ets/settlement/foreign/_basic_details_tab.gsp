<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />

<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="remittingBank" value="${remittingBank}"/>
<g:hiddenField name="reimbursingBank" value="${reimbursingBank}"/>
<g:hiddenField name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}"/>
<g:hiddenField name="importerCifNumber" value="${importerCifNumber}"/>
<g:hiddenField name="importerCbCode" value="${importerCbCode}"/>
<g:hiddenField name="importerName" value="${importerName}"/>
<g:hiddenField name="importerAddress" value="${importerAddress}"/>
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}"/>
<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}"/>
<g:hiddenField name="originalPort" value="${originalPort}"/>
<g:hiddenField name="outstandingAmount" value="${outstandingAmount}"/>

<g:hiddenField name="TR_LOAN_FLAG" value=""/>
<g:hiddenField name="maturityDate" value="${maturityDate}"/>

<g:javascript src="utilities/nonlc/validation_nonlc.js" />

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
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

    <g:if test="${reverseEts || reverseEtsDisplay}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" value="${serviceInstructionId}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Date</span></td>
		<td><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> <span class="field_label">Importer Code</span></td>
        <td> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
	</tr>
	<tr>
	   <td class="label_width"> <span class="field_label"> Commodity Code </span> </td>
	   <td class="input_width">
		    <%-- Auto Complete --%>
		    <input class="select2_dropdown" name="commodity" id="commodity" />
		    <g:hiddenField name="commodityCode" value="${commodityCode}" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Currency</span></td>
		<td>
            <g:textField name="negotiationCurrency" value="${negotiationCurrency}" class="input_field" readonly="readonly"/>
            <g:hiddenField name="currency" value="${currency}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Amount</span></td>
		<td><g:textField name="amount" value="${amount}" class="input_field_right numericCurrency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Settlement Amount<span class="asterisk">*</span></span></td>
		<td><g:textField name="productAmount" value="${productAmount}" class="input_field_right numericCurrency required"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> With 2% CWT </span></td>
		<td>
			<g:radioGroup name="cwtFlag" labels="['Yes', 'No']" value="${cwtFlag ?: 'N'}" values="['Y','N']">
				${it.radio} ${it.label} &#160;&#160;
			</g:radioGroup>
		</td>	
	</tr>
	<tr>
		<td><span class="field_label">Settlement Mode<span class="asterisk">*</span></span></td>
		<td><g:select name="settlementMode" value="${settlementMode}" class="select_dropdown required" from="${['TR', 'Pay']}" noSelection="['':'SELECT ONE...']"/></td>
	</tr>
</table>
<table class="tabs_forms_table settlement_mode">
	<tr>
		<td class="label_width"><span class="field_label">Main CIF Number</span></td>
		<td>
            <g:textField name="mainCifNumber" value="${mainCifNumber ?: cifNumber}" class="input_field" readonly="readonly" />
            <a href="javascript:void(0)" id="main_cif_search" class="search_btn popup_btn_cif_main">Search/Look-up Button</a>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Main CIF Name</span></td>
		<td><g:textField name="mainCifName" value="${mainCifName ?: cifName}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Value Date<span class="asterisk">*</span></span></td>
		<td><g:textField class="datepicker_field required" name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>
<g:render template="../commons/popups/facility_id_popup"/>
<g:render template="../commons/popups/cif_search_main"/>
<g:javascript src="popups/cif_main_search_popup.js" />
<g:javascript src="popups/dialog_facility_id.js"/>
<script type="text/javascript">
var reverseEts = '${reverseEts}';
	$(function(){
		$("#valueDate").datepicker({ showOn: 'both', buttonImage:$("#_datepickerImage").val(),	  
  		  changeMonth: true, changeYear: true, maxDate:new Date()
  		}).attr("readonly","readonly");
		$("#settlementMode").load(setTrLoanFlag);
		$("#settlementMode").change(setTrLoanFlag);
	});
	function setTrLoanFlag(){
		if($("#settlementMode").val() == 'TR'){
			$("#TR_LOAN_FLAG").val('Y');
		} else {
			$("#TR_LOAN_FLAG").val('N');
		}
	}

    %{--<g:javascript src="utilities/ets/commons/window_utility.js" />--}%

    $(document).ready(function() {
        var participantCode = $('#participantCode').val(),
            cifNumber = $('#cifNumber').val(),
            commodityCode = $('#commodityCode').val(),
            splittedCommodity;

        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

        $("#commodity").change(function() {
             splittedCommodity = $(this).val().split("-");
             if(splittedCommodity.length > 0) {
                 $('#commodityCode').val(splittedCommodity[0].toString().trim());
             }
         });

        // If participantCode has no value, try to get the corresponding code on cif table based on CIF number
         if (participantCode === null || participantCode === undefined || participantCode.length === 0) {
             $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
                 if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                     $('#participantCode').val(data.results[0].id);
                 }
             });
         }

        if(commodityCode) {
             $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
                 if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                     $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                 }
             });
         }
     });
</script>

<g:if test="${true == reverseEts}">
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