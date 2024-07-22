<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

    <table class="tabs_forms_table">
        <tr>
            <td class="label_width"><span class="field_label"> e-TS Number </span></td>
            <td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId ?: etsNumber}"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> e-TS Date </span></td>
            <td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
        </tr>
        <tr>
            <td><span class="field_label"> Processing Unit Code </span></td>
            <td><g:select name="processingUnitCode" from="${['909']}" class="select_dropdown" value="${processingUnitCode ?: '909'}" noSelection="${['':'SELECT ONE...']}"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> Document Number </span></td>
            <td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> Import Advance Currency</span></td>
            <td>
                <input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />
            </td>
        </tr>
        <tr>
            <td><span class="field_label"> Import Advance Amount</span></td>
            <td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" /></td>
        </tr>
        <tr>
            <td><span class="field_label"> With 2% CWT?<span class="asterisk"> *</span> </span></td>
            <td>
                <g:radioGroup labels="['Yes','No']" values="['Y','N']" name="cwtFlag" value="${cwtFlag ?: 'N'}"><label>${it.radio} <g:message code="${it.label}" /></label> &#160;</g:radioGroup>
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
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

    function onChangeCurrency() {
        $("#totalAmountDueLcCurrency").text($("#currency").val());
    }

    function validateExcessChargesValidationUtils(){
    	var excessChargesError=0;
    	var hasRemittanceOrCheckCash=false;
    	var hasRemittanceOrCheckCharges=false;
        //validate excess charges in cash lc payment tab
        if($("#grid_list_cash_payment_summary").length > 0){
        	$.each($("#grid_list_cash_payment_summary").jqGrid("getRowData"),function(idx,val){
        		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
        			val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
        			hasRemittanceOrCheckCash=true;
        		}
        	});
        } else if($("#grid_list_refund_branch").length > 0){
        	if($("#grid_list_refund_branch").jqGrid('getGridParam', 'records') > 0){
        	$.each($("#grid_list_refund_branch").jqGrid("getRowData"),function(idx,val){
        		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
        			val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
        			hasRemittanceOrCheckCash=true;
        		}
        	});
        	} else {
        		triggerAlertMessage("Please add payment for transaction.");
        		excessChargesError++;
        	}
        }
        
        //validate excess charges in charges payment tab
        if('undefined' !== typeof $("#grid_list_charges_payment")){
        	$.each($("#grid_list_charges_payment").jqGrid("getRowData"),function(idx,val){
        		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
        				val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
        			hasRemittanceOrCheckCharges=true;
        		}
        	});
        }
        
        if(!hasRemittanceOrCheckCash && $("#excessAmountLc").length > 0){
        	if(parseInt($("#excessAmountLc").val(),10) > 0){
        		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance or Check");
        		excessChargesError++;
        	}
        } else if(!hasRemittanceOrCheckCash && $("#excessAmount").length > 0){
        	if(parseInt($("#excessAmount").val(),10) > 0){
        		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance");
        		excessChargesError++;
        	}
        }

        if(!hasRemittanceOrCheckCharges && 'undefined' !== typeof $("#excessAmountCharges")){
        	if(parseInt($("#excessAmountCharges").val(),10) > 0){
        		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance or Check");
        		excessChargesError++;
        	}
        }

        if(excessChargesError > 0){
        	return false;
        }else{
        	return true;
        }
    }
    
    $(document).ready(function() {
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency ?: 'PHP'}'});
        $("#currency").change(onChangeCurrency);

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
    });
</script>