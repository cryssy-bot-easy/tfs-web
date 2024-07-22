<%--//	PROLOGUE:
	(revision)
	SCR/ER Number: 20160218-092
	SCR/ER Description: redmine 4086 - AMLA Error in CTR1 Daily Monitoring as of December 15, 2015
	[Revised by:] Maximo Brian Lulab
	[Date revised:] 3/10/2016
	Program [Revision] Details: To validate the fields accept input with any first String,but AMLA should have first character/alphabet.
	Date deployment: 3/15/2016 
	Member Type: GSP
	Project: WEB
	Project Name: _tab_container.gsp
 --%>

<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _tab_container


>--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added hidden fields for validation.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_nonlc_details_foreign_tab.gsp
--%>
 

<script type="text/javascript">

	var autoCompleteCountryIsoUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountryIso')}';

    var paymentStatusUrl = '${g.createLink(controller: "product", action: "getPaymentStatus")}';

    var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment")}';
    var fromReverse = null;
    var referenceType = '${referenceType}';
    var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
    var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
    var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
    var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';

    var tradeServiceId = '${tradeServiceId}';
    var tradeServiceIdHolder = '${tradeServiceId}';
    var attachedDocumentsUrl;
    var uploadDocumentUrl;
    var deleteDocumentUrl;
    var downloadDocumentUrl;

    var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
    var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';
    var recomputeUrl = '${g.createLink(controller: "recompute", action: "recomputeCharge")}';

    var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';

    var recomputeChargesPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';

    var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
    var payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
    var verifyOfficerPasswordUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';
    var checkCasaBalanceUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';
    var inquireLoanStatusUrl = '${g.createLink(controller:'payment', action:'getLoanStatus')}';

    var errorCorrectUrl = '${g.createLink(controller:'product', action:'errorCorrectPayment')}';
    %{--var reversePaymentUrl = '${g.createLink(controller:'product', action:'reversePayment')}';--}%

    var reversePaymentUrl = '${g.createLink(controller:'payment', action:'reversePayment')}';
    var errorCorrectTfsUrl = '${g.createLink(controller:'payment', action:'errorCorrectTfsPayment')}';

    var exporterCbCodeUrl = '${g.createLink(controller:'cif', action:'searchCbCodeByCif')}';

    var documentClass = '${documentClass}';

    var documentType = '${documentType}';
    var documentSubType1 = '${documentSubType1}';
    var documentSubType2 = '${documentSubType2}';
    var serviceType = '${serviceType}';

    var loanCount = '${loanCount}';

    var recomputeCurrency_IMPORT_ADVANCE_PAYMENT_Url = '${g.createLink(controller:'recompute', action:'recomputeCurrency_IMPORT_ADVANCE_PAYMENT')}';
    var recomputeCurrency_IMPORT_ADVANCE_REFUND_Url = '${g.createLink(controller:'recompute', action:'recomputeCurrency_IMPORT_ADVANCE_PAYMENT')}';
    var recomputeCurrency_EXPORT_ADVANCE_REFUND_Url = '${g.createLink(controller:'recompute', action:'recomputeCurrency_EXPORT_ADVANCE_REFUND')}';

    if(documentClass.toUpperCase() == "IMPORT_ADVANCE") {      
        attachedDocumentsUrl = '${g.createLink(controller:'importAdvance', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
        downloadDocumentUrl = '${g.createLink(controller:'importAdvance', action:'downloadFile')}';
        uploadDocumentUrl = '${g.createLink(controller:'importAdvance', action:'uploadDocument')}';
		deleteDocumentUrl  = '${g.createLink(controller:'importAdvance', action:'deleteDocument')}';
    } else if(documentClass.toUpperCase() == "EXPORT_ADVANCE") {
        attachedDocumentsUrl = '${g.createLink(controller:'exportAdvance', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
        downloadDocumentUrl = '${g.createLink(controller:'exportAdvance', action:'downloadFile')}';
        uploadDocumentUrl = '${g.createLink(controller:'exportAdvance', action:'uploadDocument')}';
		deleteDocumentUrl  = '${g.createLink(controller:'exportAdvance', action:'deleteDocument')}';
    } else if(documentClass.toUpperCase() == "EXPORT_CHARGES") {
        if(serviceType == "PAYMENT"){
        	attachedDocumentsUrl = '${g.createLink(controller:'exportCharges', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
        	downloadDocumentUrl = '${g.createLink(controller:'exportCharges', action:'downloadFile')}';
        	uploadDocumentUrl = '${g.createLink(controller:'exportCharges', action:'uploadDocument')}';
			deleteDocumentUrl  = '${g.createLink(controller:'exportCharges', action:'deleteDocument')}';
        } else if(serviceType == "REFUND"){
        	attachedDocumentsUrl = '${g.createLink(controller:'exportsRefund', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
            downloadDocumentUrl = '${g.createLink(controller:'exportsRefund', action:'downloadFile')}';
            uploadDocumentUrl = '${g.createLink(controller:'exportsRefund', action:'uploadDocument')}';
     		deleteDocumentUrl  = '${g.createLink(controller:'exportsRefund', action:'deleteDocument')}';
        }
    } else if(documentClass.toUpperCase() == "IMPORT_CHARGES") {
        if(serviceType == "PAYMENT"){
        	attachedDocumentsUrl = '${g.createLink(controller:'importCharges', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
        	downloadDocumentUrl = '${g.createLink(controller:'importCharges', action:'downloadFile')}';
        	uploadDocumentUrl = '${g.createLink(controller:'importCharges', action:'uploadDocument')}';
			deleteDocumentUrl  = '${g.createLink(controller:'importCharges', action:'deleteDocument')}';
        }
    } else if(serviceType == "REFUND") {
    	attachedDocumentsUrl = '${g.createLink(controller:'refund', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
    	downloadDocumentUrl = '${g.createLink(controller:'refund', action:'downloadFile')}';
    	uploadDocumentUrl = '${g.createLink(controller:'refund', action:'uploadDocument')}';
		deleteDocumentUrl  = '${g.createLink(controller:'refund', action:'deleteDocument')}';
    } else {
    	attachedDocumentsUrl = '${g.createLink(controller:'exportAdvising', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceId);
		uploadDocumentUrl = '${g.createLink(controller:'exportAdvising', action:'uploadDocument')}';
		deleteDocumentUrl = '${g.createLink(controller:'exportAdvising', action:'deleteDocument')}';
		downloadDocumentUrl = '${g.createLink(controller:'exportAdvising', action:'downloadFile')}';
    }
    
    if(referenceType == 'PAYMENT') {
    	var _viewMode = ("TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && 'true' != '${title.contains('Data Entry') ? 'true' : 'false'}') ? "viewMode" : '${viewMode}';
    }
    else{
    	var _viewMode = '${viewMode}';
    	var hasRoute='${hasRoute}';
    }
    
    var formId = "#basicDetailsTabForm";

    var pddtsFlag = '${pddtsFlag}';
    var mt103Flag = '${mt103Flag}';

    function triggerAlertMessage(alertMessage){
        $("#alertMessage").html(alertMessage);
        triggerAlert();
    }

    function triggerAlert() {
        var mSave_div = $("#popup_alert_dv");
        var mBg = $("#popup_alert_bg");

        mLoadPopup(mSave_div, mBg);
        mCenterPopup(mSave_div, mBg);
    }

    function onAlertOkClick() {
        var mSave_div = $("#popup_alert_dv");
        var mBg = $("#popup_alert_bg");

        mDisablePopup(mSave_div, mBg);
    }

    function showExcessAmountCharges() {
    	if($("#totalAmountDue").val() != ""){
			var computedTotalAmountDue = parseFloat($("#totalAmountDue").val().replace(/,/g,""));
	    	var computedTotalAmountOfPaymentCharges = parseFloat($("#totalAmountOfPaymentCharges").val().replace(/,/g,""));
	    	var computedExcessAmountCharges = computedTotalAmountOfPaymentCharges - computedTotalAmountDue;
			if(computedExcessAmountCharges > 0.00){
	    		$("#excessAmountCharges").val(formatCurrency(computedExcessAmountCharges));
			}else {
				$("#excessAmountCharges").val(formatCurrency(0));
			}
		}
    }

    $(document).ready(function() {
        $("#basicDetailsTab").click(function() {
            formId = "#basicDetailsTabForm";
        });

        $("#setupLcDetailsTab").click(function() {
            formId = "#setupLcDetailsTabForm";
        });

        $("#setupNonLcDetailsTab").click(function() {
            formId = "#setupNonLcDetailsTabForm";
        });

        $("#docEnclosedInstructionsTab").click(function() {
            formId = "#docEnclosedInstructionsTabForm";
        });

        $("#loanSetupTab").click(function() {
            formId = "#loanSetupTabForm";
        });

        $("#processRefundTab, #productPaymentTab").click(function() {
            formId = "#productPaymentTabForm";
        });

        $("#proceedsDetailsTab, #modeOfRefundTab").click(function() {
            formId = "#proceedsDetailsTabForm";
        });

        $("#chargesPaymentTab, #modeOfPaymentTab").click(function() {
            formId = "#chargesPaymentTabForm";
            showExcessAmountCharges();
        });
       
        $("#mt103Tab").click(function() {
            formId = "#mt103TabForm";
        });

        $("#pddtsTab").click(function() {
            formId = "#pddtsTabForm";
        });

        $("#instructionsTab").click(function() {
            formId = "#instructionsAndRoutingTabForm";
        });

        $("#btnAlertOk").click(onAlertOkClick);


        // pddts
        $("#pddtsTabLi").hide();
        $("#pddtsTabForm .required").removeClass("required").addClass("notRequired");
        
        $("#mt103TabLi").hide();
        $("#mt103TabForm .required").removeClass("required").addClass("notRequired");

        if (pddtsFlag == "Y") {
            $("#pddtsTabLi").show();
        	$("#pddtsTabForm .notRequired").removeClass("notRequired").addClass("required");
        }

        if (mt103Flag == "Y") {
            $("#mt103TabLi").show();
       		$("#mt103TabForm .notRequired").removeClass("notRequired").addClass("required");
        }

        $(".AccordionPanel a").each(function(){
            if($(this).text().indexOf("View MT") != -1 && $(this).css("pointer-events") != "none"){
            	$("#btnPrepare").removeClass("openConfirmRoute");
            	$("#btnPrepare").removeClass("openConfirmRoute2");
            	$("#btnPrepare").addClass("checkMtAndRequired");
            }
        });
    });

    $(window).load(function() {
        if (${session.userrole.id.contains("TSD") && !(session.userrole.id.equals("TSDM"))}) {
            disableAllFields();
        }
    });

    function disableAllFields() {
        $("#body_forms :input").each(function () {
            if ($(this).attr("type") == "button") {
                if ($(this).attr("class") != undefined && $(this).attr("class") != null) {
                    if ($(this).attr("class").indexOf("openConfirmRoute") == -1 &&
                            $(this).attr("class").indexOf("openConfirmRoute2") == -1 &&
                            $(this).attr("class").indexOf("abort") == -1 &&
                            $(this).attr("class").indexOf("returnTransaction") == -1 &&
                            $(this).attr("class").indexOf("checkMtAndRequired") == -1) {
                        $(this).attr("disabled", "disabled");
                    }
                } else {
                    $(this).attr("disabled", "disabled");
                }
            } else {
                if ($(this).attr("type") == "checkbox") {
                    $(this).attr("disabled", "disabled");
                } else if ($(this).prop("type") == "select-one") {
                    var id = $(this).attr("name");

                    if (!id) {
                        id = $(this).attr("id");
                    }

                    if (id != "routeTo") {
                        $(this).attr("disabled", "disabled");
                    }
                } else if ($(this).prop("type") == "radio") {
                    var id = $(this).attr("name");

                    if (id) {
                        $("input[type=radio][name=" + id + "]").attr("disabled", "disabled");
                    } else {
                        id = $(this).attr("id");

                        $("input[type=radio][id=" + id + "]").attr("disabled", "disabled");
                    }
                } else {
                    if ($(this).is(":hidden") == false) {
                        $(this).attr("disabled", "disabled");
                    }
                }

                // disable all auto complete
                if ($(this).attr("class") != undefined && $(this).attr("class") != null) {
                    if ($(this).attr("class").indexOf("select2")) {
                        $(this).select2("disable");
                    }
                }
            }
        });

        $("#body_forms a").each(function() {
            if ($(this).attr("class") && $(this).attr("class").indexOf("add_btn") != -1) {
                $(this).hide();
            }
        });
    }
</script>
<g:if test="${windowed}">
    <g:javascript src="utilities/ets/commons/window_utility.js" />
</g:if>
<%--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--%>
<g:javascript src="utilities/ets/opening/initialize_forms.js" />
<g:javascript src="utilities/commons/initialize_charges_tab.js" />
<g:javascript src="new/mode_of_payment_utils.js" />	
<%-- <g:javascript src="popups/mode_of_payment_charges_popup.js" /> --%>
<g:javascript src="popups/ets_opening_header_utility.js" />
<g:javascript src="utilities/commons/ets_index_utility.js" />
<g:javascript src="utilities/commons/textarea_utility.js" />
<g:javascript src="utilities/validation/validate_active_tab.js" />
<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />
<g:hiddenField name="prevTab" />
<g:hiddenField name="docuClass" value="${documentClass}" />
<div id="body_forms">
	<g:if
		test="${(!documentClass.equals("CDT") && !referenceType.equals("TRANSACTIONS")) &&
        !(documentClass.equals("CORRES_CHARGE") && session.dataEntryModel?.withoutReference)}">
		<div id="body_forms_header">
			<div id="header_details">
                <h3 class="header_details_title" id="longNameDisplay"> ${longName} </h3>
                <h3 class="header_details_title" id="address1Display"> ${address1} </h3>
                <h3 class="header_details_title" id="address2Display"> ${address2} </h3>
				<br />
				<br />
				<br />
			</div>
			<table id="header_details2">
				<tr class="test">
					<td><span class="field_label"> CIF Number
                            <g:if test="${(session['userrole']['id'].equals("BRM") && (serviceType?.equalsIgnoreCase("payment") || referenceType.equals("CLIENT")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("EXPORT_ADVISING") && serviceType.contains("OPENING")) && referenceType.equals("DATA_ENTRY")) ||
                            (session['userrole']['id'].equals("BRM") && documentClass.equals("BP") && serviceType.equals("NEGOTIATION")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("BC") && serviceType.equals("NEGOTIATION")) ||
							(session['userrole']['id'].equals("TSDM") && (documentClass.equals("CORRES_CHARGE") || documentClass.equals("BC")) && session.dataEntryModel?.withoutReference != true) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass in ["IMPORT_CHARGES", "EXPORT_CHARGES"] && serviceType.equals("PAYMENT_OTHER")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("EXPORT_CHARGES") && serviceType.equals("PAYMENT"))}">
								<span class="cifNumber asterisk">*</span>
							</g:if>
					</span></td>
					<td>
                        <g:textField class="input_field numericString ${(session['userrole']['id'].equals("BRM") && (serviceType?.equalsIgnoreCase("payment") || referenceType.equals("CLIENT")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("EXPORT_ADVISING") && serviceType.contains("OPENING")) && referenceType.equals("DATA_ENTRY")) ||
                            (session['userrole']['id'].equals("BRM") && documentClass.equals("BP") && serviceType.equals("NEGOTIATION")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("BC") && serviceType.equals("NEGOTIATION")) ||
							(session['userrole']['id'].equals("TSDM") && (documentClass.equals("CORRES_CHARGE") || documentClass.equals("BC")) && session.dataEntryModel?.withoutReference != true) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass in ["IMPORT_CHARGES", "EXPORT_CHARGES"] && serviceType.equals("PAYMENT_OTHER")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("EXPORT_CHARGES") && serviceType.equals("PAYMENT")) ? 'required' : ''}"
                        name="cifNumber" readonly="readonly" value="${cifNumber}" />

                        <g:if
							test="${(session['userrole']['id'].equals("BRM") && ((serviceType?.equalsIgnoreCase("PAYMENT") && !(documentClass in ["IMPORT_CHARGES", "EXPORT_CHARGES"]))) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("EXPORT_ADVISING") && serviceType.contains("OPENING")) && referenceType.equals("DATA_ENTRY")) ||
                            (session['userrole']['id'].equals("BRM") && documentClass.equals("BP") && serviceType.equals("NEGOTIATION")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("BC") && serviceType.equals("NEGOTIATION")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("REBATE")) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass.equals("CORRES_CHARGE") && session.dataEntryModel?.withoutReference != true) ||
                            (session['userrole']['id'].equals("TSDM") && documentClass in ["IMPORT_CHARGES", "EXPORT_CHARGES"] && serviceType.equals("PAYMENT_OTHER")) ||
                            (session['userrole']['id'] in ["TSDM", "BRM"] && referenceType.equals("CLIENT"))}">
							<a href="javascript:void(0)" class="search_btn"
								id="popup_btn_cif"> Search/Look-up Button </a>
						</g:if>
                    </td>
				</tr>
				<tr>
					<td><span class="field_label"> CIF Name </span></td>
					<td colspan="2"><g:textField class="input_field"
							readonly="readonly" name="cifName" value="${cifName}" /></td>
				</tr>
				<tr>
					<td><span class="field_label"> Account Officers </span></td>
					<td colspan="2"><g:textField class="input_field"
							readonly="readonly" name="accountOfficer"
							value="${accountOfficer}" /></td>
				</tr>
				<tr>

					<td><span class="field_label"> CCBD/Branch Unit Code </span></td>
					<td colspan="2"><g:textField class="input_field"
							readonly="readonly" name="ccbdBranchUnitCode"
							value="${ccbdBranchUnitCode}" />
							<g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
							</td>
				</tr>
			</table>

		</div>
	</g:if>
	<br /> <br />


  	<g:if test="${(documentfor.equals("reportCDT"))}">
  	
  	<div id="tab_container">
 
 <ul id="tabs">
				<g:if test="${tabs.contains("basicDetails")}">
					<li><a href="#basic_details_tab" id="basicDetailsTab"><span
							class="tab_titles"> View Report<br />&#160;
                    </span></a></li>
				</g:if>
				
				<br /> <br />
				 <div id="basic_details_tab">
        <form id="basicDetailsTabForm" action="${basicDetailsAction}"
            method="POST">
 
            <g:hiddenField name="cifNumberParam" value="${cifNumber}" />
            <g:hiddenField name="cifNameParam" value="${cifName}" />
            <g:hiddenField name="accountOfficerParam" value="${accountOfficer}" />
            <g:hiddenField name="ccbdBranchUnitCodeParam"  value="${ccbdBranchUnitCode}" />
			<g:hiddenField name="allocationUnitCodeParam" value="${allocationUnitCode}"/>

            <g:hiddenField name="longName" value="${longName}" />
            <g:hiddenField name="address1" value="${address1}" />
            <g:hiddenField name="address2" value="${address2}" />
            <g:hiddenField name="firstName" value="${firstName}"/>
			<g:hiddenField name="middleName" value="${middleName}"/>
			<g:hiddenField name="lastName" value="${lastName}"/>
			<g:hiddenField name="tinNumber" value="${tinNumber}"/>
			<g:hiddenField name="officerCode" value="${officerCode}"/>
			<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>

            <g:render template="${basicDetailsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                model="[confirmId: 'basicDetailsSave', cancelId: 'basicDetailsCancel', confirmDivId: 'basicDetailsDiv', confirmBgId: 'basicDetailsBg']" />
        </form>
    </div>
  </ul>
  </div>
  	
  	</g:if>	
  	<g:else>
  	


	<div id="tab_container">
		<g:if test="${tabs?.size() > 0}">
			<ul id="tabs">
				<g:if test="${tabs.contains("basicDetails")}">
					<li><a href="#basic_details_tab" id="basicDetailsTab"><span
							class="tab_titles"> Basic Details<br />&#160;
                    </span></a></li>
				</g:if>

                <g:if test="${tabs.contains("setupLcDetails")}">
                    <li><a href="#setup_lc_details_tab" id="setupLcDetailsTab"><span
                            class="tab_titles"> Set-up <br /> LC Details
                    </span></a></li>
                </g:if>

                <g:if test="${tabs.contains("setupNonLcDetails")}">
                    <li><a href="#setup_nonlc_details_tab" id="setupNonLcDetailsTab"><span
                            class="tab_titles"> Set-up <br /> Non-LC Details
                    </span></a></li>
                </g:if>

                <g:if test="${tabs.contains("docEnclosedInstructions")}">
                    <li><a href="#doc_enclosed_instructions_tab" id="docEnclosedInstructionsTab"><span
                            class="tab_titles"> Documents Enclosed <br /> and Instructions
                    </span></a></li>
                </g:if>

                <g:if test="${tabs.contains("attachedDocuments")}">
                    <li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span
                            class="tab_titles"> Attached Documents <br /> &#160;
                    </span></a></li>
                </g:if>

				<g:if test="${tabs.contains("mtDetails")}">
					<li><a href="#mt_details_tab" id="mtDetailsTab"><span
							class="tab_titles"> MT 103 <br /> &#160;
						</span></a></li>
				</g:if>
				<g:if test="${tabs.contains("productPayment")}">
					<li><a href="#import_advance_amount_details_tab"
						id="cashLcPaymentTab"><span class="tab_titles"> ${productPaymentTabLabel}
						</span></a></li>
				</g:if>

                <g:if test="${tabs.contains("actualCorres")}">
                    <li><a href="#actual_corres_tab"
                           id="actualCorres"><span class="tab_titles"> Actual Corres Charge
                            <br /> &#160;
                        </span></a></li>
                </g:if>

                <g:if test="${tabs.contains("loanSetup")}">
                    <li><a href="#loan_setup_tab" id="loanSetupTab"><span
                            class="tab_titles"> Loan <br /> Details
                    </span></a></li>
                </g:if>
				<g:if test="${tabs.contains("refundDetailsProduct")}">
					<li><a href="#refund_details_product_tab"
						id="refundDetailsProductTab"><span class="tab_titles">
								Refund Details to LC Amount <br /> &#160;
						</span></a></li>
				</g:if>
				
				<g:if test="${!windowed?.equalsIgnoreCase('true')}">
					<g:if test="${tabs.contains("settlementToBeneficiary")}">
						<li><a href="#settlement_to_ben_tab"
						id="proceedsDetailsTab"><span class="tab_titles">
	                            Settlement to<br/>Beneficiary
							</span></a></li>
					</g:if>
					<g:if test="${tabs.contains("charges")}">
						<li><a href="#charges_tab" id="chargesTab"><span
								class="tab_titles"> Charges <br /> &#160;
							</span></a></li>
					</g:if>
					<g:if test="${tabs.contains("chargesPayment")}">
						<li><a href="#charges_payment_details_tab"
							id="chargesPaymentTab"><span class="tab_titles">
									Charges<br />Payment
	                        </span></a></li>
					</g:if>
				</g:if>

				%{--
				<g:if test="${tabs.contains("pddts")}">--}%
                    <li id="pddtsTabLi"><a href="#pddts_tab"
						id="pddtsTab"><span class="tab_titles"> PDDTS<br>&#160;
						</span></a>
                    </li>
                %{--</g:if>
				--}% %{--
				<g:if test="${tabs.contains("mt103")}">--}%
                    <li id="mt103TabLi"><a href="#mt103_tab"
						id="mt103Tab"><span class="tab_titles"> MT103<br>&#160;
						</span></a>
                    </li>
                %{--</g:if>
				--}%

				<g:if test="${tabs.contains("refundDetailsService")}">
					<li><a href="#refund_details_service_tab"
						id="refundDetailsServiceTab"><span class="tab_titles">
								Refund Details for Charges <br /> &#160;
						</span></a></li>
				</g:if>

                <g:if test="${tabs.contains("paymentDetailsService")}">
                    <li><a href="#payment_details_service_tab"
                           id="paymentDetailsServiceTab"><span class="tab_titles">
                            Payment Details for Charges <br /> &#160;
                        </span></a></li>
                </g:if>

                <g:if test="${tabs.contains("mt202")}">
                    <li class="showMt202Tab"><a href="#mt202_tab" id="mt202Tab"><span class="tab_titles"> MT202<br>&#160;</span></a></li>
                </g:if>

        <g:if test="${tabs.contains("modeOfRefund")}">
            <li><a href="#mode_of_refund_tab" id="proceedsDetailsTab"><span
                    class="tab_titles"> Mode of Refund <br /> &#160;
                </span></a></li>
        </g:if>

        <g:if test="${tabs.contains("modeOfPayment")}">
            <li><a href="#mode_of_payment_tab" id="chargesPaymentTab"><span
                class="tab_titles"> Mode of Payment <br /> &#160;
            </span></a></li>
        </g:if>

        <g:if test="${tabs.contains("instructionsAndRouting")}">
            <li><a href="#instructions_tab" id="instructionsTab"><span
                    class="tab_titles"> Instructions <br /> and Routing
                </span></a></li>
        </g:if>
    </ul>
