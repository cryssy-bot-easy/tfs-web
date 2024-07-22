<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}" />
<g:hiddenField name="outstandingBcAmount" value="${outstandingBcAmount}" />
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId ?: etsNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> e-TS Date </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
    </tr>
    %{--<tr>--}%
        %{--<td class="label_width"> <span class="field_label"> Document Number </span> </td>--}%
        %{--<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>--}%
    %{--</tr>--}%
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
        <td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
    </tr>
    <tr>
		<td class="label_width"> <span class="field_label"> Seller Name<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="sellerName" value="${sellerName}" maxlength="100"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Seller Address<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:textArea name="sellerAddress" value="${sellerAddress}" class="textarea required" rows="4"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Buyer Name<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="buyerName" value="${buyerName}" maxlength="100"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Buyer Address<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:textArea name="buyerAddress" value="${buyerAddress}" class="textarea required" rows="4" maxlength="300"/>
		</td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:select class="select_dropdown required" name="processingUnitCode" from="['909']" noSelection="${['':'SELECT ONE...']}" value="${processingUnitCode ?: '909'}"/> </td>
    </tr>
    <tr>
		<td class="label_width"> <span class="field_label"> Payment Mode </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="paymentMode" from="['LC','DP','DA','OA']" noSelection="['':'SELECT ONE...']" value="${paymentMode ?: 'LC'}" disabled="true"/> </td>
		<g:hiddenField name="paymentMode" value="${paymentMode ?: 'LC'}"/>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DB Facility Type </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="bpFacilityType" from="['Domestic Bills Purchased', 'Domestic Bills Purchased Discounted']" noSelection="['':'SELECT ONE...']" value="${bpFacilityType}"/> </td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> With Outstanding DBC?<span class="asterisk">*</span> </span> </td>
        <td class="input_width">
            <g:radioGroup name="withBcFlag" labels="['Yes','No']" values="[1,0]" value="${withBcFlag}">
                ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
            </g:radioGroup>
            <g:hiddenField name="withBcFlagCheck" class="required" />
        </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> If Yes: Negotiation Number </span> </td>
        <td class="input_width"> <g:select class="select_dropdown" name="negotiationNumber" from="" noSelection="['':'SELECT ONE...']" /> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Currency </span> </td>
     	<td class="input_width"> <g:textField class="input_field" name="bcCurrency" readonly="readonly" value="${bcCurrency}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Amount </span> </td>
     	<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="bcAmount" readonly="readonly" value="${bcAmount}"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" /> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}" /> </td>
    </tr>
<%--    <tr>--%>
<%--		<td class="label_width"> <span class="field_label small_margin_left"> Outstanding DBC Amount </span> </td>--%>
<%--		<td class="input_width"> <g:textField class="input_field_right" name="outstandingBcAmount" readonly="readonly"/> </td>--%>
<%--	</tr>--%>
    <tr>
        <td class="label_width">
            <span class="field_label"> Export proceeds to be remitted </span> <br />
            <span class="field_label"> via PDDTS? </span>
        </td>
        <td class="input_width">
            <g:radioGroup name="exportViaPddtsFlag" labels="['Yes','No']" values="[1,0]" value="${exportViaPddtsFlag ?: 0}">
                ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
            </g:radioGroup>
        </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> With 2% CWT? </span> </td>
        <td class="input_width">
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}">
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
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

    function onWithBcFlagChange() {
        $("#negotiationNumber").val("");
        $("#negotiationNumber").attr("disabled", "disabled");

        var withBcFlag = $("input[name=withBcFlag]:checked").val();

        if (withBcFlag == 1) {
        	$("#outstandingBcAmount").parents("tr").show();
            var url = '${g.createLink(controller: "product", action: "retrieveAllCollections")}';
            $.post(url, {cifNumber: $("#cifNumber").val(), exportBillType: 'DBC'}, function(data) {
                $("#negotiationNumber").empty();
                $("#negotiationNumber").append($('<option></option>').val("").html("SELECT ONE..."));

                if(data.documentNumbers.length > 0){
	                $.each(data.documentNumbers, function(idx, val) {
	                    var option = "<option value="+val+">"+val+"</option>";
	
	                    $("#negotiationNumber").append(option)
	                });
	                $("#negotiationNumber").removeAttr("disabled");
                } else {
                	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
                    triggerAlertMessage("No Outstanding DBC's found.");
                    $("#outstandingBcAmount").parents("tr").hide();
                }

                if ('${negotiationNumber}') {
                    $("#negotiationNumber").val('${negotiationNumber}');

                    setEbcAmount();
                }
            }).error(function (){
            	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
                triggerAlertMessage("No Outstanding DBC's found.");
                $("#outstandingBcAmount").parents("tr").hide();
            });
        } else {
            $("#outstandingBcAmount").parents("tr").hide();
        }
        if (withBcFlag) {
            $("#withBcFlagCheck").val("true");
        } else {
            $("#withBcFlagCheck").val("");
        }
        computeOutstandingBcAmount();
    }

    function setEbcAmount() {
        var negotiationNumber = $("#negotiationNumber").val();

        var url = '${g.createLink(controller: "product", action: "retrieveCollectionAmount")}';

        if (negotiationNumber) {
            $.post(url, {documentNumber: negotiationNumber}, function(data) {
            	$("#bcCurrency").val(data.currency);
                $("#bcAmount").val(formatCurrency(data.amount));
                if('${amount}'.length == 0){
                	$("#amount").val(formatCurrency(data.amount));
                }
                $("#currency").select2('data',{id: data.currency});
                $("#currency").select2("disable");

                $("#paymentMode").val(data.paymentMode);
                computeOutstandingBcAmount();
            });
        } else {
        	$("#bcCurrency").val("");
            $("#bcAmount").val("");
            $("#amount").val("");

            $("#currency").select2('data', null);
            $("#currency").select2("enable");

            computeOutstandingBcAmount();
        }
    }

    function computeOutstandingBcAmount(){
        if($("#negotiationNumber").val()){
            if($("#amount").val().replace(/,/g , "") <= $("#bcAmount").val().replace(/,/g , "")){
            	$("#outstandingBcAmount").val(formatCurrency(parseFloat($("#bcAmount").val().replace(/,/g , "") - $("#amount").val().replace(/,/g , ""))));
            } else {
            	$("#outstandingBcAmount").val(formatCurrency(0));
            }
        } else {
        	$("#outstandingBcAmount").val('');
        }
    }


    $(document).ready(function() {
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});

        $("input[name=withBcFlag]").click(onWithBcFlagChange);
        onWithBcFlagChange();

        $("#negotiationNumber").change(setEbcAmount);

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

        $("#amount").change(computeOutstandingBcAmount);
        computeOutstandingBcAmount();
    });
</script>