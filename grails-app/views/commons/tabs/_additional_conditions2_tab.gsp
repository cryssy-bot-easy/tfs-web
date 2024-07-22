<%-- 
(revision)
[Modified by:] Rafael Ski Poblete
[Date Modified:] 8/28/2018
[Description: ] Added Period for Presentation in Days field.
                Changed sender to receiver dropdown Values. --%>

<%-- 
(revision)
[Revised by:] Cedrick C. Nungay
[Date deployed:] 09/13/2018
Program [Revision] Details: Fixed bug on saving reimbursing bank identifier code and advising through bank identifier code
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _additional_conditions2_tab.gsp
--%>
<script type="text/javascript">
    var instructionsToBankGridUrl = '${g.createLink(controller: "instructionToBank", action: "findAllInstructionsToBank")}';
    var savedInstructionsToBankUrl = '${g.createLink(controller: "instructionToBank", action: "findAllSavedInstructionsToBank")}';
    var savedLcInstructionsToBankUrl = '${g.createLink(controller: "instructionToBank", action: "findAllSavedLcInstructionsToBank")}';
</script>
<g:javascript src="grids/additional_conditions3_jqgrid.js" />
<g:javascript src="popups/advise_through_bank_popup.js" />

<%-- for amendment --%>
<g:javascript src="utilities/dataentry/commons/additionalCheckBoxFunction2.js" />
<g:javascript src="utilities/dataentry/commons/additional_condition2_utility.js" />
<g:if test="${serviceType == 'Amendment' }">
%{--<g:javascript src="utilities/dataentry/commons/reimbursingBankRadio.js" />--}%
%{--<g:javascript src="utilities/dataentry/commons/adviseThroughBankRadio.js" />--}%
%{--<g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />--}%
<g:javascript src="utilities/dataentry/amendment/amendment_dataentry_additional_conditions2_utility.js" />
</g:if>

<g:hiddenField name="currency" value="${currency}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="additionalConditions2" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="accountType2" value="${accountType}"/>