</g:if>
<g:else>
    <ul>
        <li>&nbsp;</li>
    </ul>
    <div id="basic_details_tab">
        <g:render template="${content}" />
    </div>
</g:else>

<g:if test="${tabs.contains("basicDetails")}">
    <div id="basic_details_tab">
        <form id="basicDetailsTabForm" action="${basicDetailsAction}"
            method="POST">

            <g:hiddenField name="cifNumberParam" value="${cifNumber}" />
            <g:hiddenField name="cifNameParam" value="${cifName}" />
            <g:hiddenField name="accountOfficerParam" value="${accountOfficer}" />
            <g:hiddenField name="ccbdBranchUnitCodeParam"  value="${ccbdBranchUnitCode}" />            
			<g:hiddenField name="allocationUnitCodeParam" value="${allocationUnitCode}"/>

            <g:hiddenField name="longName" value="${longName}" />
            <g:hiddenField name="address1" value="${address1}" />
            <g:hiddenField name="address2" value="${address2}" />
            <g:hiddenField name="firstName" value="${firstName}"/>
			<g:hiddenField name="middleName" value="${middleName}"/>
			<g:hiddenField name="lastName" value="${lastName}"/>
			<g:hiddenField name="tinNumber" value="${tinNumber}"/>
			<g:hiddenField name="officerCode" value="${officerCode}"/>
			<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>

            <g:render template="${basicDetailsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                model="[confirmId: 'basicDetailsSave', cancelId: 'basicDetailsCancel', confirmDivId: 'basicDetailsDiv', confirmBgId: 'basicDetailsBg']" />
        </form>
    </div>
