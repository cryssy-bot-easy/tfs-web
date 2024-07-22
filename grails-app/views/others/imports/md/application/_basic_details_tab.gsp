<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="cifNumber" value="${cifNumber}" />
<g:hiddenField name="cifName" value="${cifName}" />
<g:hiddenField name="accountOfficer" value="${accountOfficer}" />
<g:hiddenField name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}"/>

<g:javascript src="utilities/commons/dataentry_as_ets_utility.js" />

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
        <td><g:textField name="etsNumber" value="${tradeServiceReferenceNumber}" class="input_field" readonly="readonly"/></td>
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
        <td><g:textField name="processingUnitCode" value="${processingUnitCode}" class="input_field" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">MD Application Booking Date</span></td>
        <td><g:textField name="mdApplicationBookingDate" value="${mdApplicationBookingDate ?: net.ipc.utils.DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">O/S MD Amount</span></td>
        <td><g:textField name="outstandingAmount" value="${outstandingAmount}" class="input_field_right numericCurrency" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">MD Settlement Currency</span></td>
        <td><g:textField name="mdCurrency" value="${mdCurrency}" class="input_field" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">Amount of MD To Apply<span class="asterisk">*</span></span></td>
        <td><g:textField name="amountOfMdToApply" value="${amountOfMdToApply}" class="input_field_right numericCurrency required"/></td>
    </tr>
    <tr >
        <td><span class="field_label"> Mode Of Application<span class="asterisk">*</span></span></td>
<%--        <td><g:select name="modeOfApplication" value="${modeOfApplication}" from="${['Apply to Loan','Refund to Client']}" keys="${['APPLY_TO_LOAN', 'REFUND_TO_CLIENT_ISSUE_MC']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" /></td>--%>
        <td><g:select name="modeOfApplication" value="${modeOfApplication ?: 'APPLY_TO_LOAN'}" from="${['Apply to Loan']}" keys="${['APPLY_TO_LOAN']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" /></td>
    </tr>
    <tr class="pn-number">
        <td><span class="field_label">PN Number</span></td>
        <td><g:textField name="pnNumber" class="input_field" value="${pnNumber}" readonly="readonly"/></td>
    </tr>
    <tr class="pn-number">
    	<td><span class="field_label">Remarks</span></td>
    	<td><g:textArea name="remarks" class="textarea_shipment_goods" value="${remarks}"/></td>
    </tr>
    <tr class="modeRefund">
        <td><span class="field_label">If Refund to Client: Mode Of Refund</span></td>
        <td><g:select name="modeOfRefund" value="${modeOfRefund}" from="${['Credit CASA','Issuance to MC']}" keys="${['CASA', 'REFUND_TO_CLIENT_ISSUE_MC']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" /></td>
        %{--TODO: dagdagan ng credit to casa button pag pinili ang casa :)--}%
        %{--TODO: pag pinindot ang button na ito, mag-tatransform ito papuntang error correct--}%
    </tr>
    <tr class="md-casa">
        <td><span class="field_label small_margin_left">If Credit CASA,Account Number</span></td>
        <td>
<%--        <g:select name="casaAccountNumber" value="${casaAccountNumber}" from="${['10-001-000100-2','10-005-003451-9']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" />--%>
			<input class="tags_accountNumber select2_dropdown bigdrop" name="casaAccountNumber" id="casaAccountNumber" />
        </td>
    </tr>
    <tr class="md-casa">
        <td><span class="field_label small_margin_left">Account Name</span></td>
        <td><g:textField name="casaAccountName" value="${casaAccountName}" class="input_field" readonly="readonly"/></td>
    </tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script>

var searchCasaAccountsUrl = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
searchCasaAccountsUrl += "?cifNumber="+$("#cifNumber").val();

jQuery.fn.setupMdAccountNumber = function() {
    var elementName = '#'+this.attr("id");
    var currency = $("#mdCurrency").val();

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
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
    $("#casaAccountNumber").setupMdAccountNumber($(this).attr("id")).select2('data',{id: '${casaAccountNumber}'}).change(function(){
        if($(this).val() == "" )
    	$("#casaAccountName").val("");
     });
});
</script>