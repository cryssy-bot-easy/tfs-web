<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="sellerName" value="${sellerName}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode ?: '909'}"/>


<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> <span class="field_label"> Document Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> TS Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="tradeServiceReferenceNumber" readonly="readonly" value="${tradeServiceReferenceNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Process Date </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
    </tr>
</table>
<span class="tab_titles"> DBP Details </span>
<table class="tabs_forms_table">
<%--    <tr>--%>
<%--        <td class="label_width"> <span class="field_label"> Partial ? </span> </td>--%>
<%--        <td class="input_width">--%>
<%--            <g:checkBox name="partialNegoFlag" />--%>
<%--            <g:hiddenField id="partialNego" name="partialNego" value="${partialNego ?: "off"}" />--%>
<%--        </td>--%>
<%--    </tr>--%>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Currency </span> </td>
        <td class="input_width">
            <g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/>
        </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Amount </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Proceeds Amount (in Negotiation Currency)<span class="asterisk"> * </span> </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="proceedsAmount" value="${proceedsAmount}" /> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Amount Due </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amountDue" readonly="readonly" value="${amountDue}" /> </td>
    </tr>
</table>
<br />
<span class="tab_titles"> Bills Purchased Loan to be Settled </span>
<br />
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> <span class="field_label"> PN Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="pnNumber" readonly="readonly" value="${pnNumber}"/> </td>
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
    function computeCorresCharge() {
        var amount = parseFloat($("#amount").val().replace(/,/g,""));
        var proceedsAmount = $("#proceedsAmount").val().replace(/,/g,"");

        if (proceedsAmount == "") {
            $("#amountDue").val("");
            return;
        }

        var amountDue = amount - proceedsAmount;

        if (amountDue < 0) {
            amountDue = 0;
        }
        $("#amountDue").val(formatCurrency(amountDue));
    }

    function setPartialNego() {
        var partialNegoFlag = $("#partialNegoFlag").attr("checked");

        if (partialNegoFlag == "checked") {
            $("#partialNego").val("on");
        } else {
            $("#partialNego").val("off");
        }
    }

    function setPartialNegoFlag() {
        var partialNego = $("#partialNego").val();

        $("#partialNegoFlag").removeAttr("checked");

        if (partialNego == "on") {
            $("#partialNegoFlag").attr("checked", "checked");
        }
    }

    $(document).ready(function() {
        $("#proceedsAmount").change(computeCorresCharge);
        computeCorresCharge();
        $("#partialNegoFlag").click(setPartialNego);
        setPartialNegoFlag();

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