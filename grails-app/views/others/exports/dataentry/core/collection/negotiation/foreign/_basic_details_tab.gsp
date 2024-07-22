<g:javascript src="utilities/exports/basic_details_utility.js" />
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Generate MT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="mtFlag" labels="['Yes','No']" values="['Y','N']" value="N">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Invoice Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="invoiceNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Exporter CB code (if </span> <br />
			<span class="field_label"> without CIF No.) </span>
		</td>
		<td class="input_width"> <g:select class="select_dropdown" name="exporterCbCode" from="" /> </td>
	</tr>
		<tr>
		<td class="label_width"> <span class="field_label"> Exporter Name (Drawer) </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="exporterName" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Importer Name (Drawee)<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="importerName" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Payment Mode </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="paymentMode" from="['LC','DP','DA']" noSelection="['':'Select One...']" value="LC"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> EXLC Advise Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="exlcAdviseNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Date </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="negotiationDate" value="${DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="negotiationCurrency" from="['PHP']" noSelection="['':'Select One...']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="negotiationAmount"/> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Additional Amount Claimed </span> <br />
			<span class="field_label"> (in Negotiation Currency) </span>
		</td>
		<td class="input_width"> <g:textField class="input_field" name="additionalAmountClaimed" /> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Charges (in Negotiation Currency) </span>
			<span class="right_indent"> Code </span>
		</td>
		<td class="input_width"> <g:select class="select_dropdown" name="chargesCode" from="['AGENT']" noSelection="['':'Select One...']"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="right_indent"> Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="chargesAmount" /> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Total Amount Claimed </span> <br />
			<span class="field_label"> (in Negotiation Currency) </span>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <g:radio name="totalAmountClaimedFlag" value="A"/> <span class="field_label"> Option A </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="totalAmountClaimedDate" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <g:radio name="totalAmountClaimedFlag" value="B"/> <span class="field_label"> Option B </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="totalAmountClaimed" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Correspondent Bank<span class="asterisk">*</span> </span> </td>
	</tr>
	<tr>
		<td class="label_width"> <g:radio name="correspondentBankFlag" value="A" /> <span class="field_label"> Option A -</span> <br /> <span class="field_label"> Swift Code </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="correspondentBankSwiftCode" from="['SWIFT Code']" disabled="true" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <g:radio name="correspondentBankFlag" value="B" /> <span class="field_label"> Option B -</span> <br /> <span class="field_label small_margin_left"> Location </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="correspondentBankLocation" readonly="readonly" />
	</td>
	<tr>
		<td class="label_width"> <g:radio name="correspondentBankFlag" value="D" /> <span class="field_label"> Option D -</span> <br /> <span class="field_label small_margin_left"> Name and Address </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="correspondentBankNameAndAddress" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Correspondent Bank - Account Number<span class="asterisk">*</span> </span> </td>
	</tr>
	<tr>
		<td class="label_width"> <g:radio name="correspondentBankAccountNumberFlag" value="A" /> <span class="field_label"> Option A -</span> <br /> <span class="field_label small_margin_left"> Swift Code </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="correspondentBankAccountNumberSwiftCode" from="['SWIFT Code']" disabled="true" />
	</td>
	<tr>
		<td class="label_width"> <g:radio name="correspondentBankAccountNumberFlag" value="D" /> <span class="field_label"> Option D -</span> <br /> <span class="field_label small_margin_left"> Name and Address </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="correspondentBankAccountNumberNameAndAddress" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Type of Account </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="typeOfAccountFlag" labels="['RBU','FCDU']" values="['RBU','FCDU']" disabled="true">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Country Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="countryCode" from="" noSelection="['':'Select One...']" /> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Sender to Receiver </span> <br />
			<span class="field_label"> Information </span>
		</td>
		<td class="input_width">
			<tfs:senderToReceiverType1 name="senderToReceiverMt202" value="${senderToReceiverMt202}"/>
		</td>
	</tr>
	<tr>
		<td class="label_width">&#160;</td>
		<td class="input_width">
			<td class="input_width"> <g:textArea class="textarea_long" name="senderToReceiverInformation" /> </td>
		</td>
	</tr>
	<tr>

		
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />