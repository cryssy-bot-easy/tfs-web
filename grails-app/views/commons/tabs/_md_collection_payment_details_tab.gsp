<%--<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>--%>
<%--<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>--%>
<%--<g:hiddenField name="documentNumber" value="${documentNumber}"/>--%>

<%-- Auto Complete --%>

<%--
(revision)
	SCR/ER Number: SCR# 
	SCR/ER Description: Added Fields for Foreign Exchange Rates
	[Revised by:] Jonh Henry Santos Alabin
	[Date deployed:] June 16,2017
	Member Type: Groovy Server Pages
	Project: WEB
	Project Name: _md_collection_payment_details_tab.gsp
--%>


%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">MD Currency%{--<span class="asterisk"> *</span>--}%</span></td>
		<td class="input_width">
			<%-- <g:select name="mdCurrency" from="${['PHP','USD','WON','YEN']}" class="select_dropdown" noSelection="['':'SELECT ONE...']"/> --%>
		
			<%-- Auto Complete --%>
			<input class="tags_currency select2_dropdown bigdrop" name="mdCurrency" id="mdCurrency" />	 
		</td>
	</tr>
	<tr>
		<td><span class="field_label">MD Collection Amount %{--<span class="asterisk">*</span>--}%</span></td>
		<td><g:textField name="mdCollectionAmount" class="input_field_right numericCurrency" /></td>
	</tr>
</table>
<br/>
<%--ADDED by HENRY --%>
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
                    <td>${temp.rate_description}</td>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="urr">${temp.pass_on_rate.toString()}</td>
                        <td class="urr">${temp.special_rate.toString()}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td>
                    </g:if>
                    <g:else>
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/>
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/></td>
                        <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
    <%--END --%>
<%--<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Payment Mode"/>--%>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Payment Mode"/>
<br /><br/>
<span class="title_label">Payment Summary</span>

<div class="grid_wrapper">
    <table id="grid_list_cash_payment_summary"></table>
    <g:hiddenField name="documentPaymentSummary" value="" />
</div>

<script>
    $(document).ready(function() {
        %{--$("#mdCurrency").select2('data',{id: '${mdCurrency}'});--}%
        $("#mdCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${mdCurrency}'});
    });
</script>
