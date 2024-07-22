
<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _charges_payment_tab.gsp
--%>

%{--<g:javascript src="grids/charges_payment_summary_jqgrid.js" />--}%
<g:javascript src="new/import_advance/charges_payment_grid.js" />
<g:javascript src="utilities/ets/commons/charges_payment_tab_utility.js"/>

<script type="text/javascript">
    var windowed = "${windowed}";
    var serviceChargeUrl = '${g.createLink(controller:'product', action:'displayServiceChargePaymentsGrid')}';
    serviceChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    serviceChargeUrl += "&referenceType=" + $("#referenceType").val();
    serviceChargeUrl += "&documentClass=" + $("#documentClass").val();
</script>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="chargesPayment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

    <table class="charges_table">
        <tr>
            <td width="160"><span class="field_label"> Total Amount Dues </span></td>
            <td>
                <span class="charges_currency" id="totalAmtDueCurrency"></span>
            </td>
            <td><g:textField class="input_field_right" value="${totalAmountDue}" name="totalAmountDue" readonly="readonly"/></td>
        </tr>
        <tr>
            <td> &#160; </td>
        </tr>
        <tr>
            <td><span class="field_label"> Remaining Balance </span></td>
            <td>
                <span class="charges_currency" id="remainingBalanceCurrency"></span>
            </td>
            <td><g:textField class="input_field_right" value="${remainingBalance}" name="remainingBalance" readonly="readonly"/></td>
        </tr>
    </table>

<br/>

<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label"> Amount of Payment - Charges <br/>(in Settlement Currency) </span> </td>
        <td>
            <span class="charges_currency" id="amountOfPaymentChargesSettlementCurrency"></span>
        </td>
        <td class="editable disabled"><g:textField class="input_field_right numericCurrency" name="amountOfPaymentCharges" data-orig="${amountOfPaymentCharges ?: 0.00}" /></td>
    </tr>
</table>

<div class="chargesPaymentButtons">
    <table>
        <g:if test="${!(documentClass in ['BP', 'BC'])}">
            <tr>
                <td><input type="button" class="input_button_long" value="Update Balances" id="recomputeBalanceBtn"/></td>
            </tr>
        </g:if>
        <tr>
            <td><input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" disabled="disabled"/></td>
        </tr>
    </table>
</div>
<br/>
<br/>
<br/>


<span class="title_label"> Payment Summary for Charges </span>
<div class="grid_wrapper fix">
    <table id="grid_list_charges_payment"></table>
    <g:hiddenField name="chargesPaymentSummary" value="" />
</div>
<br/>
<table class="charges_payment_table">
    <tr>
        <td width="195"> <span class="field_label"> Total Amount of Payment - Charges <br/>(in Settlement Currency)</span> </td>
        <td><g:textField name="totalAmountOfPaymentCharges" value="${totalAmountOfPaymentCharges}" class="input_field_right" readonly="readonly"/></td>
    </tr>
    <tr>
        <td> <span class="field_label"> Excess Amount - Charges <br/>(in Settlement Currency) </span> </td>
        <td><g:textField name="excessAmountCharges" value="${excessAmountCharges}" class="input_field_right" readonly="readonly"/></td>
    </tr>
</table>
<br />

<g:each in="${exchange}" var="temp" status="i">
    <g:hiddenField name="RATE_NAME_${i}" value="${temp.rates}"/></td>
    <g:hiddenField name="RATE_DESC_${i}" value="${temp.rate_description}"/></td>
</g:each>

<div id="domMessage" style="display:none;">
    <h1>We are processing your request.  Please be patient.</h1>
</div>

%{--<g:if test="${!(documentClass in ['BP', 'BC'])}">--}%
    <g:if test="${(("DATAENTRY".equals(referenceType) || "DATA_ENTRY".equals(referenceType)) &&
            !(documentClass in ['BP', 'BC', 'IMPORT_ADVANCE'])) ||
    "ETS".equals(referenceType)}">
        <table class="buttons_for_grid_wrapper saveButtonsContainer">
            <tr>
                <%-- BUTTON --%>
                <td><input type="button" id="saveConfirmChargesPayment" class="input_button" value="Save" /></td>
            </tr>
            <tr>
                <%-- BUTTON --%>
                <td><input type="button" id="cancelConfirmChargesPayment" class="input_button_negative" value="Cancel" /></td>
            </tr>
        </table>

        <script type="text/javascript">
            $(document).ready(function() {
                if ($("#saveConfirmChargesPayment").length > 0) {
                    $("#saveConfirmChargesPayment").click(function() {
                        if('undefined' !== typeof validateExcessChargesValidationUtils && 
                                !validateExcessChargesValidationUtils()){
                           return; 
                        }
                        
                        var serviceSummaryData = $("#grid_list_charges_payment").jqGrid("getRowData");
                        $("#chargesPaymentSummary").val(JSON.stringify(serviceSummaryData));

                        mCenterPopup($("#loading_div"), $("#loading_bg"));
    	            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                        $(".saveAction").show();
                    	$(".cancelAction").hide();
//                        mCenterPopup($("#chargesPaymentDiv"), $("#chargesPaymentBg"));
//                        mLoadPopup($("#chargesPaymentDiv"), $("#chargesPaymentBg"));

                        $("#chargesPaymentTabForm").submit();
                    })
                }

                if ($("#cancelConfirmChargesPayment").length > 0) {
                    $("#cancelConfirmChargesPayment").click(function() {
                        mDisablePopup($("#chargesPaymentDiv"), $("#chargesPaymentBg"));
                        location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
                    })
                }
            });
        </script>
    </g:if>
%{--</g:if>--}%

<script>
$(function() {
	if($("#remainingBalance").val() != "0.00"){
    	$("#amountOfPaymentCharges").val($("#remainingBalance").val());
    	$("#amountOfPaymentCharges").attr("data-orig", $("#remainingBalance").val());
    }else{
		$("#amountOfPaymentCharges").val("0.00");
		$("#amountOfPaymentCharges").attr("data-orig", "0.00");
    }
	$("#remainingBalance").change(function(){
    	if($("#remainingBalance").val() != "0.00"){
        	$("#amountOfPaymentCharges").val($("#remainingBalance").val());
	    	$("#amountOfPaymentCharges").attr("data-orig", $("#remainingBalance").val());
        }else{
    		$("#amountOfPaymentCharges").val("0.00");
			$("#amountOfPaymentCharges").attr("data-orig", "0.00");
        }
	});
});
</script>