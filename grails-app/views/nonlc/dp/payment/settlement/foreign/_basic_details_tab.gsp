<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="productAmount" value="${productAmount}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />
<g:hiddenField name="reimbursingBank" value="${reimbursingBank}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="valueDate" value="${valueDate}"/>

<table class="tabs_forms_table">
    <g:if test="${reverseDE}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" value="${etsDate}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField class="input_field" name="processingUnitCode" value="${processingUnitCode}" readonly="readonly"/></td>
	</tr>
	
	<tr>
		<td><span class="field_label"> Negotiation Currency </span></td>
		<td><g:textField class="input_field" name="negotiationCurrency" value="${negotiationCurrency}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> With 2% CWT?</span></td>
		<td>
			<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>				
		</td>
	</tr>
</table>
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