<g:javascript src="popups/add_instruction_popup.js" />

<script type="text/javascript">
    var retrieveChargesOverridenFlag = '${g.createLink(controller:'instructionsAndRouting', action:'getChargesOverridenFlag')}';

    <%--Used by instructions_routing_jqgrid.js--%>
    var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
<%--Variable for hovered item in remarks grid--%>
    var rowId='';
    var inquireFacilityBalance = '${g.createLink(controller: 'facility', action: 'inquireFacilityBalance')}';
    var getFacilityBalanceResult = '${g.createLink(controller: 'facility', action: 'getFacilityBalanceRequest')}'
    var validatePaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validatePayments')}';
    var validateSavedProductPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedProductPayments')}';
    var validateSavedProductPayments2Url = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedProductPayments2')}';
    var validateSavedProceedsPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedProceedsPayments')}';
    var validateSavedChargesUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedCharges')}';
    var validateSavedChargesPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedChargesPayments')}';

    var checkUnpaidPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'checkUnpaidPayments')}';

    var getCurrentSystemDateUrl = '${g.createLink(controller:'facility', action:'getCurrentDate')}';

    var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';
    var multipleTradeServiceUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleTradeService")}';

    var reverseEtsFlag = '${reverseEts}';
    var reversalDataEntry = '${session.dataEntryModel?.reversalDataEntry}';

    var validateCutOffTimeUrl = '${g.createLink(controller: 'instructionsAndRouting', action: 'validateCutOffTime')}';
    $(document).ready(function() {

    	$("#btnApprove").click(function(){
			if (referenceType == "ETS"){
				$.post(validateCutOffTimeUrl,{}, function(data){
					if (data.cutOffStatus == true){
						$("#alertMessage").text("Warning: Transaction is beyond " + data.cutOffTime + " cut-off time.");
		            	triggerAlert();
					}
				});
			}
        });
        
        $(".mtRoute").click(function() {
            var caller = $(this).attr("id");

            if ($("#commandName").length > 0) {
                if (caller.toUpperCase().indexOf("RETURN") != -1) {
                    $("#commandName").val("RETURN");
                } else if (caller.toUpperCase().indexOf("ABORT") != -1) {
                    $("#commandName").val("ABORT");
                }
            }

            var mSave_div = $("#popup_save_confirmation");
            var mBg = $("#confirmation_background");

            mLoadPopup(mSave_div, mBg);
            mCenterPopup(mSave_div, mBg);
        });
    });
</script>

<g:javascript src="grids/instructions_routing_jqgrid.js" />
<g:if test="${!windowed}">
	<g:javascript src="utilities/ets/commons/instructions_and_routing_tab_utility.js" />
</g:if>

<g:if test="${referenceType == "ETS"}">
    <g:if test="${reverseEts}">
        <g:hiddenField name="reversalEtsNumber" value="${reversalEtsNumber}" />
        <g:hiddenField name="serviceType" value="${serviceType.contains('_REVERSAL') ? serviceType : serviceType.toUpperCase()+'_REVERSAL'}" />
    </g:if>
    <g:else>
        <g:hiddenField name="serviceType" value="${serviceType}" />
    </g:else>
</g:if>

<g:if test="${referenceType == "DATA_ENTRY"}">
    <g:if test="${reverseDE}">
        <g:hiddenField name="reversalDENumber" value="${reversalDENumber}" />
        <g:hiddenField name="serviceType" value="${serviceType.contains('_REVERSAL') ? serviceType : serviceType.toUpperCase()+'_REVERSAL'}" />
    </g:if>
    <g:else>
        <g:hiddenField name="serviceType" value="${serviceType}" />
    </g:else>
</g:if>

<g:if test="${session.dataEntryModel?.reversalDataEntry}">
    <g:hiddenField name="reversalTradeServiceId" value="${reversalTradeServiceId}" />
    <g:hiddenField name="reversalEtsNumber" value="${reversalEtsNumber}" />
</g:if>

<g:hiddenField name="referenceType" value="${session.mtModel ? "OUTGOING_MT" : referenceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="instructionsAndRouting" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="documentNumber" value="${documentNumber}" />

<ul class="buttons actionWidget">
	<li><a href="javascript:void(0)" id="add_instruction"> </a></li>
	<li>Add</li>
</ul>
<br />

