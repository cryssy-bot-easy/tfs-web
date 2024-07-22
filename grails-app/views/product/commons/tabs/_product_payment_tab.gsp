<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: 
		1. Tab validation (Redmine# 4196)
		2. Missing Save Button in EBP Nego and EBC Settlement Data Entry (Redmine# 4213)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 04/03/2017 (tfs-web Rev# 7433)
		2. 05/23/2017 (tfs-web Rev# 7497)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Added 'data-orig' attribute in every input field.
		2. Added save button for EBP Nego Data Entry.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _product_payment_tab.gsp
--%>

%{--<g:javascript src="grids/cash_lc_payment_jqgrid.js" />--}%
<g:javascript src="new/import_advance/product_payment_grid.js" />
<g:javascript src="utilities/ets/commons/cash_lc_payment_tab_utility.js" />

<script type="text/javascript">
    var convertRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertCashRates')}';
    var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
    %{--var productChargeUrl = '${g.createLink(controller:'product', action:'displayProductPaymentsGrid')}';--}%
    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    productChargeUrl += "&referenceType=" + $("#referenceType").val();
    productChargeUrl += "&serviceType="+$("#serviceType").val();
    productChargeUrl += "&documentType="+$("#documentType").val();
    productChargeUrl += "&documentClass="+$("#documentClass").val();
    productChargeUrl += "&form=product";
    
    var windowed = ${windowed ?: false};

    var recomputeCashPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';

</script>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="lcPayment" />

<g:hiddenField name="savedCurrency" value="${currency ?: 'PHP'}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
	
    <g:if test="${!"BP".equals(documentClass)}"><span class="title_label">${titleLabel ?: 'Cash Details'}</span></g:if>
    <table class="charges_table">
        <tr>
            <td><span class="field_label"> ${totalAmountDueCurrencyLabel}</span></td>
            <td>
                <span class="charges_currency" id="totalAmountDueLcCurrency">${currency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${totalAmountDueLc ?: cashAmount ?: amountDue ?: amount}" name="totalAmountDueLc" readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> ${totalAmountDueAmountLabel}</span></td>
            <td>
                <span class="charges_currency" id="remainingBalancLcCurrency">${currency}</span>
            </td>
            <td><g:textField class="input_field_right" value="${remainingBalanceLc}" name="remainingBalanceLc" readonly="readonly"/></td>
        </tr>
    </table>
<br />
<table>
    <tr>
        <td width="235"><span class="field_label">&nbsp;Settlement Currency <br /></span></td>
        <td>
            <%-- Auto Complete --%>
            <input class="tags_currency select2_dropdown bigdrop settleCurrDd" name="settlementCurrencyLc" id="settlementCurrencyLc" data-orig="${settlementCurrencyLc}" data-condition="${documentClass == 'BP' && documentType == 'DOMESTIC' && serviceType == 'NEGOTIATION'}" />
        </td>
    </tr>
</table>

<g:if test="${currency}">
    <div class="grid_wrapper"> %{--JQGRID--}%
        <table class="foreign_exchange" id="forex_product">
            <tr>
                <th class="rates">Rates</th>
                <th class="rate_description">Rate Description</th>
                <th class="pass_on_rate">Pass-on Rate</th>
                <th class="special_rate">Special Rate</th>
            </tr>
            <g:each in="${exchange}" var="temp" status="i" >
                <tr>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="rates">${temp.rates}</td>
                    </g:if>
                    <g:else>
                        <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}" /></td>
                    </g:else>
                    <td>${temp.rate_description_lbp}</td>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="urr">
                            <g:textField name="${temp.rates+'_text_pass_on_rate_urr'}" id="${temp.rates+'_text_pass_on_rate_urr'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
                             <g:hiddenField name="${temp.rates+'_pass_on_rate_cash_urr'}" id="${temp.rates+'_pass_on_rate_cash_urr'}" class="${temp.rates+'_pass_on_rate'}" value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                        </td>
                        <td class="urr">
                            <g:textField name="${temp.rates+'_text_special_rate_urr'}" id="${temp.rates+'_text_special_rate_urr'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                            <g:hiddenField name="${temp.rates+'_special_rate_cash_urr'}" id="${temp.rates+'_special_rate_cash_urr'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_urr'}" class="${temp.rates+'_urr'}" value="${temp.special_rate_cash ?: temp.special_rate}"/>
                        </td>
                        <!-- <td class="urr">${temp.pass_on_rate.toString()}</td>
                        <td class="urr">${temp.special_rate.toString()}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td> -->
                    </g:if>
                    <g:else>
						<%-- added read only --%>
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" readonly="readonly" value="${temp.pass_on_rate}" data-orig="${temp.pass_on_rate}" /><g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}" data-orig="${temp.pass_on_rate}" /></td>
<%--                        <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}" data-orig="${temp.special_rate}"/><g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}" data-orig="${temp.special_rate}" /></td>--%>
						<td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.text_special_rate ?: temp.special_rate}" data-orig="${temp.text_special_rate ?: temp.special_rate}"/> <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}" data-orig="${temp.special_rate}"/></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>
<table class="popup_full_width">
    <tr>
        <td width="240">Pass-on rates confirmed by: <g:if test="${exchange.size() > 1}"><span class="asterisk"> * </span></g:if></td>
        <td><g:textField name="passOnRateConfirmedByCash" id="passOnRateConfirmedByCash" class="input_field ${exchange.size() > 1 ? 'required' : ''}" data-orig="${passOnRateConfirmedByCash ?: ''}" value="${passOnRateConfirmedByCash}" /></td>
        %{--if foreign--}%
        <td>
            <input type="button" class="input_button_long" value="Recompute Charge" name="recomputeChargeBtnCashLc" id="recomputeChargeBtnCashLc"/>
        </td>
    </tr>
</table>
<br />
<table class="charges_table">
    <tr>
        <td width="235">
            <span class="field_label" id="paymentDescription"> ${amountInPaymentInCurrencyLabel}</span>
        </td>
        <td>
            <span class="charges_currency" id="cashAmountInSettlementCurrency"></span>
        </td>
		<%--    Vico - bug4216 removed editable    --%>
        <td><g:textField class="input_field_right numericCurrency" name="cashAmountInSettlement"/></td>
    </tr>
    <tr>
        <td width="235">
            <span class="field_label"> ${amountInPaymentInDocumentCurrencyLabel}</span>
        </td>
        <td>
            <span class="charges_currency" id="cashAmountInLcCurrency">${currency}</span>
        </td>
        <%--    Vico - bug4216 removed editable    --%>
        <td><g:textField class="input_field_right numericCurrency" name="cashAmountInLc"/></td>
    </tr>
</table>
<br/>

<%-- ADDED SAVE BUTTON --%>
<g:if test="${((documentClass in["BP"]) && referenceType?.equals('DATA_ENTRY'))}">
    %{--<g:render template="../product/commons/save_buttons" />--}%
    <table class="buttons_for_grid_wrapper saveButtonsContainer hideSave">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="saveConfirmProductPayment" class="input_button" style="margin-right: 41px;" value="Save" /></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="cancelConfirmProductPayment" class="input_button_negative" style="margin-right: 41px;" value="Cancel" /></td>
        </tr>
    </table>
	<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement" disabled="disabled"/>
</g:if>
<g:else>
	<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement" disabled="disabled"/>
</g:else>
<br /><br/>


    <span class="title_label">Payment Summary for ${(documentClass in ['BC', 'BP']) ? 'Export Bills' : 'Cash LC'}</span>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_cash_payment_summary"> </table>
    <div id="grid_pager_cash_payment_summary"></div>
    <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
    <tr>
        <td width="235"><span class="field_label"> ${totalAmountInCurrencyLabel} </span></td>
        <td><g:textField class="input_field_right" value="" name="totalAmountOfPaymentLc" readonly="readonly"/></td>
    </tr>
    <tr>
        <td width="180"><span class="field_label"> ${excessAmountInCurrencyLabel} </span></td>
        <td><g:textField class="input_field_right" value="" name="excessAmountLc" readonly="readonly"/></td>
    </tr>
</table>
<br/>

<g:if test="${!((documentClass in["IMPORT_ADVANCE", "BP"]) && referenceType?.equals('DATA_ENTRY')) || referenceType == 'ETS'}">
    %{--<g:render template="../product/commons/save_buttons" />--}%
    <table class="buttons_for_grid_wrapper saveButtonsContainer">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="saveConfirmProductPayment" class="input_button" value="Save" /></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="cancelConfirmProductPayment" class="input_button_negative" value="Cancel" /></td>
        </tr>
    </table>
</g:if>

<script>
	var autoCompleteUsdPhpOnlyCurrencyUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteUsdPhpOnlyCurrency")}';
    $(document).ready(function() {

		if (${documentClass == 'BP' && documentType == 'FOREIGN' && serviceType == 'NEGOTIATION' && referenceType == 'DATA_ENTRY'}) {
	    	function init() {
	    		var data = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
				$(".hideSave").attr("hidden", data.length === 0);
				$("#popup_btn_mode_of_payment_cash").attr("hidden", data.length > 0);
	       	}
        
			function setupHidden(element) {
	           	var value = element.val(), 
	           		orig = element.attr("data-orig"),
	           		condition = value.toString().toUpperCase() === orig.toString().toUpperCase();
	
	           	$("#popup_btn_mode_of_payment_cash").attr("hidden", !condition);
	       		$(".hideSave").attr("hidden", condition);
	        }

	        $("#passOnRateConfirmedByCash").change(function() {
		        $("#passOnRateConfirmedBySettlement").val($(this).val());
		        $("#passOnRateConfirmedByCharges").val($(this).val());
	        	setupHidden($(this));
	        });

	        $("#popup_btn_mode_of_payment_cash").click(function() {
		        setTimeout(function() {
					$("#interestRate").val(0.00);
		        }, 500);
		    });
	
	        $("#USD-PHP_text_special_rate").change(function() {
	        	setupHidden($(this));
	        });
	
	        $("#EUR-USD_text_special_rate").change(function() {
	        	setupHidden($(this));
	        });
	        
	        $("#save_modeOfPaymentCharges").click(function() {
	        	if ($("#tabs").children(".ui-state-active").attr("aria-labelledby") === "cashLcPaymentTab" && $("[name=modeOfPaymentCharges]").val()) {
		        	$(".hideSave").attr("hidden", false);
					$("#popup_btn_mode_of_payment_cash").attr("hidden", true);
	            }
	        });
	
	        $("#grid_list_cash_payment_summary").mouseover(function() {
		        if ($("#tabs").children(".ui-state-active").attr("aria-labelledby") === "cashLcPaymentTab") {
					$("#grid_list_cash_payment_summary td[aria-describedby=grid_list_cash_payment_summary_deletePaymentSummary]").children().click(function() {
						if ($("#passOnRateConfirmedByCash").val() === $("#passOnRateConfirmedByCash").attr("data-orig")
								&& $("#USD-PHP_text_special_rate").val() === $("#USD-PHP_text_special_rate").attr("data-orig")) {
							$(".hideSave").attr("hidden", true);
							$("#popup_btn_mode_of_payment_cash").attr("hidden", false);

							$("#btnAlertConfirm").click(function() {
								setTimeout(function() {
									$("#saveConfirmProductPayment").click();
								}, 500);
							});
						} else {
							$(".hideSave").attr("hidden", false);
							$("#popup_btn_mode_of_payment_cash").attr("hidden", true);
						}
					});
		
					$("#grid_list_cash_payment_summary td[aria-describedby=grid_list_cash_payment_summary_pay]").children().click(function() {
						if ((!$("#paymentTerm").val() || $(".hideSave").attr("hidden") === "false" 
								|| $(".hideSave").attr("hidden") === false || $(".hideSave").attr("hidden") === undefined) && $(this).val() === "Pay") {
							triggerAlertMessage("Save the Settlement Mode first.");
							$("#close_loanDetails").trigger("click");
						}
					});
		        }
	      	});
	      	
			init();
		}

	<%-- 04192017 - Onload function to call recompute - Added by Pat --%>
	$("#recomputeChargeBtnCashLc").click();
        
    <g:if test="${documentClass == 'BP' && documentType == 'DOMESTIC' && serviceType == 'NEGOTIATION'}">
        $("#settlementCurrencyLc").setCurrencyDropdownUsdPhpOnly($(this).attr("id"));
    </g:if>
    <g:elseif test="${documentClass == 'BP' && documentType == 'FOREIGN' && serviceType == 'NEGOTIATION' && referenceType == 'DATA_ENTRY'}">
    	$("#settlementCurrencyLc").removeClass("tags_currency select2_dropdown bigdrop").addClass("input_field").val("USD").attr("readonly", "readonly");
    	$("#popup_btn_mode_of_payment_cash").removeAttr("disabled");

    	if ($("#saveConfirmProductPayment").length > 0) {
            $("#saveConfirmProductPayment").click(function() {
                if('undefined' !== typeof validateExcessChargesValidationUtils && 
                        !validateExcessChargesValidationUtils()){
                   return; 
                }
                
            	if(validateExportTab("#productPaymentTabForm") > 0){
                    $("#alertMessage").text("Please fill in all the required fields.");
                    triggerAlert();
                } else {
					function validateField() {
						var error = 0;
						if ($("#passOnRateConfirmedByCash").val() !== $("#passOnRateConfirmedByCash").attr("data-orig")
								|| $("#USD-PHP_text_special_rate").val() !== $("#USD-PHP_text_special_rate").attr("data-orig")) {
							error = 1;
						}
						return error;
					}
                    
	                var productSummaryData = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	                if (productSummaryData.length === 0 || productSummaryData[0].status === 'Not Paid') {
			            $("#documentPaymentSummary").val(JSON.stringify(productSummaryData));
		                mCenterPopup($("#loading_div"), $("#loading_bg"));
		            	mLoadPopup($("#loading_div"), $("#loading_bg"));
		                $("#productPaymentTabForm").submit();
                	} else if (productSummaryData.length > 0 && validateField() > 0) { 
						console.log("nice nasa else")
						triggerAlertMessage("Delete the Settlement Mode first.");
						//return;
                	}
                }
            });
        }

        if ($("#cancelConfirmProductPayment").length > 0) {
            $("#cancelConfirmProductPayment").click(function() {
                mDisablePopup($("#productPaymentDiv"), $("#productPaymentBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            });
        }
    </g:elseif>
    <g:elseif test="${documentClass == 'BP' && documentType == 'FOREIGN' && serviceType == 'NEGOTIATION' && referenceType == 'ETS'}">
	    $("#settlementCurrencyLc").removeClass("tags_currency select2_dropdown bigdrop").addClass("input_field").val("USD").attr("readonly", "readonly");
		$("#popup_btn_mode_of_payment_cash").removeAttr("disabled");
    </g:elseif>
    <g:else>
    	$("#settlementCurrencyLc").setSettlementCurrencyDropdown($(this).attr("id")).select2('data', {id: '${settlementCurrencyLc}'});
    </g:else>
        hideUnrelatedExchangeRates();
        onSettlementCurrencyCashChange();
        loadRelatedExchangeRates();
        if ($.isFunction(window.checkForOtherCurrency)) {
            checkForOtherCurrency();
        }

        if ($("#saveConfirmProductPayment").length > 0 && !${documentClass == 'BP' && documentType == 'FOREIGN' && serviceType == 'NEGOTIATION' && referenceType == 'DATA_ENTRY'}) {
            $("#saveConfirmProductPayment").click(function() {
                console.log("nadale na!!");
                if('undefined' !== typeof validateExcessChargesValidationUtils && 
                        !validateExcessChargesValidationUtils()){
                   return; 
                }
            	if(validateExportTab("#productPaymentTabForm") > 0){
                    $("#alertMessage").text("Please fill in all the required fields.");
                    triggerAlert();
                } else {
	                var productSummaryData = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	                $("#documentPaymentSummary").val(JSON.stringify(productSummaryData));
	                mCenterPopup($("#loading_div"), $("#loading_bg"));
	            	mLoadPopup($("#loading_div"), $("#loading_bg"));
	                $("#productPaymentTabForm").submit();
                }
            })
        }

        if ($("#cancelConfirmProductPayment").length > 0) {
            $("#cancelConfirmProductPayment").click(function() {
                mDisablePopup($("#productPaymentDiv"), $("#productPaymentBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            })
        }
    <g:if test="${documentClass == 'BP' && serviceType == 'NEGOTIATION'}">
    	$("#cashAmountInLc").attr("readonly", "readonly");
    	$("#cashAmountInSettlement").attr("readonly", "readonly");
    	$("#remainingBalanceLc").change(function(){
    		if($(this).val() != 0.00){
        		$("#cashAmountInLc").val($(this).val()).attr("readonly", "readonly").change();
    	    	$("#popup_btn_mode_of_payment_cash").removeAttr("disabled");
    	   	} else {
    	   		//Vico - commented and added line 227 for bug 4216
    	   		//to display amount of nego payment even after saving.
        	   	//$("#cashAmountInLc").attr("readonly", "readonly");
    	    	//$("#cashAmountInSettlement").attr("readonly", "readonly");
    	   		$("#cashAmountInLc").val($("#totalAmountDueLc").val()).change();
       	   	}
       	});
    </g:if>
    
    });
    <g:if test="${documentClass == 'BP'}">
	function setPaymentsforBP(){
		
	}
    </g:if>
</script>

<g:if test="${documentClass?.equals('BP') && serviceType?.equalsIgnoreCase('SETTLEMENT')}">
<script>
	var updatePassOnRatesUrl = '${g.createLink(controller: (documentType == 'DOMESTIC' ? "domesticBillsPurchase" : "exportBillsPurchase"), action: "updatePassOnRates")}';
	$(function(){
		$("#passOnRateConfirmedByCash").change(function(){
			console.log("test");
			if($(this).val()){
			$.post(updatePassOnRatesUrl,{passOnRateConfirmedByCash: $(this).val(), tradeServiceId: '${tradeServiceId}'});
			}
		});
	});
</script>
</g:if>