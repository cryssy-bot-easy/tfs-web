<div id="debitMemoPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_debit_memo popup_close">x</a>
		<h2 class="popup_title"> Debit Memo </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label bold">Applicant Name</span></td>
			<td>
				<%--Eric's fixed for bug #3682 hindi lang xa maka-push --%>
				<%--<g:textField class="input_field" name="importerNameDebit2" value="${
					(documentClass?.equalsIgnoreCase('BC') || documentClass?.equalsIgnoreCase('BP')) ? sellerName :
					(applicantName ?: buyerName ?: importerName ?: cifName)}" readonly="readonly"/>
				--%>
				<%--<g:hiddenField name="importerLongNameDebit" value="${
					(documentClass?.equalsIgnoreCase('BC') || documentClass?.equalsIgnoreCase('BP')) ? sellerName :
					(applicantName ?: buyerName ?: importerName ?: longName)}" readonly="readonly"/>
				--%>
				<%-- Mark's fixed for Issue #3978 --%>
				<g:textField class="input_field" name="importerNameDebit" value="${
					(documentClass?.equalsIgnoreCase('BC') || documentClass?.equalsIgnoreCase('BP')) ? sellerName :
					(applicantName ?: buyerName ?:
					(documentClass?.equalsIgnoreCase('EXPORT_ADVISING') ? exporterName : importerName) ?: 
					cifName)}" readonly="readonly"/>
				<g:hiddenField name="importerLongNameDebit" value="${
					(documentClass?.equalsIgnoreCase('BC') || documentClass?.equalsIgnoreCase('BP')) ? sellerName :
					(applicantName ?: buyerName ?: (documentClass?.equalsIgnoreCase('EXPORT_ADVISING') ? exporterName : importerName) ?: longName)}" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label bold">Account Name</span></td>
		</tr>
		<tr class="debitNameRow1">
			<td/>
			<td><g:textField class="input_field" name="debitNameProduct1" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck1"/></td>
		</tr>
		<tr class="debitNameRow2">
			<td/>
			<td><g:textField class="input_field" name="debitNameProduct2" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck2"/></td>
		</tr>
		<tr class="debitNameRow3">
			<td/>
			<td><g:textField class="input_field" name="debitNameProduct3" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck3"/></td>
		</tr>
		<tr class="debitNameRow4">
			<td/>
			<td><g:textField class="input_field" name="debitNameCharges1" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck4"/></td>
		</tr>
		<tr class="debitNameRow5">
			<td/>
			<td><g:textField class="input_field" name="debitNameCharges2" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck5"/></td>
		</tr>
		<tr class=debitNameRow6>
			<td/>
			<td><g:textField class="input_field" name="debitNameCharges3" readonly="readonly"/></td>
			<td><g:checkBox name="debitNameCheck6"/></td>
		</tr>
		<tr>
			<td colspan="3"><span class="note2">Note: Check if applicant name is the same as account name.</span></td>
		</tr>
	</table>
	<br/>
	<table class="buttons"> 
		<tr>
			<td><input type="button" class="input_button generateDebitMemo" value="View" /></td>
		</tr>
		<tr>
			<td><input type="button" class="input_button_negative popupClose_debit_memo" value="Cancel" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_debit_memo" class="popup_bg_override"></div>

<%--<script type="text/javascript">--%>
<%--$(document).ready(function() {--%>
<%--	$("#accountNameProduct1").change(function() {--%>
<%--		if($("#accountNameProduct1").attr("checked" == "checked"))--%>
<%--	});--%>
<%--});--%>
<%--</script>--%>