<span class="title_label"> Instructions/Remarks </span>
<div class="grid_wrapper" id="grid_list_instructions_routing_remarks_div">
	%{--JQGRID--}%
	<table id="grid_list_instructions_routing_remarks">
	</table>
	<div id="grid_pager_instructions_routing_remarks"></div>
</div>
<br />
<br />

<g:hiddenField name="statusAction" value="" />
<br />

<g:if test="${session['userrole']['id']?.equalsIgnoreCase("BRM") || ((session['userrole']['id']?.equalsIgnoreCase("TSDM")) && (request.forwardURI.find("/ets/") == null)) || (session['userrole']['id']?.equalsIgnoreCase("TSDO") && session.dataEntryModel?.status?.equalsIgnoreCase("PENDING"))}">
	<g:if test="${!draftStatus?.equalsIgnoreCase('DRAFT')}">
	<table id="makerButton">
		<tr>
			<td><span id="routeToLabel" class="field_label actionWidget"> Route To </span></td>
			<td>
				<g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown actionWidget" id="routeTo"/>
			</td>
			<%-- <td><input type="button" class="input_button_negative button_override openSaveConfirmation etsButtons" value="Abort" id="btnAbort" /></td> --%>

			<td>

                <g:if test="${(session.dataEntryModel?.tsdInitiated != "true" && !session.mtModel) && !title?.contains('Indemnity Cancellation')}" >
                    <input type="button" class="input_button_negative button_override openSaveConfirmation2 etsButtons actionWidget" value="Abort" id="btnAbort" />
                </g:if>
                <g:else>
                    <g:if test="${session.mtModel}">
                        <input type="button" class="input_button_negative button_override dataEntryButtons mtRoute actionWidget" value="Abort" id="btnAbort" />
                    </g:if>
                    <g:else>
                        <input type="button" class="input_button_negative button_override openSaveConfirmation2 dataEntryButtons actionWidget" value="Abort" id="btnAbort" />
                    </g:else>
                </g:else>
            </td>
			<td>
                <g:if test="${session.dataEntryModel?.tsdInitiated != "true" && session.userrole.id.equals("TSDM") && !title?.contains('Indemnity Cancellation') && !details?.documentClass?.equals('MT')}" >
                	<input type="button" class="actionWidget input_button_negative3 button_override checkPayments openSaveConfirmationValidate dataEntryButtons" value="Return eTS to Branch" id="btnReturnEtsToBranch" />
                </g:if>
                %{--<g:else>--}%
                    %{--<input type="button" class="input_button_negative2 button_override openSaveConfirmation dataEntryButtons" value="Disapprove" id="btnDisapprove" />--}%
                %{--</g:else>--}%
            </td>
			<td>

				<%-- FOR TESTING PURPOSES ONLY --%>
				<%-- <input type="button" class="input_button2 button_override openSaveConfirmationValidate route" value="Prepare" id="btnPrepare" /> --%>
                %{--${paymentStatus}--}%
                <g:if test="${session['group']?.equalsIgnoreCase('TSD')}">
                    %{--checks if service type is cancellation--}%
                    <g:if test="${!(serviceType?.equalsIgnoreCase('CANCELLATION')) && !(serviceType?.equalsIgnoreCase('CREATE'))}">
                        %{--checks if payment status is paid if service type is not cancellation--}%
                        %{--enables prepare button if payment status is paid--}%
                        %{--<g:if test="${paymentStatus?.equalsIgnoreCase("PAID") || paymentStatus?.equalsIgnoreCase("NO_PAYMENT_REQUIRED") || !(documentClass?.equalsIgnoreCase("LC") || documentClass?.equalsIgnoreCase("INDEMNITY") || documentClass?.equalsIgnoreCase("DA") || documentClass?.equalsIgnoreCase("DP") || documentClass?.equalsIgnoreCase("OA") || documentClass?.equalsIgnoreCase("DR")) }">--}%
                        <g:if test="${!session.dataEntryModel?.reversalDataEntry}">
                        	<g:if test="${documentClass?.equalsIgnoreCase('LC') && serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType1?.equalsIgnoreCase('REGULAR') && documentSubType2?.equalsIgnoreCase('USANCE')}">
                        		<g:each in="${paymentsMade}">
                        		<g:if test="${it.PAYMENTINSTRUMENTTYPE == 'UA_LOAN' && it.STATUS == 'PAID'}">
									<input type="button" class="input_button2 button_override route actionWidget checkMtAndRequired" value="Prepare" id="btnPrepare" prepareType="h"/>
                        		</g:if>
                        		<g:else>
									<input type="button" class="input_button2 button_override route actionWidget" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="i"/>
                        		</g:else>
                        		</g:each>
	                    	</g:if>
                            <g:elseif test="${paymentStatus?.equalsIgnoreCase("PAID") || paymentStatus?.equalsIgnoreCase("NO_PAYMENT_REQUIRED") }">
                                <input type="button" class="input_button2 button_override actionWidget checkMtAndRequired" value="Prepare" id="btnPrepare" prepareType="a"/>
