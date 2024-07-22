<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="currency" value="${currency}" />

<%--for AMLA--%>
<g:hiddenField name="amlaRemittanceFlag" value="${amlaRemittanceFlag}" />
<g:hiddenField name="amlaCheckFlag" value="${amlaCheckFlag}" />
<g:hiddenField name="amlaCashFlag" value="${amlaCashFlag}" />
<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />
<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>
<g:hiddenField name="amlaCheckFlagAmount" value="${amlaCheckFlagAmount}"/>
<g:hiddenField name="amlaCashFlagAmount" value="${amlaCashFlagAmount}"/>
<g:hiddenField name="amlaRemittanceFlagAmount" value="${amlaRemittanceFlagAmount}"/>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
        <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>

<g:javascript src="utilities/nonlc/validation_nonlc.js" />
<table class="tabs_forms_table">
    <g:if test="${reverseDE}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">eTS Date</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsDate" value="${etsDate}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
		<td class="label_width"> <span class="field_label"> Commodity Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		    <%-- Auto Complete --%>
		    <input class="select2_dropdown required" name="commodity" id="commodity" />
		    <g:hiddenField name="commodityCode" value="${commodityCode}" />
		</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Main CIF Number</span></td>
		<td class="input_width">
			<g:textField name="mainCifNumber" value="${mainCifNumber}" class="input_field" readonly="readonly" />
			<g:if test="${cifNumber}" >
				<a href="javascript:void(0)" id="main_cif_search" class="search_btn popup_btn_cif_main">Search/Look-up Button</a>
			</g:if>
		</td>
		<td class="label_width"><span class="field_label">Outstanding Draft Amount</span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="outstandingAmount" value="${outstandingAmount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Main CIF Name</span></td>
		<td class="input_width"><g:textField name="mainCifName" value="${mainCifName}" class="input_field" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label">Negotiation Currency</span></td>
		<td class="input_width"><g:textField class="input_field" name="negotiationCurrency" id="negotiationCurrency" value="${negotiationCurrency}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Remitting Bank <span class="asterisk">*</span></span></td>
		<td class="input_width"><input class="tags_bank select2_dropdown bigdrop required" name="remittingBank" id="remittingBank"/></td>
		<td class="label_width"><span class="field_label">Negotiation Amount</span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Remitting Bank<br/>(Ref No.) <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="input_field length20 required" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}"/></td>
		<td class="label_width"><span class="field_label">Settlement Amount</span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="productAmount" value="${productAmount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Importer CIF Number</span></td>
		<td class="input_width">
			<g:textField class="input_field" name="importerCifNumber" value="${importerCifNumber}"/>
			<a href="#" class="search_btn popup_btn_cif_normal">search button</a>
		</td>
		<td><span class="field_label">Value Date</span></td>
		<td><g:textField class="datepicker_field" name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Importer CB Code</span></td>
<%--		<td class="input_width"><g:select from="${['CB Code 1','CB Code 2']}" noSelection="['':'SELECT ONE']" name="importerCbCode" class="select_dropdown"/></td>--%>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" /></td>
		<td class="label_width"><span class="field_label">Port of Origin <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:textField class="input_field" name="portOfOrigin" readonly="readonly"/></td>--%>
		<td class="input_width"><input class="tags_country select2_dropdown bigdrop required" name="originalPort" id="originalPort"/>
		<g:hiddenField name="originalPort_bspCode" value="${originalPort_bspCode}"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Importer Name<span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:textField class="input_field required" name="importerName" value="${importerName}"/></td>--%>
		<td class="input_width"><g:textArea class="textarea required" name="importerName" value="${importerName}" rows="2" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Importer Address<span class="asterisk">*</span></span></td>
		<td rowspan="2">
			<g:textArea class="textarea required" name="importerAddress" value="${importerAddress}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
		</td>
        <td><span class="field_label">Reimbursing Bank<span class="asterisk">*</span></span></td>
        <td><input class="tags_cbcode select2_dropdown bigdrop" name="reimbursingBank" id="reimbursingBank" /></td>
	</tr>
	<tr>
		<td/>
		<td/>
		<td><g:textArea name="reimbursingBankName" value="${reimbursingBankName}" class="textarea required" readonly="readonly" rows="2"/></td>

	</tr>
	<tr>
		<td></td>
		<td>
			<g:radioGroup name="individualCorporateFlag" id="individualCorporateFlag" labels="['Individual', 'Corporate']" values="['I','C']" value="${individualCorporateFlag?:'C'}">
				<label>${it.radio} ${it.label} &#160;&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Beneficiary Name</span></td>
