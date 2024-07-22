<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label"> Proceeds Amount </span></td>
        <td><g:textField class="input_field_short trans_currency center" name="proceedsCurrency" readonly="readonly"/></td>
        <td><g:textField class="input_field numeric_fifteen right numericCurrency" name="proceedsAmount" readonly="readonly"/></td>
    </tr>
    <tr>
        <td>&#160;</td>
    </tr>
    <tr>
        <td width="160"><span class="field_label"> Remaining Balance </span></td>
        <td><g:textField class="input_field_short trans_currency center" name="remainingCurrencyBalance" readonly="readonly"/></td>
        <td><g:textField class="input_field numeric_fifteen right" name="remainingAmountBalance" readonly="readonly"/></td>
    </tr>
    <tr>
        <td>&#160;</td>
    </tr>
    <tr>
        <td width="160"><span class="field_label">Amount of Payment </span></td>
        <td><g:textField value="PHP" name="amountOfPaymentCurrencyProceedBeneficiary" class="input_field_short" readonly="readonly" /></td>
        <td class="editable"><g:textField name="amountOfPaymentProceedBeneficiary" class="input_field right" /></td>
    </tr>
</table>
<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement Mode" />
<br /><br/>
<%--<h3 id="tab_titles">Proceeds Summary for Charges</h3>--%>
<%--<div class="grid_wrapper"> <!-- JQGRID -->--%>
    <%--<table id="grid_list_proceeds_payment_summary"> </table>--%>
    <%--<div id="grid_pager_proceeds_payment_summary"></div>--%>
<%--</div>--%>
<span class="title_label">Proceeds Summary for Charges</span>
<div class="grid_wrapper fix"> %{--JQGRID--}%
    <table id="grid_list_cash_payment_summary"> </table>
    <div id="grid_pager_cash_payment_summary"></div>
    <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
    <tr>
        <td>
            <table>
                <tr>
                    <td><span class="field_label"> Total Amount of Payment </span> </td>
                    <td><g:textField name="totalProceedsPayment" value="" class="input_field right" readonly="readonly"/></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