<%--                                <input type="button" class="input_button2 button_override route actionWidget" value="Prepare" id="btnPrepare" />--%>
                            </g:elseif>
                            %{--disables prepare button if payment status is unpaid--}%
                            <g:else>
                                <input type="button" class="input_button2 button_override actionWidget checkMtAndRequired" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="b"/>
                            </g:else>
                        </g:if>
                        <g:else>
                            <input type="button" class="input_button2 button_override checkPayments actionWidget" value="Prepare" id="btnPrepare" prepareType="c"/>
                        </g:else>

					    %{--<input type="button" class="input_button2 button_override openSaveConfirmationValidate route"  value="Prepare" id="btnPrepare" />--}%

				    </g:if>
                    %{--enables prepare button if service type is cancellation--}%
                    <g:else>
	                    <g:if test="${paymentStatus?.equalsIgnoreCase("PAID") || paymentStatus?.equalsIgnoreCase("NO_PAYMENT_REQUIRED")  
							|| (documentClass?.equalsIgnoreCase('INDEMNITY') && serviceType?.equalsIgnoreCase('CANCELLATION') && clientInitiatedFlag == 'Y')
							|| (!documentClass?.equalsIgnoreCase('INDEMNITY') && serviceType?.equalsIgnoreCase('CANCELLATION'))}">
							<input type="button" class="input_button2 button_override route actionWidget" value="Prepare" id="btnPrepare" prepareType="d"/>
						</g:if>
						<g:elseif test="${(documentClass.equalsIgnoreCase('MT') && serviceType.equalsIgnoreCase('CREATE'))}">
							<input type="button" class="input_button2 button_override checkMtAndRequired" value="Prepare" id="btnPrepare" prepareType="e"/>
						</g:elseif>
						<g:else>
							<input type="button" class="input_button2 button_override route actionWidget" value="Prepare" id="btnPrepare" disabled="disabled" prepareType="f"/>
						</g:else>
			        </g:else>
				</g:if>
                <g:else>
                    <g:if test="${reverseEts}">
                        %{--just prepare and no validation if branch and reversal--}%
                        <input type="button" class="input_button2 button_override route actionWidget" value="Prepare" id="btnPrepare" prepareType="g"/>
                    </g:if>
                    <g:else>
                        <input type="button" class="input_button2 button_override requiresBalanceCheck actionWidget" value="Prepare" id="btnPrepare"  prepareType="h"/>
                    </g:else>
				</g:else>
            </td>
		</tr>
	</table>
	</g:if>
</g:if>

<g:if test="${params.mode=="dev"}">
    '${session}'
    <br>
    <br>
    '${session['userrole']['id']}'
</g:if>