</g:if>

<g:if test="${tabs.contains("loanSetup")}">
    <form id="loanSetupTabForm" action="${loanSetupAction}" method="POST">
        <div id="loan_setup_tab">
            <g:render template="${loanSetupTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                      model="[confirmId: 'loanSetupSave', cancelId: 'loanSetupCancel', confirmDivId: 'loanSetupDiv', confirmBgId: 'loanSetupBg']" />
        </div>
    </form>
</g:if>

<g:if test="${tabs.contains("setupLcDetails")}">
    <form id="setupLcDetailsTabForm" action="${setupLcDetailsAction}" method="POST">
        <div id="setup_lc_details_tab">
            <g:render template="${setupLcDetailsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                      model="[confirmId: 'setupLcDetailsSave', cancelId: 'setupLcDetailsCancel', confirmDivId: 'setupLcDetailsDiv', confirmBgId: 'setupLcDetailsBg']" />
        </div>
    </form>
</g:if>

<g:if test="${tabs.contains("setupNonLcDetails")}">
    <form id="setupNonLcDetailsTabForm" action="${setupNonLcDetailsAction}" method="POST">
        <div id="setup_nonlc_details_tab">
            <g:render template="${setupNonLcDetailsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                      model="[confirmId: 'setupNonLcDetailsSave', cancelId: 'setupNonLcDetailsCancel', confirmDivId: 'setupNonLcDetailsDiv', confirmBgId: 'setupNonLcDetailsBg']" />
        </div>
    </form>
