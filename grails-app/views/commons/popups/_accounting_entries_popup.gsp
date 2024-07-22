<script>

    var accountingEntriesUrl = '${g.createLink(controller:'accountingEntry', action:'viewAccountingEntries')}';
    
   
</script>
<g:javascript src="grids/accounting_entries_jqgrid.js"/>
<div id="popup_accountingEntries" class="popup_div_override">
	<div class="popup_header">
		<a href="#" class="popup_close"  onclick="closeAccountingEntries()">X</a>
		<h2>Accounting Entries</h2>
	</div>
	<br />
<%--	<table>--%>
<%--		<tr>--%>
<%--			<td><span class="errorMessage">Unit Code:</span></td>--%>
<%--			<td>--%>
<%--				<g:textField name="unitCodeErr"  value="" readonly="readonly"/>--%>
<%--			</td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td><span class="errorMessage">Book Code:</span></td>--%>
<%--			<td></td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td><span class="errorMessage">Gl   Code:</span></td>--%>
<%--			<td></td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td><span class="errorMessage">Currency :</span></td>--%>
<%--			<td></td>--%>
<%--		</tr>--%>
<%--	</table>--%>
<%--	<br />--%>
	<table>
		<tr>
			<td><span class="field_label">Title</span></td>
			<td> 
				<span class="field_label_accEntries">${title}</span>			
			</td>
		</tr>
		<tr>
			<td> <span class="field_label">GLTS Number</span> </td>
			<td> <g:textField name="gltsNumber" class="input_field" readonly="readonly"/> </td>
		</tr>
	</table>

	<div class="grid_wrapper_auto">
		<table id="grid_list_accounting_entries"></table>	
		<div id="grid_pager_accounting_entries"> </div>
	</div>
	<br />
	
	<div id="accEntries_total">
		<span class="field_label_total"> TOTAL </span>
		<g:textField id="totalDebit" name="totalDebit" class="input_field_accentries_right" value="" id="totalDebit" readonly="readonly"/>
		<g:textField id="totalCredit" name="totalCredit" class="input_field_accentries_right" value="" id="totalCredit" readonly="readonly"/>
		<g:textField id="totalDebitBase" name="totalDebitBase" class="input_field_accentries_right" value="" id="totalDebitBase" readonly="readonly"/>
		<g:textField id="totalCreditBase" name="totalCreditBase" class="input_field_accentries_right" value="" id="totalCreditBase" readonly="readonly"/>
	</div>

    <%--<table>
        <tr>
            <td><span class="field_label">Total Credit:</span></td>
            <td>
                <g:textField name="totalCredit" class="input_field" value="" id="totalCredit" readonly="readonly"/>
            </td>
            <td>&nbsp;</td>
            <td><span class="field_label">Total Debit:</span></td>
            <td>
                <g:textField name="totalDebit" class="input_field" value="" id="totalDebit" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td><span class="field_label">Total Credit Base:</span></td>
            <td>
                <g:textField name="totalCreditBase" class="input_field" value="" id="totalCreditBase" readonly="readonly"/>
            </td>
            <td>&nbsp;</td>
            <td><span class="field_label">Total Debit Base:</span></td>
            <td>
                <g:textField name="totalDebitBase" class="input_field" value="" id="totalDebitBase" readonly="readonly"/>
            </td>
        </tr>
    </table> --%>
</div>
<div class="popup_bg_override" id="popupBackground_accountingEntries"></div>
<g:javascript src="popups/accounting_entries_popup.js" />