<g:if test="${(session['userrole']['id']?.equalsIgnoreCase("BRO") && session.etsModel?.approvalMode?.equals("CHECK")) ||
         (
            (session['userrole']['id']?.equalsIgnoreCase("TSDO")) &&
             (session.dataEntryModel?.approvalLevel == 1 || session.model?.approvalLevel == 1) &&
             (request.forwardURI.find("/ets/") == null) &&
             !(  (session.dataEntryModel?.status?.equalsIgnoreCase("PENDING") ||
                 session.model?.status?.equals("PENDING")) ||
                 (session.dataEntryModel?.status?.equalsIgnoreCase("POSTED") ||
                 session.model?.status?.equals("POSTED"))
              )
         ) ||
         (session.dataEntryModel?.status == 'PREPARED' || session.model?.status?.equals("PREPARED"))
		|| (status?.equalsIgnoreCase('PREPARED') && details?.documentClass?.equalsIgnoreCase('MT'))

    }">
	<table id="checkerButton">
		<tr>
			<td><span id="routeToLabel2" class="field_label actionWidget"> Route To </span></td>
			<td>
				<g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown actionWidget" />
			</td>
			<td>
                <g:if test="${session.mtModel}">
                    <input type="button" class="input_button_negative button_override mtRoute actionWidget" value="Return" id="btnReturnChecker" />
                </g:if>
                <g:else>
                    <input type="button" class="input_button_negative button_override openSaveConfirmation actionWidget" value="Return" id="btnReturnChecker" />
                </g:else>
            </td>
            %{--${session.postAuthority} | ${session.signingLimit} | ${session.amountToCheck}--}%
            <g:if test="${session.postAuthority == true}">
                <g:if test="${(session.signingLimit >= session.amountToCheck || session.financial == false) && !details?.documentClass?.equalsIgnoreCase('MT')}">
				    %{--<td><input type="button" class="input_button_long button_override openSaveConfirmation dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>--}%
                    <g:if test="${!(session.dataEntryModel?.reversalDataEntry)}">
                        %{--<td><input type="button" class="input_button_long button_override checkMt dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>--}%
                        <td><input type="button" class="input_button_long button_override dataEntryButtons route actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>
                    </g:if>
                    <g:else>
                        <td><input type="button" class="input_button_long button_override openSaveConfirmation dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>
                    </g:else>
                </g:if>
			</g:if>

<%--            <td><input type="button" class="button_override input_button openSaveConfirmation actionWidget" value="Check" id="btnCheck" />--%>
            <td><input type="button" class="input_button2 button_override route actionWidget" value="Check" id="btnCheck" /></td>
		</tr>
	</table>
</g:if>
<g:elseif test="${(session['userrole']['id']?.equalsIgnoreCase("BRO") && !session.etsModel?.approvalMode?.equals("APPROVE"))}">
    <table id="checkerButton">
        <tr>
            <td><span id="routeToLabel2" class="field_label actionWidget"> Route To </span></td>
            <td>
                <g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown actionWidget" />
            </td>
            <td><input type="button" class="input_button_negative button_override openSaveConfirmation actionWidget" value="Return" id="btnReturnChecker" /></td>
        %{--${session.postAuthority} | ${session.signingLimit} | ${session.amountToCheck}--}%
            <g:if test="${session.postAuthority == true}">
                <g:if test="${session.signingLimit >= session.amountToCheck || session.financial == false}">
                %{--<td><input type="button" class="input_button_long button_override openSaveConfirmation dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>--}%
                    <g:if test="${!(session.dataEntryModel?.reversalDataEntry)}">
                    %{--<td><input type="button" class="input_button_long button_override checkMt dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>--}%
                        <td><input type="button" class="input_button_long button_override dataEntryButtons route actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>
                    </g:if>
                    <g:else>
                        <td><input type="button" class="input_button_long button_override openSaveConfirmation dataEntryButtons actionWidget" value="Assume Posting Authority" id="btnPreApprove" /></td>
                    </g:else>
                </g:if>
            </g:if>

        <%--            <td><input type="button" class="button_override input_button openSaveConfirmation actionWidget" value="Check" id="btnCheck" />--%>
            <td><input type="button" class="input_button2 button_override route actionWidget" value="Check" id="btnCheck" /></td>
        </tr>
    </table>
</g:elseif>

<g:if test="${(session['userrole']['id']?.equalsIgnoreCase("BRO") && session.etsModel?.approvalMode?.equals("APPROVE")) ||
        (   (session['userrole']['id']?.equalsIgnoreCase("TSDO")) &&
            ((session.dataEntryModel?.approvalLevel > 1 || session.model?.approvalLevel > 1)) &&
            (request.forwardURI.find("/ets/") == null)
        ) ||
        (session.dataEntryModel?.status?.equals("POSTED") || session.model?.status?.equals("POSTED"))
		|| (status?.equalsIgnoreCase('CHECKED') && details?.documentClass?.equalsIgnoreCase('MT'))
    }">
	<table id="approverButton">
		<tr>
			<g:if test="${(session['userrole']['id']?.equalsIgnoreCase("TSDO")) && (session.dataEntryModel?.approverLevel < 4 || session.model?.approvalLevel < 4)}">

				<g:if test="${session.amountToCheck > session.signingLimit && session.financial == true}" >
                    <td>
                        <g:select name="routeTo" from="${session.nextRoute}" optionKey="ID" optionValue="ENAME" class="select_dropdown" />
                    </td>
                </g:if>

			</g:if>
			<td>
                <g:if test="${session.mtModel}">
                    <input type="button" class="input_button_negative button_override mtRoute actionWidget" value="Return" id="btnReturnChecker" />
                </g:if>
                <g:else>
                    <input type="button" class="input_button_negative button_override openSaveConfirmation actionWidget" value="Return" id="btnReturnApprover" />
                </g:else>
            </td>
			<g:if test="${!documentClass in ['EXPORT_ADVANCE','EXPORT_ADVISING','BP','BC','']}">
				<td><input type="button" class="input_button_negative2 button_override openSaveConfirmation etsButtons actionWidget" value="Disapprove" id="btnDisapprove" /></td>
			</g:if>
            <g:if test="${(session.dataEntryModel?.status?.equals("PRE_APPROVED") || session.model?.status?.equals("PRE_APPROVED")) || (session.dataEntryModel?.status?.equals("APPROVED") || session.model?.status?.equals("APPROVED")) || (session.dataEntryModel?.status?.equals("POSTED") || session.model?.status?.equals("POSTED"))}">
                <g:if test="${!(session.dataEntryModel?.reversalDataEntry)}">
				    %{--<td><input type="button" class="input_button2 button_override checkMt dataEntryButtons actionWidget" value="Post Approve" id="btnPostApprove" /></td>--}%
                    <td><input type="button" class="input_button2 button_override dataEntryButtons route actionWidget" value="Post Approve" id="btnPostApprove" /></td>
                </g:if>
                <g:else>
                    <td><input type="button" class="input_button2 button_override openSaveConfirmation route dataEntryButtons actionWidget" value="Post Approve" id="btnPostApprove" /></td>
                </g:else>
			</g:if>
			<g:else>
                <g:if test="${!(session.dataEntryModel?.reversalDataEntry)}">
				    %{--<td><input type="button" class="input_button2 button_override checkMt actionWidget" value="Approve" id="btnApprove" /></td>--}%
                    <td><input type="button" class="input_button2 button_override route actionWidget" value="Approve" id="btnApprove" /></td>
                </g:if>
                <g:else>
                    <td><input type="button" class="input_button2 button_override openSaveConfirmation actionWidget" value="Approve" id="btnApprove" /></td>
                </g:else>
			</g:else>
		</tr>
	</table>
</g:if>
<br />
<br />
<br />
<br />
<br />
<br />
<span class="title_label">Routing Information</span>
<div class="grid_wrapper">
	<table id="grid_list_instructions_routing_information"></table>
	<div id="grid_pager_instructions_routing_information"></div>
</div>

<g:render template="../commons/popups/add_instruction_popup" />
<g:render template="../commons/popups/over_availment_popup" />

<g:if test="${((((serviceType?.equalsIgnoreCase('UA Loan Settlement') ||
        serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) ||
        (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT')) && documentType?.equalsIgnoreCase('DOMESTIC')))) ||
        (documentType == 'DOMESTIC' && settleFlag != 'Y')}">

    <g:if test="${"Y".equals(pddtsFlag)}" >
        <g:hiddenField name="fundingReferenceNumber" class="pddts required" value="${fundingReferenceNumber}" />
        <g:hiddenField name="swift" class="pddts required" value="${swift}" />
        <g:hiddenField name="bank" class="pddts required" value="${bank}" />
        <g:hiddenField name="beneficiary" class="pddts required" value="${beneficiary}" />
    </g:if>

    <g:if test="${"Y".equals(mt103Flag)}" >
        <g:hiddenField name="receivingBank" class="mt103 required" value="${receivingBank}" />
        <g:hiddenField name="bankOperationCode" class="mt103 required" value="${bankOperationCode}" />
        <%--<g:hiddenField name="orderingAccountNumber" class="mt103 required" value="${orderingAccountNumber}" /> --Bug #1494 --%>
        <g:hiddenField name="orderingAccountNumber" class="mt103" value="${orderingAccountNumber}" />
        <g:hiddenField name="orderingAddress" class="mt103 required" value="${orderingAddress}" />
        <g:hiddenField name="accountWithInstitution" class="mt103" value="${accountWithInstitution}" />
        <g:hiddenField name="accountNameAndAddress" class="mt103" value="${accountNameAndAddress}" />
        <g:hiddenField name="beneficiaryName" class="mt103 required" value="${beneficiaryName}" />
        <g:hiddenField name="beneficiaryAddress" class="mt103 required" value="${beneficiaryAddress}" />
        <g:hiddenField name="detailsOfCharges" class="mt103 required" value="${detailsOfCharges}" />
    </g:if>

</g:if>

<g:javascript src="new/instructions_and_routing/required-validation-utils.js" />