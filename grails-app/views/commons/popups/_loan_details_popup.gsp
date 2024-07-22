<g:javascript src="popups/facility_id_popup.js"/>
<div id="loan_details_popup" class="popup_div_override">
<table class="loan_details">
    <tr>
        <td><span class="field_label">Payment Term<span class="asterisk">*</span></span></td>
        <td>
            <g:textField name="paymentTerm" class="input_field_medium numberFormat-5 loanField"/>
            <g:radioGroup name="paymentTermCodeGroup" labels="['Months','Days']" values="['M','D']" value="M" id="paymentTermCode" class="loanField">
                ${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
            </g:radioGroup>
        </td>
    </tr>
<%--    <tr>--%>
<%--        <td><span class="field_label">Payment Code</span></td>--%>
<%--        <td>--%>
<%--            <g:select from="${['0','1','2','3','4','5','6'] }" value="2" name="loanPaymentCode" class="select_dropdown loanField" disabled="disabled"/>--%>
<%--        </td>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td><span class="field_label">With Approval from CRAM?</span></td>--%>
<%--        <td>--%>
<%--            <g:radioGroup name="cramApprovalFlag" labels="['Yes','No']" values="['true','false']" value="N" disabled="disabled">--%>
<%--                ${it.radio}&#160;<g:message code="${it.label}" />--%>
<%--            </g:radioGroup>--%>
<%--        </td>--%>
<%--    </tr>--%>
    %{--<tr>--}%
        %{--<td><span class="field_label">Loan Maturity Date</span></td>--}%
        %{--<td><g:textField class="input_field_medium" name="loanMaturityDate" readonly="readonly"/></td>--}%
    %{--</tr>--}%
%{--    <tr>
        <td><span class="field_label">Loan Maturity Date</span></td>
        <td><g:textField class="input_field" name="loanMaturityDateUsance" readonly="readonly"/></td>
    </tr>--}%
    <tr>
        <td class="label_width"><span class="field_label">Facility ID <span class="asterisk">*</span></span></td>
        <td class="input_width"><g:textField class="input_field input_eleven facilityId loanField" name="facilityId" readonly="readonly" value="${facilityId}"/>
            <a href="javascript:void(0)" class="search_btn" id="ibFacilitySearchButton">Search/Look-up Button</a>
        </td>
    </tr>
	<tr>
		<td class="label_width"><span class="field_label">Agri - Agra BSP Tagging <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:select from="${['AGRI','AGRA','REGULAR'] }" name="agriAgra" value="${agriAgra}" class="select_dropdown loanField" noSelection="['':'SELECT ONE...']"/></td>
	</tr>
</table>

%{--<g:hiddenField name="facilityId" value="${facilityId}"/>--}%
<g:hiddenField name="facilityType" value=""/>
<g:hiddenField name="facilityReferenceNumber" value=""/>
<g:hiddenField name="selectionId" value=""/>

<table class="popup_buttons">
	<tr><td><input type="button" class="input_button" id="save_loanDetails" value="Accept"/></td></tr>
    <tr><td><input type="button" class="input_button_negative" id="close_loanDetails" value="Close"/></td></tr>
</table>
</div>
<div id="loan_details_bg" class="popup_bg_override"></div>
<script type="text/javascript">
$(function(){
	$("#agriAgra").change(function(){
		$("#agriAgraTagging").val($(this).val());
	});
});
</script>