<%-- FOR OTHER SERVICE TYPE EXCEPT AMENDMENT --%>
<g:if test="${serviceType != 'Amendment' }">
	<table class="tabs_forms_table">
		<tr>
			<td class="label_width"><span class="field_label"> Period for Presentation in Days </span></td>
			<td>		
				<input style="width:2em;" type="text" maxlength="3" name="periodForPresentationNumber" id="periodForPresentationNumber" class="input_field" value="${periodForPresentationNumber}"/>
			</td>
		</tr>
			<td></td>
			<td>		
				<input type="text" maxlength="35" name="periodForPresentation" id="periodForPresentation" class="input_field" value="${periodForPresentation}" readonly/>
			</td>
		</tr>
		<tr><td colspan="2" class="spacer">&#160;</td></tr>
		<tr>
			<td class="label_width" colspan="2"> <p class="p_header"> Reimbursing Bank </p> </td>
		</tr>
        <tr>
            <td class="label_width"><span class="field_label small_margin_left">Reimbursing Bank Code </span></td>
            <td><input class="tags_cbcode select2_dropdown bigdrop" name="reimbursingBankIdentifierCode" id="reimbursingBankIdentifierCode" /></td>
        </tr>
        <tr>
            <td/>
            <td><g:textField id="reimbursingBankName" name="reimbursingBankName" value="${reimbursingBankName}" class="input_field"  readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label small_margin_left">Account Type</span></td>
            <td id="reimbursingAccountTypeWrapper">
                <input type="radio" class="" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            	<input type="radio" class="" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
            </td>
        </tr>
        <tr>
        
        	<input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
	        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
	        <input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
	        <input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
            <td class="label_width"><span class="field_label small_margin_left">Reimbursing Bank Account Number</span></td>
            <td><input id="reimbursingBankAccountNumber" name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}" class="input_field" readonly="readonly" /></td>

        </tr>
        <tr>
            <td class="label_width"><span class="field_label small_margin_left">GL Code</span></td>
            %{--<td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field required" readonly="readonly" /></td>--}%
            <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
        </tr>
        <tr>
            <td class="label_width"><span class="field_label small_margin_left">Reimbursing Currency</span></td>
            <td><g:textField id="reimbursingCurrency" name="reimbursingCurrency" value="${reimbursingCurrency}" class="input_field" readonly="readonly" /></td>
        </tr>

    </table>
	
	<div class="grid_wrapper">
		<table id="add_conditions3_list"></table>
		<div id="add_conditions3_pager"></div>
        <g:hiddenField name="instructionToBankList" value="${instructionsToBank}" />
	</div>

	<br/><br/>
	
	<table class="tabs_forms_table">
		<tr>
			<td colspan="2"> <span class="title_label">'Advise Through' Bank</span></td>
		</tr>
		<tr>
			<td><span class="field_label small_margin_left">Party Identifier</span></td>
			<td><g:textField maxlength="12" class="input_field" name="adviseThroughBankPartyIdentifier" value="${adviseThroughBankPartyIdentifier}" /></td>
		</tr>
		<tr>
			<td><span class="field_label small_margin_left"><g:radio name="adviseThroughBankOpeningFlag" class="adviseThroughBankOpeningFlag" value="A" checked="${'A'.equals(adviseThroughBankOpeningFlag)}" />&#160;&#160;Identifier Code</span></td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="adviseThroughBankIdentifierCode" id="adviseThroughBankIdentifierCode" /></td>
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="adviseThroughBankOpeningFlag" class="adviseThroughBankOpeningFlag" value="D" checked="${'D'.equals(adviseThroughBankOpeningFlag)}" />
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="adviseThroughBankNameAndAddress" value="${adviseThroughBankNameAndAddress}" rows="4" readonly="readonly"/>
				<input type="button" class="popup_btn_bottom" id="adviseThroughBankPopup">
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label"> Sender to Receiver </span><br /><span class="field_label"> Information </span></td>
			<td class="input_width">
                <tfs:senderToReceiverTypeforMT700 name="senderToReceiver" class="newSenderToReceiver" value="${senderToReceiver}"/>
            </td>
		</tr>
		<tr>
			<td/>
			<td>
				<g:textArea maxlength="30" readonly="readonly:" value="${senderToReceiverInformation}" name="senderToReceiverInformation" class="textarea" rows="4" />
				<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
			</td>
		</tr>
	</table>
</g:if>

<%-- FOR AMENDMENT ONLY --%>
<g:if test="${serviceType == 'Amendment'}">
	<table class="tabs_forms_table">
		<tr>
			<td>
                <g:checkBox  name="periodForPresentation1SwitchDisplay"/>
                <g:hiddenField name="periodForPresentation1Switch" value="${periodForPresentation1Switch ?: 'off'}"/>
            </td>
			<td class="label_width"><span class="field_label"> Period for Presentation in Days </span></td>
			<td>		
				<input style="width:2em;" type="text" maxlength="3" name="periodForPresentation1NumberFrom" id="periodForPresentation1NumberFrom" class="input_field" value="${periodForPresentationNumber ?: periodForPresentation1NumberFrom}" disabled/>
				<br/>
				<g:textArea name="periodForPresentation1From" value="${periodForPresentation1From ?: periodForPresentation}" class="textarea" rows="4" readonly="readonly" />
			</td>
			<td colspan="2"><span class="field_label right_indent"> To: </span></td>
			<td>		
				<input style="width:2em;" type="text" maxlength="3" name="periodForPresentation1NumberTo" id="periodForPresentation1NumberTo" class="input_field" value="${periodForPresentation1NumberTo}"/>
				<br/>
                <g:textArea name="periodForPresentation1To" value="${periodForPresentation1To}" class="textarea" maxlength="35" rows="4" />
            </td>
		</tr>
		<tr><td colspan="6" class="spacer">&#160;</td></tr>
		<tr>
			<td>
                <g:checkBox name="reimbursingBankSwitchDisplay"/>
                <g:hiddenField name="reimbursingBankSwitch" value="${reimbursingBankSwitch ?: 'off'}"/>
            </td>
			<td class="label_width"><span class="p_header"> Reimbursing Bank </span></td>
		</tr>
		<tr>
			<td><g:radio name="reimbursingBankFlagFrom" class="disabled" value="A" checked="${(reimbursingBankFlagFrom ?: reimbursingBankFlag) == 'A' ? true : false}" disabled="true"/></td>				
			<td class="label_width">Option A - Identifier Code</td>
			<td class="input_width"><g:textField name="reimbursingBankIdentifierCodeFrom" value="${reimbursingBankIdentifierCode}" class="input_field" readonly="readonly" /></td>
			<td><span class="">To:</span></td>
			<td class="label_width"><g:radio name="reimbursingBankFlagTo" class="reimbursingRadioTo reimburseA" value="A" checked="${reimbursingBankFlagTo == 'A' ? true : false}" disabled="true"/>&#160;Option A - Identifier Code</td>
			<td><g:textField name="reimbursingBankIdentifierCodeTo" value="${reimbursingBankIdentifierCodeTo}" class="tags_bank select2_dropdown bigdrop" /></td>
		</tr>
		<tr>
			<td><g:radio name="reimbursingBankFlagFrom" class="disabled" value="D" checked="${(reimbursingBankFlagFrom ?: reimbursingBankFlag) == 'D' ? true : false}" disabled="true"/></td>
			<td>Option D - Name and Address</td>
			<td><g:textArea name="reimbursingBankNameAndAddressFrom" class="textarea" rows="4" readonly="readonly" value="${reimbursingBankNameAndAddress}"/></td>
			<td/>
            <td><g:radio name="reimbursingBankFlagTo" class="reimbursingRadioTo reimburseD" value="D" checked="${reimbursingBankFlagTo == 'D' ? true : false}"/>&#160;Option D - Name and Address</td>
			<td>
				<div><g:textArea name="reimbursingBankNameAndAddressTo" value="${reimbursingBankNameAndAddressTo}" class="textarea" maxlength="140" rows="4" /></div>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
			<td width=""><span class="field_label"> Reimbursing Account Type </span></td>		
			<td>
                <g:textField name="reimbursingAccountTypeFrom" value="${reimbursingAccountTypeFrom ?: reimbursingAccountType}" class="input_field" readonly="readonly" />
            </td>
            <td/>
			<td class="label_width"><span class="field_label"> Reimbursing Account Type </span></td>		
			<td>
                <g:textField name="reimbursingAccountTypeTo" value="${reimbursingAccountTypeTo}" class="input_field"/>
            </td>
		</tr>
		<tr>
			<td>&#160;</td>
			<td><span class="field_label"> Reimbursing Currency </span></td>		
			<td>
                <%-- <g:select name="reimbursingCurrencyFrom" value="${reimbursingCurrencyFrom ?: reimbursingCurrency}" from="${['USD', 'EUR', 'HKD']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" disabled="true" /> --%>
                <g:textField name="reimbursingCurrencyFrom" value="${reimbursingCurrencyFrom ?: reimbursingCurrency}" class="input_field" readonly="readonly" />
                <%-- Auto Complete --%>
				%{--<input class="tags_currency select2_dropdown bigdrop" name="reimbursingCurrencyFrom" id="reimbursingCurrencyFrom" />	  --}%
                
            </td>
            <td/>
			<td><span class="field_label"> Reimbursing Currency </span></td>		
			<td>
                <%-- <g:select name="reimbursingCurrencyTo" value="${reimbursingCurrencyTo}" from="${['USD', 'EUR', 'HKD']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" /> --%>
                
                <%-- Auto Complete --%>
				<input class="tags_currency select2_dropdown bigdrop" name="reimbursingCurrencyTo" id="reimbursingCurrencyTo" />	  
                
            </td>
		</tr>
		<tr>
			<td>&#160;</td>
			<td><span class="field_label"> Reimbursing Bank Account Number </span></td>
			<td>
                <g:textField name="reimbursingBankAccountNumberFrom" value="${reimbursingBankAccountNumberFrom ?: reimbursingBankAccountNumber}" class="input_field" readonly="readonly" />
            </td>
            <td/>
			<td><span class="field_label"> Reimbursing Bank Account Number </span></td>
			<td>
                <g:textField name="reimbursingBankAccountNumberTo" class="input_field" value="${reimbursingBankAccountNumberTo}" />
            </td>
		</tr>
		<tr><td colspan="6" class="spacer">&#160;</td></tr>
        <tr>
            <td colspan="6">
                <div class="grid_wrapper">
                    <table id="add_conditions3_list"></table>
                    <div id="add_conditions3_pager"></div>
                    <g:hiddenField name="instructionToBankList" value="${instructionsToBank}" />
                </div>
            </td>
        </tr>
        <tr><td colspan="6" class="spacer">&#160;</td></tr>
		<tr>
			<td>
                <g:checkBox name="adviseThroughBankSwitchDisplay"/>
                <g:hiddenField name="adviseThroughBankSwitch" value="${adviseThroughBankSwitch ?: 'off'}"/>
            </td>
			<td colspan="5"><span class="p_header"> 'Advise Through' Bank </span></td>
		</tr>
		<tr>
			<td><g:radio name="adviseThroughBankFlagFrom" class="disabled" value="A" checked="${(adviseThroughBankFlagFrom ?: adviseThroughBankFlag) == 'A' ? true : false}" disabled="true"/></td>
			<td>Option A - Identifier Code</td>
			<td><g:textField name="adviseThroughBankIdentifierCodeFrom" value="${adviseThroughBankIdentifierCodeFrom ?: adviseThroughBankIdentifierCode}" class="input_field" readonly="readonly" /></td>
			<td><span class="">To:</span></td>
			<td><g:radio name="adviseThroughBankFlagTo" class="adviseBankTo adviseThroughBankA" value="A" checked="${adviseThroughBankFlagTo == 'A' ? true : false}"/>&#160;Option A - Identifier Code</td>
			<td><g:textField name="adviseThroughBankIdentifierCodeTo" value="${adviseThroughBankIdentifierCodeTo}" class="tags_bank select2_dropdown bigdrop" /></td>
		</tr>
		<tr>
			<td><g:radio name="adviseThroughBankFlagFrom" class="disabled" value="B" checked="${(adviseThroughBankFlagFrom ?: adviseThroughBankFlag) == 'B' ? true : false}" disabled="true"/></td>
			<td>Option B - Location</td>
			<td><g:textField name="adviseThroughBankLocationFrom" value="${adviseThroughBankLocationFrom ?: adviseThroughBankLocation}" class="input_field" readonly="readonly" /></td>
			<td/>
			<td><g:radio name="adviseThroughBankFlagTo" class="adviseBankTo adviseThroughBankB" value="B" checked="${adviseThroughBankFlagTo == 'B' ? true : false}"/>&#160;Option B - Location</td>
			<td><g:textField name="adviseThroughBankLocationTo" value="${adviseThroughBankLocationTo}" class="input_field"  maxlength="35" /></td>
		</tr>
		<tr>
			<td><g:radio name="adviseThroughBankFlagFrom" class="disabled" value="D" checked="${(adviseThroughBankFlagFrom ?: adviseThroughBankFlag) == 'D' ? true : false}" disabled="true"/></td>
			<td>Option D - Name and Address</td>
			<td><g:textArea name="adviseThroughBankNameAndAddressFrom" value="${adviseThroughBankNameAndAddressFrom ?: adviseThroughBankNameAndAddress}" class="textarea" rows="4" readonly="readonly" /></td>
			<td/>
			<td><g:radio name="adviseThroughBankFlagTo" class="adviseBankTo adviseThroughBankD" value="D" checked="${adviseThroughBankFlagTo == 'D' ? true : false}"/>&#160;Option D - Name and Address</td>
			<td>
                <div><g:textArea name="adviseThroughBankNameAndAddressTo" value="${adviseThroughBankNameAndAddressTo}" class="textarea"  maxlength="140" rows="4" /></div>
			</td>
		</tr>
		<tr><td colspan="6" class="spacer">&#160;</td></tr>
		<tr>
			<td>
                <g:checkBox  name="senderToReceiverSwitchDisplay"/>
                <g:hiddenField name="senderToReceiverSwitch" value="${senderToReceiverSwitch ?: 'off'}"/>
            </td>
			<td><span class="p_header"> Sender to Receiver </span></td>
			<td>
                <tfs:senderToReceiverTypeforMT700 name="senderToReceiverFrom" value="${senderToReceiverFrom ?: senderToReceiverInformation}" disabled="true"/>
            </td>
			<td colspan="2"><span class="field_label right_indent">To:</span></td>
			<td> 
				<tfs:senderToReceiverTypeforMT700 name="senderToReceiverTo" class="newSenderToReceiverAmendment" value="${senderToReceiverTo}" />
			</td>
		</tr>
		<tr>
			<td colspan="2">&#160;</td>
			<td> 
				<g:textArea name="senderToReceiverInformationFrom" value="${senderToReceiverInformationFrom ?: senderToReceiverInformationNarrative}" class="textarea" rows="4" readonly="readonly" />
			</td>
			<td colspan="2">&#160;</td>
			<td>
                <g:textArea name="senderToReceiverInformationTo" class="textarea" rows="4" value="${senderToReceiverInformationTo}"/>
                <input type="button" class="popup_btn_bottom" id="new_sender_info_amendment">
            </td>
		</tr>
		<tr><td colspan="6" class="spacer">&#160;</td></tr>
		<tr>
			<td>&#160;</td>
			<td colspan="6">  </td>
		</tr>
	</table>
	<br />
	%{--<div class="amendmentNarrative">--}%
		%{--<ul>--}%
			%{--<li><span class="p_header"> Narrative </span></li>--}%
			%{--<li><g:textArea name="narrative" id="narrative_ac2" value="${narrative}" class="amendment_narrative"/></li>--}%
			%{--<li><span class="field_label"><span id="remaining_char_narrative_ac2"></span>&#160;Characters</span></li>--}%
			%{--<li><span class="field_label"><span id="remaining_line_narrative_ac2"></span>&#160;Lines</span></li>--}%
		%{--</ul>--}%
	%{--</div>--}%
</g:if>
<br />
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<g:render template="../commons/popups/edit_instructions_to_bank_popup" />
<g:render template="../commons/popups/advise_through_bank_popup" />

<g:if test="${serviceType != 'Amendment' }">
<script>
    $(document).ready(function() {
    	$("#periodForPresentation").limitCharAndLines(35,1);
        $("#reimbursingCurrencyTo").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${reimbursingCurrencyTo}'});

        $("#reimbursingBankIdentifierCode").setDepositoryBankDropdownWithCurrency($("#currency").val()).select2('data',{id: '${reimbursingBankIdentifierCode}'});
        $("#reimbursingBankIdentifierCode").val("${reimbursingBankIdentifierCode}");
        $("#adviseThroughBankIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${adviseThroughBankIdentifierCode}'}); 

        if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").attr('checked',true);
            $("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").click();
        }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
	        if(!$("#temprbugl").val()) {
	            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
	            $("#accountType[value=FCDU]").attr('checked',true);
	            $("#accountType[value=FCDU]").click();
	        }
	
	        if(!$("#tempfcdugl").val()) {
	            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
	            $("#accountType[value=RBU]").attr('checked',true);
	            $("#accountType[value=RBU]").click();
	        }
        }
    });

    $("#reimbursingBankIdentifierCode").on("change", function(e) {
        var data = $("#reimbursingBankIdentifierCode").select2('data');
        if(data != null){
            $("#glCode").val(data.glcode);
            $("#reimbursingCurrency").val(data.currency);
            $("#reimbursingBankName").val(data.label);
            $("#tempfcdu").val(data.fcduAccount);
            $("#temprbu").val(data.rbuAccount);
            $("#tempfcdugl").val(data.glcodefcdu);
            $("#temprbugl").val(data.glcoderbu);

            $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
            $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
//            $("#glCode").val('');
            $("#reimbursingBankAccountNumber").val('');
        }else{
            $("#glCode").val('');
            $("#reimbursingCurrency").val('');
            $("#reimbursingBankName").val('');
            $("#tempfcdu").val('');
            $("#temprbu").val('');
            $("#tempfcdugl").val('');
            $("#temprbugl").val('');
        }
        if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=RBU]").attr('checked',true);
            $("#accountType[value=RBU]").click();
        }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
	        if(!$("#temprbugl").val()) {
	            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
	            $("#accountType[value=FCDU]").attr('checked',true);
	            $("#accountType[value=FCDU]").click();
	        }
	
	        if(!$("#tempfcdugl").val()) {
	            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
	            $("#accountType[value=RBU]").attr('checked',true);
	            $("#accountType[value=RBU]").click();
	        }
        }
		
    });

    $("input[name='accountType']").on("click", function(e) {
        //alert($("input[name='accountType']:checked").val());
        if($("input[name='accountType']:checked").val() == 'RBU') {
            $("#reimbursingBankAccountNumber").val($("#temprbu").val());
            $("#glCode").val($("#temprbugl").val());
            $("#accountType2").val('RBU');
        } else if($("input[name='accountType']:checked").val() == 'FCDU') {
            $("#reimbursingBankAccountNumber").val($("#tempfcdu").val());
            //$("#glCode").val($("#reimbursingBankIdentifierCode").select2('data').glcodefcdu);
            $("#glCode").val($("#tempfcdugl").val());
            $("#accountType2").val('FCDU');
        }
    });
</script>
</g:if>
<g:else>
	<script>
		$(document).ready(function(){
			$("#reimbursingCurrencyTo").setCurrencyDropdown($(this).attr("id"));
			$("#reimbursingBankIdentifierCodeTo").setDepositoryBankDropdownWithCurrency($("#currency").val()).select2('data',{id: '${reimbursingBankIdentifierCodeTo}'});
			$("#adviseThroughBankIdentifierCodeTo").setBankDropdown($(this).attr("id")).select2('data',{id: '${adviseThroughBankIdentifierCodeTo}'});
		});
	</script>
</g:else>