</g:if>

<g:if test="${tabs.contains("docEnclosedInstructions")}">
    <form id="docEnclosedInstructionsTabForm" action="${docEnclosedInstructionsAction}" method="POST">
        <div id="doc_enclosed_instructions_tab">
            <g:render template="${docEnclosedInstructionsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                      model="[confirmId: 'docEnclosedInstructionsSave', cancelId: 'docEnclosedInstructionsCancel', confirmDivId: 'docEnclosedInstructionsDiv', confirmBgId: 'docEnclosedInstructionsBg']" />
        </div>
    </form>
</g:if>

<g:if test="${tabs.contains("attachedDocuments")}">
    <div id="attached_documents_tab">
        <g:render template="../commons/tabs/attached_documents_tab" />
    </div>
</g:if>

<g:if test="${tabs.contains("mtDetails")}">
    <form id="mtDetailsTabForm" action="${mtDetailsAction}" method="POST">
        <div id="mt_details_tab">
            <g:render template="${mtDetailsTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                model="[confirmId: 'mtDetailsSave', cancelId: 'mtDetailsCancel', confirmDivId: 'mtDetailsDiv', confirmBgId: 'mtDetailsBg']" />
        </div>
    </form>
</g:if>

<g:if test="${tabs.contains("productPayment")}">
    <form id="productPaymentTabForm" action="${productPaymentAction}"
        method="POST">
        <div id="import_advance_amount_details_tab">
            <g:render template="${productPaymentTab}" />
            <g:render template="../product/commons/popups/confirm_alert"
                model="[confirmId: 'productPaymentSave', cancelId: 'productPaymentCancel', confirmDivId: 'productPaymentDiv', confirmBgId: 'productPaymentBg']" />
        </div>
    </form>
