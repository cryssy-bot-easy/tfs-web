<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="cifNumber" value="${cifNumber}" />
<g:hiddenField name="cifName" value="${cifName}" />
<g:hiddenField name="accountOfficer" value="${accountOfficer}" />
<g:hiddenField name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}" />

<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="saveAs" value=""/>
<g:javascript src="utilities/commons/ets_index_utility.js" />


<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Date</span></td>
		<td><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">MD Application Booking Date</span></td>
		<td><g:textField name="mdApplicationBookingDate" value="${mdApplicationBookingDate}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Currency</span></td>
		<td><g:textField name="mdCurrency" value="${mdCurrency}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Balance</span></td>
		<td><g:textField name="outstandingAmount" value="${outstandingAmount}" class="input_field_right numericCurrency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of MD To Apply<span class="asterisk">*</span></span></td>
		<td><g:textField name="amountOfMdToApply" value="${amountOfMdToApply}" class="input_field_right numericCurrency required"/></td>
	</tr>
	<%-- 
	<tr>
		<td><span class="field_label">Mode Of Refund</span></td>
		<td><g:select name="modeOfRefund" value="${modeOfRefund}" from="${['Credit CASA','Issuance to MC']}" keys="${['CASA', 'REFUND_TO_CLIENT_ISSUE_MC']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" /></td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label small_margin_left">If Credit CASA, Account Number <span class="asterisk">*</span></span></td>
		<td>
			<g:textField class="input_field required" name="casaAccountNumberMd" id="casaAccountNumberMd" maxlength="12" value="${casaAccountNumberMd}"/>
			<input type="button" class="check_button" id="accountNameMdCheck" style="float:none;"/>
		</td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label small_margin_left">Account Name <span class="asterisk">*</span></span></td>
		<td>
            <g:textField name="casaAccountName" id="casaAccountName" value="${casaAccountName}" class="input_field required" readonly="readonly"/>
        </td>
	</tr>--%>
</table>
<br/><br/>
%{--<g:render template="../layouts/buttons_for_grid_wrapper"/>--}%

<table class="buttons_for_grid_wrapper">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveAsPendingMd" class="input_button" value="Save" /></td>
    </tr>

    <tr>
        <%-- BUTTON --%>
        <td><input type="button" class="input_button_negative cancelTransaction actionButton actionWidget" value="Cancel" /></td>
    </tr>
</table>

<script>
    var searchCasaAccountsUrl = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl += "?cifNumber="+$("#cifNumber").val();

    jQuery.fn.setupMdAccountNumber = function() {
        var elementName = '#'+this.attr("id");
        var currency = $("#mdCurrency").val();

        $(elementName).select2({
            minimumInputLength: 2,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: searchCasaAccountsUrl + '&currency=' + currency,
                dataType: 'json',
                data: function (term, page) {
                    return {
                        //featureClass: "P",
                        //q: term, // search term
                        starts_with: term,
                        page_limit: 10//,
                        //apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    //since we are using custom formatting functions we do not need to alter remote JSON data
                    var more = (page * 10) < data.total; // whether or not there are more results available

                    // notice we return the value of more so Select2 knows if more results can be loaded
                    return {results: data.results, more: more};

                }
            },
            formatResult: formatMdAccountNumberResult, // omitted for brevity, see the source of this page
            formatSelection: formatMdSelectionAccountNumber, // omitted for brevity, see the source of this page
            dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller,
        });

        return this;
    }

    function formatMdAccountNumberResult(result) {

        var markup = "<table>";
        markup += "<tr>";
        markup += "<td>";
        markup += "<div>" + result.id + "</div>";
        markup += "<div class='autocomplete_id_below'>" + result.label + "</div>";
        markup += "</td>";
        markup += "</tr>";
        markup += "</table>";

        return markup;
    }

    function formatMdSelectionAccountNumber(result) {
        if (!'${casaAccountName}') {
            $("#casaAccountName").val(result.label);
        }
        return result.id;
    }

    
    $(document).ready(function() {
        $("#saveAsPendingMd").click(function() {
			if(validateMdRefundFields()){
				var postUrl = saveUrl;

                if ($("#tradeServiceId").val()) {
                    postUrl = updateUrl;
                }

                mCenterPopup($("#loading_div"), $("#loading_bg"));
                mLoadPopup($("#loading_div"), $("#loading_bg"));
                $(".saveAction").show();
                $(".cancelAction").hide();
                $("#basicDetailsTabForm").attr("method", "POST");
                $("#basicDetailsTabForm").attr("action", postUrl);
                $("#basicDetailsTabForm").submit();
			}
        });

<%--        --%>

        function validateMdRefundFields(){
            var result = true;
            var mdAmount = parseInt($("#amountOfMdToApply").val().toString().replace(/,/g,""));
			var osAmount = parseInt($("#outstandingAmount").val().toString().replace(/,/g,""));

	        $("#body_forms :input").each(function () {
	            if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
	                if ($(this).val() == "" && $(this).is(":visible")) {
	                    console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
	                    triggerAlertMessage("Please fill-up all required fields.");
	                    result = false;
	                }
	            }
	        });

	        if((mdAmount !== null && osAmount !== null) && (!isNaN(mdAmount) && !isNaN(osAmount))){
				if(mdAmount > osAmount){
					triggerAlertMessage('MD Amount to Apply cannot be greater than MD Outstanding Balance.');
					result = false;
				}
			}
	        return result;
		}

        $("#accountNameMdCheck").click(function () {
        	accountNumber = $("#casaAccountNumberMd").val().trim();
            var settlementCurrency = $("#mdCurrency").val();

            mCenterPopup($("#loading_div"), $("#loading_bg"));
            mLoadPopup($("#loading_div"), $("#loading_bg"));
            
            $.post(casaUserSearchUrl, {accountNumber: accountNumber, currency: settlementCurrency}, function (data) {
                if (data["status"] != "error") {
                    if (data['currency'] != settlementCurrency) {
                        triggerAlertMessage('Currency of account did not match Settlement Currency.');
                        $("#casaAccountNumberMd").val("");
                    } else {
                        $("#casaAccountName").val(data['accountName']);
                        accountNumber = ($("#casaAccountNumberMd").val()).trim();
                    }
                } else {
                    triggerAlertMessage(data["error"]);
                    $("#casaAccountNumberMd").val("");
                }
            }).always(function(){
            	mDisablePopup($("#loading_div"), $("#loading_bg"));
    		});
        });
    });
</script>