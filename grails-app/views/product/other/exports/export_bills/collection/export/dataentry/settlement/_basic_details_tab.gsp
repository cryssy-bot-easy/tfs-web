<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Corres Bank in EBC Settlement has no value and not enterable. (Redmine# 4170)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 02/23/2017 (tfs-web Rev# 7408)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Corres Bank was disabled if the selected option in EBC is A - Swift Code
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="corresBankFlag" value="${corresBankFlag}"/>
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<g:hiddenField name="buyerName" value="${buyerName}"/>
<g:hiddenField name="buyerAddress" value="${buyerAddress}"/>
<g:hiddenField name="sellerName" value="${sellerName}"/>
<g:hiddenField name="bookingCurrency" id="bookingCurrencyHidden" value="${bookingCurrency}" />
<g:hiddenField name="loanAmount" id="loanAmountHidden" value="${loanAmount}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode}"/>

<%--FOR AMLA--%>

<g:hiddenField name="amlaIBTFlag" value="${amlaIBTFlag}" />
<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />
<g:hiddenField name="amlaIBTFlagLc" value="${amlaIBTFlagLc}" />
<g:hiddenField name="amlaIBTFlagNLc" value="${amlaIBTFlagNLc}" />
<g:hiddenField name="amlaCasaFlagLc" value="${amlaCasaFlagLc}" />
<g:hiddenField name="amlaCasaFlagNlc" value="${amlaCasaFlagNlc}" />
<g:hiddenField name="amlaIBTFlagAmount" value="${amlaIBTFlagAmount}"/>
<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>
<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>
<g:hiddenField name="amlaCasaFlagFxCurrency" value="${amlaCasaFlagFxCurrency}"/>
<g:hiddenField name="amlaIBTFlagFxCurrency" value="${amlaIBTFlagFxCurrency}"/>
<g:hiddenField name="amlaIBTFlagFx" value="${amlaIBTFlagFx}" />
<g:hiddenField name="amlaCasaFlagFx" value="${amlaCasaFlagFx}" />
<g:hiddenField name="amlaIBTFlagPhp" value="${amlaIBTFlagPhp}" />
<g:hiddenField name="amlaCasaFlagPhp" value="${amlaCasaFlagPhp}" />

<%--
 * PROLOGUE
 * SCR/ER Description: To add validation on proceeds amount and auto-compute of amount for credit.
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Validate proceeds amount that should not be zero or negative
 *	Date deployment: 6/16/2016 
 *	Member Type: GSP
 *	Project: Web
 *	Project Name: _basic_details_tab.gsp
--%>
<%-- 
(revision)
    (revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    Program [Revision:] add new Fields TIN, Exporter Code, Particulars, Commodity Code and their behavior. Set tin number field name to tempTinNumber to prevent saving of 2 tin numbers.
    PROJECT: GSP
    MEMBER TYPE  : Web
    Project Name: _basic_details_tab.gsp
--%>

<%--<g:hiddenField name="corresCheck" value="${corresCheck ?: !corresBankAccountCode ? 1 : 0}"/>--%>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/> </td>
		<td class="label_width"> <span class="field_label"> Corres Bank <span class="asterisk"> * </span></span> </td>
        <td class="input_width"> <g:textField class="select2_dropdown required" name="corresBankCode" readonly="readonly" value="${corresBankCode}"/> </td>
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
		<td class="label_width"> <span class="field_label">TIN <span class="asterisk">*</span></span> </td>
        <td class="input_width"><g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" maxLength="20"/> </td>
		<td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label">Exporter Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Particulars</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="particularsLabel" id="particularsLabel" />
            <g:hiddenField name="particulars" value="${particulars}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span></span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
    </tr>
</table>
<br>

<span class="tab_titles"> EBC Details </span>

<table class="tabs_forms_table">
    <tr>
		<td class="label_width"> <span class="field_label"> Currency Code </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="currencyCode" readonly="readonly" value="${currency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="currency" readonly="readonly" value="${currency}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
	</tr>
</table>
<br>

<span class="tab_titles"> EBP Details </span>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="bpCurrency" readonly="readonly" value="${bpCurrency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Amount </span> </td>
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
		  	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" >
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Export proceeds to be </span> <br />
			<span class="field_label"> remitted via PDDTS?<span class="asterisk"> * </span>  </span>
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
    $(document).ready(function() {
    	var commodityCode = $('#commodityCode').val(),
	        particulars = $('#particulars').val(),
	        splittedCommodity,
	        splittedParticulars;

    	$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
        $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: '${particularsLabel}'});

        $("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });

        if(commodityCode) {
            $('#commodityCode').val(commodityCode.toString().trim());
            $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                }
            });
        }

        $("#particularsLabel").change(function() {
            splittedParticulars = $(this).val().split("-");
            if(splittedParticulars.length > 0) {
                $('#particulars').val(splittedParticulars[0].toString().trim());
            }
        });
        
        if(particulars) {
            $('#particulars').val(particulars.toString().trim())
            $.get(autoCompleteParticularsUrl, {starts_with: particulars.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                }
            });
        }

        $('#tempTinNumber').change(function() {
            $('#tinNumber').val($('#tempTinNumber').val());
        });
        
		if ($("#corresBankFlag").val() == "A") {
			$("#corresBankCode").attr("disabled", "disabled");
		} else {
			$("#corresBankCode").removeAttr("disabled");
			$("#corresBankCode").removeAttr("readonly");
		}

        <%-- On page load, compute amount for credit --%>
		// Check if tx has EBC amount and proceeds amount
		if( $("#amount").val() != "" && $("#proceedsAmount").val() != "" ){
			var ebcAmtVar = $("#amount").val();
			var amtForCreditVar = 0;
			var proceedsAmtVar = $("#proceedsAmount").val();
			ebcAmtVar = ebcAmtVar.replace(/,/g/'');
			ebcAmtVar = parseFloat(ebcAmtVar);
			proceedsAmtVar = proceedsAmtVar.replace(/,/g/'');
			proceedsAmtVar = parseFloat(proceedsAmtVar);
			// Check if proceeds amount is greater than ebc amount
			if( proceedsAmtVar > ebcAmtVar ){ 
				triggerAlertMessage("Proceeds amount cannot be greater than EBC amount.");
    	        $("#proceedsAmount").val("");
        	    $("#amountForCredit").val("");
			} else {
				// If EBC has EBP
				if( $("#bpCurrency").val() != "" ){
					// Check if empty or NaN
					if( $("#bpAmount").val() != "" ){
						// Compute for amount for credit
						var bpAmtVar = $("#bpAmount").val();
						bpAmtVar = bpAmtVar.replace(/,/g/'');
						bpAmtVar = parseFloat(bpAmtVar);
						amtForCreditVar = proceedsAmtVar - bpAmtVar;
						$("#amountForCredit").val(formatCurrency(amtForCreditVar));
					}
				} else {
				// If pure EBC
					// Check if empty or NaN
					if( $("#bpAmount").val() == "" ){
						// Compute for amount for credit after setting bp amount to zero
						var bpAmtZero = 0; 
						amtForCreditVar = proceedsAmtVar - bpAmtZero;
						$("#amountForCredit").val(formatCurrency(amtForCreditVar));
					}
				}
			}																				
		}

		<%-- 04/04/2017 - Changed to keyup function so that Amount for Credit will not be empty when saved to db  upon pressing Enter key --%>
    	$("#proceedsAmount").keyup(function() {
<%--    		$("#paymentMode").val() != "LC" && --%>
            if (parseFloat($(this).val().replace(/,/g,"")) > parseFloat($("#amount").val().replace(/,/g,""))){
            	triggerAlertMessage("Proceeds amount cannot be greater than EBC amount.");
            	$(this).val("");
            	$("#amountForCredit").val("");
            } else {
	            var creditAmount;
	
	            if ($("#proceedsAmount").val() != "") {
	                var bpAmountVar = $("#bpAmount").val().replace(/,/g,"");
	                var proceedsAmountVar = $("#proceedsAmount").val().replace(/,/g,"");
	
	                var bpAmount = parseFloat(bpAmountVar);
	                var proceedsAmount = parseFloat(proceedsAmountVar);
	
	                if($("#bpCurrency").val()){
		                if (proceedsAmount < bpAmount) {
		                    creditAmount = 0;
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
            }
        });
            $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});
            $("#corresBankCode").on("change", function(e) {
    	    	var data = $("#corresBankCode").select2('data');
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
            $.post(autoCompleteDepositoryBankUrl, {starts_with: '${corresBankCode}'}, function(jsonData){
    			if(jsonData.success){
    				if(jsonData.total == 1){
    					var data = jsonData.results[0];
    					$("#corresBankCode").val(data.id);
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
        
		//Fix for redmine 4227 - validation on proceeds amount where ist should not allow zero amount.
        $("#proceedsAmount").on('blur', function(){

        	if (parseFloat($(this).val().replace(/,/g,"")) == 0){
            	triggerAlertMessage("Proceeds amount should not be zero.");
            	$(this).val("");
            	$("#amountForCredit").val("");
            }

        	$(this).focus();
            
        });
    });
</script>