</g:if>

    <g:if test="${tabs.contains("actualCorres")}">
        <form id="actualCorresTabForm" action="${actualCorresAction}"
              method="POST">
            <div id="actual_corres_tab">
                <g:render template="${actualCorresTab}" />
            </div>
        </form>
    </g:if>

<g:if test="${tabs.contains("refundDetailsProduct")}">
    %{--<form id="productPaymentTabForm"
        action="${productPaymentAction}" method="POST">
        --}%
				<div id="refund_details_product_tab">
					<g:render template="${refundDetailsProductTab}" />
					%{--
					<g:render template="../product/commons/popups/confirm_alert"
						model="[confirmId: 'productPaymentSave', cancelId: 'productPaymentCancel', confirmDivId: 'productPaymentDiv', confirmBgId: 'productPaymentBg']" />
					--}%
				</div>
				%{--
			</form>--}%
        </g:if>
        
        <g:if test="${!windowed?.equalsIgnoreCase('true')}">
			<g:if test="${tabs.contains("settlementToBeneficiary")}">
			<form id="proceedsDetailsTabForm"
					action="${settlementToBeneficiaryAction}" method="POST">
					<div id="settlement_to_ben_tab">
					<g:render template="${proceedsDetailsTab}" />
						<g:render template="../product/commons/popups/confirm_alert"
							model="[confirmId: 'settlementToBenSave', cancelId: 'settlementToBenCancel', confirmDivId: 'settlementToBenDiv', confirmBgId: 'settlementToBenBg']" />
					</div>
				</form>
			</g:if>
	
			<g:if test="${tabs.contains("charges")}">
	            <g:if test="${"BC".equalsIgnoreCase(documentClass)}">
	                <div id="charges_tab">
	                    <form id="chargesTabForm" action="${chargesAction}" method="POST">
	                        <g:render template="${chargesTab ?: "../product/commons/tabs/charges_tab"}" />
	                        <g:render template="../product/commons/popups/confirm_alert"
	                                  model="[confirmId: 'chargesSave', cancelId: 'chargesCancel', confirmDivId: 'chargesDiv', confirmBgId: 'chargesBg']" />
	                    </form>
	                </div>
	            </g:if>
	            <g:else>
	                <div id="charges_tab">
	                    <form id="chargesTabForm" action="${chargesAction}" method="POST">
	                        <g:render template="${chargesTab ?: "../product/commons/tabs/charges_tab"}" />
	                        <g:render template="../product/commons/popups/confirm_alert"
	                                  model="[confirmId: 'chargesSave', cancelId: 'chargesCancel', confirmDivId: 'chargesDiv', confirmBgId: 'chargesBg']" />
	                    </form>
	                </div>
	            </g:else>
			</g:if>
	
			<g:if test="${tabs.contains("chargesPayment")}">
				<div id="charges_payment_details_tab">
					<form id="chargesPaymentTabForm" action="${chargesPaymentAction}"
						method="POST">
						<g:render template="${chargesPaymentTab}" />
						<g:render template="../product/commons/popups/confirm_alert"
							model="[confirmId: 'chargesPaymentSave', cancelId: 'chargesPaymentCancel', confirmDivId: 'chargesPaymentDiv', confirmBgId: 'chargesPaymentBg']" />
					</form>
				</div>
			</g:if>
		</g:if>

		<g:if test="${tabs.contains("pddts")}">
			<div id="pddts_tab">
				<form id="pddtsTabForm" action="${pddtsAction}" method="POST">
					<g:render
						template="${pddtsTab}" />
					<g:render template="../product/commons/popups/confirm_alert"
						model="[confirmId: 'pddtsSave', cancelId: 'pddtsCancel', confirmDivId: 'pddtsDiv', confirmBgId: 'pddtsBg']" />
				</form>
			</div>
		</g:if>

		<g:if test="${tabs.contains("mt103")}">
			<div id="mt103_tab">
				<form id="mt103TabForm" action="${mt103Action}" method="POST">
					<g:render
						template="${mt103Tab}" />
					<g:render template="../product/commons/popups/confirm_alert"
						model="[confirmId: 'mt103Save', cancelId: 'mt103Cancel', confirmDivId: 'mt103Div', confirmBgId: 'mt103Bg']" />
				</form>
			</div>
		</g:if>

        <g:if test="${tabs.contains("mt202")}">
            <div id="mt202_tab">
                <form id="mt202TabForm" action="${mt202Action}" method="POST">
                    <g:render template="${mt202Tab}" />
                </form>
            </div>
        </g:if>

		<g:if test="${tabs.contains("refundDetailsService")}">
        %{--<form id="productPaymentTabForm"
				action="${productPaymentAction}" method="POST">
				--}%
				<div id="refund_details_service_tab">
					<g:render template="${refundDetailsServiceTab}" />
					%{--
					<g:render template="../product/commons/popups/confirm_alert"
						model="[confirmId: 'productPaymentSave', cancelId: 'productPaymentCancel', confirmDivId: 'productPaymentDiv', confirmBgId: 'productPaymentBg']" />
					--}%
				</div>
				%{--
			</form>--}%
        </g:if>

        <g:if test="${tabs.contains("paymentDetailsService")}">
            <div id="payment_details_service_tab">
                <g:render template="${paymentDetailsServiceTab}" />
            </div>
        </g:if>

		<g:if test="${tabs.contains("modeOfRefund")}">
            <form id="proceedsDetailsTabForm"
                action="${modeOfRefundAction}" method="POST">
				<div id="mode_of_refund_tab">
					<g:render template="${modeOfRefundTab}" />
				</div>
			</form>
        </g:if>

        <g:if test="${tabs.contains("modeOfPayment")}">
            <form id="chargesPaymentTabForm"
                  action="${modeOfPaymentAction}" method="POST">
                <div id="mode_of_payment_tab">
                    <g:render template="${modeOfPaymentTab}" />
                </div>
            </form>
        </g:if>

		<g:if test="${tabs.contains("instructionsAndRouting")}">
			<div id="instructions_tab">
				<form id="instructionsAndRoutingTabForm" action="${routeAction}"
					method="POST">
					<g:render
						template="../product/commons/tabs/instructions_and_routing_tab" />
				</form>
			</div>
		</g:if>
	</div>
	</g:else>
	<%-- End of TABS --%>