<%--		<td class="input_width"><g:textField class="input_field required" name="beneficiaryName" value="${beneficiaryName}" /></td>--%>
		<td valign="top" rowspan="2"><g:textArea class="textarea required" name="beneficiaryName" value="${beneficiaryName}" rows="2" maxlength="50"/></td>
        <td><span class="field_label small_margin_left">Account Type<span class="asterisk">*</span></span></td>
        <td>
            <input type="radio" class="required" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" class="required" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
        </td>
	</tr>
    <tr>
    	<td/>
        <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        <input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
        <input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
        <td><span class="field_label small_margin_left">Account Number<span class="asterisk">*</span></span></td>
        <%-- <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field" /></td> --%>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" /></td>

    </tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Beneficiary Address</span></td>
		<td valign="top" rowspan="2">
			<g:textArea class="textarea" name="beneficiaryAddress" value="${beneficiaryAddress}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_beneficiary_address">...</a>
		</td>
        <td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
	</tr>
    <tr>
    	<td/>
        <td><span class="field_label small_margin_left">Reimbursing Bank Currency<span class="asterisk">*</span></span></td>
        <%-- <td><g:textField id="reimbursingBankCurrency" name="reimbursingBankCurrency" value="${reimbursingBankCurrency}" class="input_field" /></td> --%>
        <td><g:textField id="reimbursingBankCurrency" name="reimbursingBankCurrency" value="${reimbursingBankCurrency}" class="input_field required" readonly="readonly" /></td> 
    </tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script>
    $(document).ready(function() {
        var commodityCode = $('#commodityCode').val(),
            splittedCommodity;

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

        $("#remittingBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
        $("#originalPort").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${originalPort}'});
        $("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});

        //$("#reimbursingBank").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingBank}'});
        $("#reimbursingBank").setDepositoryBankDropdownWithCurrency($("#negotiationCurrency").val()).select2('data',{id: '${reimbursingBank}'});
        //$("#reimbursingBank").setDepositoryBankDropdownWithCurrency('USD').select2('data',{id: '${reimbursingBank}'});
        $("#reimbursingBank").val("${reimbursingBank}");

        $("#valueDate").datepicker({ showOn: 'both', buttonImage:$("#_datepickerImage").val(),
            changeMonth: true, changeYear: true, maxDate:new Date()
        }).attr("readonly","readonly");

        if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").attr('checked',true);
            $("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").click();
        }else if($("#temprbugl").val() || $("#tempfcdugl").val()){
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

   		if('${reimbursingBank}'){
          	$.post(autoCompleteDepositoryBankUrl, {starts_with: '${reimbursingBank}', currency: $("#negotiationCurrency").val()}, function(jsonData){
       		if(jsonData.success){
       			if(jsonData.total == 1){
       				var data = jsonData.results[0];
       				$("#glCode").val(data.glcode);
       	            $("#reimbursingBankCurrency").val(data.currency);
       	            $("#reimbursingBankName").val(data.label);
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
   		}
    });

    $("#reimbursingBank").on("change", function(e) {
        var data = $("#reimbursingBank").select2('data');
        if(data != null){
            $("#glCode").val(data.glcode);
            $("#reimbursingBankCurrency").val(data.currency);
            $("#reimbursingBankName").val(data.label);
            $("#tempfcdu").val(data.fcduAccount);
            $("#temprbu").val(data.rbuAccount);
            $("#tempfcdugl").val(data.glcodefcdu);
            $("#temprbugl").val(data.glcoderbu);

            $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
            $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
//            $("#glCode").val('');
            $("#depositoryAccountNumber").val('');
        }else{
            $("#glCode").val('');
            $("#reimbursingBankCurrency").val('');
            $("#reimbursingBankName").val('');
            $("#tempfcdu").val('');
            $("#temprbu").val('');
            $("#tempfcdugl").val('');
            $("#temprbugl").val('');
        }
        if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=RBU]").attr('checked',true);
            $("#accountType[value=RBU]").click();
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

    });

    $("input[name='accountType']").on("click", function(e) {
        //alert($("input[name='accountType']:checked").val());
        if($("input[name='accountType']:checked").val() == 'RBU') {
            $("#depositoryAccountNumber").val($("#temprbu").val());
            $("#glCode").val($("#temprbugl").val());
        } else {
            $("#depositoryAccountNumber").val($("#tempfcdu").val());
            //$("#glCode").val($("#reimbursingBank").select2('data').glcodefcdu);
            $("#glCode").val($("#tempfcdugl").val());
        }
    });
</script>
<g:if test="${cifNumber}">
<g:render template="../commons/popups/cif_search_main"/>
<g:javascript src="popups/cif_main_search_popup.js" />
</g:if>

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