</div>
<script>
    if (!window.console) {
        console = {
            log: function(){
                // do nothing
                // this is to avoid errors in ie7
            }
        };
    }
	var val_msg = ""
	function validateExportTab(tabId) {
		var error = 0;
		if(tabId == "#basicDetailsTabForm"){
			val_msg = ""
			$("#basicDetailsTabForm :input").each(function(){
		        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
		           if ($(this).val() == "") {
		               error ++;
		               if(val_msg.length > 0){
		            	   val_msg += ",<br/>";
		               }
	                   val_msg += $(this).attr("name");
		           }
		        }
		    });
			if ($("#cifNumber").attr("class") != undefined && $("#cifNumber").attr("class") != null && $("#cifNumber").attr("class").indexOf("required") != -1) {
		        if ($("#cifNumber").val() == "") {
		            error ++;
		            if(val_msg.length > 0){
		            	   val_msg += "<br/>";
		               }
	                val_msg += "cifNumber";
		        }
		    }
			  // start of max validation of redmine 3705   as of 03/22/2016
		//	 if ($("#countryCode").val() == "") {
		//		 error ++;
		//            if(val_msg.length > 0){
		//            	   val_msg += "<br/>";
		//               }
	    //            val_msg += "countryCode";
		//	 }
			// end of max validation of redmine 3705   as of 03/22/2016
			
			  // start of max validation of redmine 4086  ERF-20160218-092 as of 03/15/2016
			var regexp1 = /^[a-zA-Z]{1}/;
			 if (error > 0){
					val_msg = 'Missing Required Fields:<br/>' + val_msg;
            }else if((!regexp1.test($("#buyerName").val())) && ($("#buyerName").val() != "" || $("#buyerName").val() != null)){	
		            error ++;
	            	val_msg = 'Name should start with a letter';
	  	    }
			 // end of max validation of redmine 4086
		} else {
			$(tabId + " :input").each(function(){
		        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
		           if ($(this).val() == "") {
		               error ++;
	                   console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
		           }
		        }
		    });
		    //validation check for cifNumber
			if ($("#cifNumber").attr("class") != undefined && $("#cifNumber").attr("class") != null && $("#cifNumber").attr("class").indexOf("required") != -1) {
		        if ($("#cifNumber").val() == "") {
		            error ++;
		        }
		    }
		}
	    return error;
	}
</script>

<g:render template="../layouts/confirm_alert" />
<g:render template="../layouts/alert" />

<g:render template="../product/commons/popups/mode_of_payment" />


<g:render template="../commons/popups/ec_login" />
<g:render template="../commons/popups/reverse_button_confirmation" />
<g:render template="../commons/popups/cif_search_popup" />
<g:render
	template="../others/commons/popups/other_import_charges_payment_popup" />
<g:render
	template="../others/commons/popups/partial_amount_refund_popup" />

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_non_lc_popup" />

<g:render template="../product/commons/popups/create_export_bills_transaction" />

<g:render template="/commons/popups/loan_details_popup"/>
<g:render template="/commons/popups/facility_id_popup"/>

<g:render template="/layouts/loading" />

<g:javascript src="new/override_authorization_utils.js" />
<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'payAuthorizeDiv',
                  overrideAuthDivBg: 'payAuthorizeBg',
                  overrideAuthUsernameId: 'payAuthorizeUsername',
                  overrideAuthPasswordId: 'payAuthorizePassword',
                  overrideAuthConfirmId: 'payAuthorizeConfirm',
                  overrideAuthCancelId: 'payAuthorizeCancel',
                  overrideAuthCasaPaymentId: 'payAuthorizeCasaId'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeDiv',
                  overrideAuthDivBg: 'unpayAuthorizeBg',
                  overrideAuthUsernameId: 'unpayAuthorizeUsername',
                  overrideAuthPasswordId: 'unpayAuthorizePassword',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirm',
                  overrideAuthCancelId: 'unpayAuthorizeCancel',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaId'
          ]"/>