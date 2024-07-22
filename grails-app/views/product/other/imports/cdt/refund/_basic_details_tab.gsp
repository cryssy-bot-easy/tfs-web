<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _basic_details_tab.gsp


>--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="cifNumber" value="${cifNumber}" />
<g:hiddenField name="form" value="basicDetails"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly" value="${processingUnitCode ?: "909"}"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">IED/IEIRD No.<span class="asterisk">*</span></span></td>
		<td><g:textField name="iedieirdNumber" class="input_field required" readonly="readonly" value="${iedieirdNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">AAB-Ref No.</span></td>
		<td><g:textField name="agentBankCode" class="input_field" readonly="readonly" value="${agentBankCode}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">CDT Reference No.</span></td>
		<td><g:textField name="transactionReferenceNumber" class="input_field" readonly="readonly" value="${transactionReferenceNumber ?: paymentReferenceNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document No.</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">Importer's Name</span></td>
		<td><g:textField name="clientName" class="input_field" readonly="readonly" value="${clientName}" maxlength="60"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">Currency</span></td>
		<td><g:textField name="currency" class="input_field" readonly="readonly" value="PHP"/></td>
	</tr>
	<tr>
		<td><span class="field_label">CDT Amount</span></td>
		<td><g:textField name="cdtAmount" class="input_field_right numericCurrency" readonly="readonly" value="${cdtAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">IPF</span></td>
		<td><g:textField name="ipf" class="input_field_right numericCurrency" readonly="readonly" value="${ipf}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Total Amount to be Refunded</span></td>
		<td><g:textField name="totalAmountOfPayment" class="input_field_right numericCurrency" readonly="readonly" value="${totalAmountOfPayment}"/></td>
	</tr>
	<g:if test="${!session['userrole']['id']?.contains('BR') && tradeServiceId != null}">
		<tr>
			<td><span class="field_label">MOB-BOC Account Number<span class="asterisk">*</span></span></td>
			<td>
                <g:textField name="bocAccountNumber" class="input_field required" value="${bocAccountNumber}"/>
            </td>
            <td><input type="button" class="check_button" id="bocAccountNameCheckCdtRefund" style="float: left"/></td>		
		</tr>
		<tr>
            <td><span class="field_label">MOB-BOC Account Name</span></td>
            <td>
                <g:hiddenField name="debitTransactionStatus" value="${debitTransactionStatus}" />
                <g:textField name="bocAccountName" class="input_field" readonly="readonly" value="${bocAccountName}"/>
            </td>
            <td>
                <input type="button" id="debitCasa" name="debitCasa" class="input_button2 debitButton" value="Debit CASA" disabled="disabled"/>
                <input type="button" id="errorCorrectDebit" name="debitCasa" class="input_button_negative2 errorCorrectDebit" value="EC" />
            </td>
        </tr>
	</g:if>
	<g:if test="${tradeServiceId != null}">
		<tr>
        	<td><span class="field_label">Special Instructions <span class="asterisk">* </span><br /> (Narrative)</span></td>
            <td><g:textArea name="specialInstructions" class="textarea required" rows="4" value="${specialInstructions ? specialInstructions : 'Rejected with BOC confirmation'}" /></td>
        </tr>
        <tr class="modeOfRefundClass">
            <td><span class="field_label">Mode of Refund<span class="asterisk">*</span></span></td>
            <td>
                <g:select id="modeOfRefund" name="modeOfRefund" value="${modeOfRefund}" class="select_dropdown required" from="${['CASA', 'MC Issuance', 'IBT - Branch']}" keys="${["CASA", "MC_ISSUANCE", "IBT_BRANCH"]}" noSelection="['':'SELECT ONE...']" />
            </td>
        </tr>
     </g:if>
</table>

    <table class="display-block-mode-of-refund">
        <tr>
            <td class="label_width"><span class="field_label">&#160;&#160;&#160;&#160;&#160;Account Number</span></td>
            <td>
                <g:textField name="cdtRefundAccountNumber" class="input_field" value="${cdtRefundAccountNumber}" />
            </td>
            <td><input type="button" class="check_button" id="accountNameCheckCdtRefund" style="float: left"/></td>
        </tr>
        <tr>
            <td><span class="field_label">&#160;&#160;&#160;&#160;&#160;Account Name</span></td>
            <td>
                <g:hiddenField name="creditTransactionStatus" value="${creditTransactionStatus}" />
                <g:textField name="accountNameCdtRefund" class="input_field" readonly="readonly" value="${accountNameCdtRefund}"/>
            </td>
            <td>

                <input type="button" class="input_button2" value="Credit CASA" id="creditCasa" disabled="disabled"/>
                <input type="button" class="input_button_negative2" value="EC" id="errorCorrectCredit" />
            </td>
        </tr>
    </table>

<br /><br />
<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'payAuthorizeDivCredit',
                  overrideAuthDivBg: 'payAuthorizeBgCredit',
                  overrideAuthUsernameId: 'payAuthorizeUsernameCredit',
                  overrideAuthPasswordId: 'payAuthorizePasswordCredit',
                  overrideAuthConfirmId: 'payAuthorizeConfirmCredit',
                  overrideAuthCancelId: 'payAuthorizeCancelCredit',
                  overrideAuthCasaPaymentId: 'payAuthorizeCasaIdCredit'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeDivDebit',
                  overrideAuthDivBg: 'unpayAuthorizeBgDebit',
                  overrideAuthUsernameId: 'unpayAuthorizeUsernameDebit',
                  overrideAuthPasswordId: 'unpayAuthorizePasswordDebit',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirmDebit',
                  overrideAuthCancelId: 'unpayAuthorizeCancelDebit',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaIdDebit'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeDivCredit',
                  overrideAuthDivBg: 'unpayAuthorizeBgCredit',
                  overrideAuthUsernameId: 'unpayAuthorizeUsernameCredit',
                  overrideAuthPasswordId: 'unpayAuthorizePasswordCredit',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirmCredit',
                  overrideAuthCancelId: 'unpayAuthorizeCancelCredit',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaIdCredit'
          ]"/>
          
<g:render template="/commons/popups/override_authorization_for_mc_issuance"
          model="[overrideAuthDivId: 'payAuthorizeDivMCIssuance',
                  overrideAuthDivBg: 'payAuthorizeBgMCIssuance',
                  overrideAuthUsernameId: 'payAuthorizeUsernameMCIssuance',
                  overrideAuthPasswordId: 'payAuthorizePasswordMCIssuance',
                  overrideAuthConfirmId: 'payAuthorizeConfirmMCIssuance',
                  overrideAuthCancelId: 'payAuthorizeCancelMCIssuance'
          ]"/>

<script type="text/javascript">
    function changeModeOfRefund() {
        if ($("#creditTransactionStatus").val() == "PAID") {
            triggerAlertMessage("Mode of refund must be error corrected first.")
            $("#modeOfRefund").val("CASA");
        } else {
            if ($("#modeOfRefund").val() != "" && $("#modeOfRefund").val() == "CASA") {
                $(".display-block-mode-of-refund").show();
                $("#cdtRefundAccountNumber, #accountNameCdtRefund, #creditTransactionStatus").val("");
            } else {
                $(".display-block-mode-of-refund").hide();
                $("#cdtRefundAccountNumber, #accountNameCdtRefund, #creditTransactionStatus").val("");
            }
            $("#btnPrepare").attr("disabled", "disabled");
        }
    }

    function triggerPaid(type) {
        if ("DEBIT" == type) {
            $("#debitTransactionStatus").val("PAID");
            $("#debitCasa").hide();
            $("#errorCorrectDebit").show();
        }

        if ("CREDIT" == type) {
            $("#creditTransactionStatus").val("PAID");
            $("#creditCasa").hide();
            $("#errorCorrectCredit").show();
        }
    }

    function triggerUnpaid(type) {
        if ("DEBIT" == type) {
            $("#debitTransactionStatus").val("ERROR_CORRECTED");
            $("#debitCasa").show();
            $("#errorCorrectDebit").hide();
            $(".viewDebitMemo").removeAttr('id');
    		$(".viewDebitMemo").addClass("disableDebitMemo");
    		$("#btnPrepare").attr("disabled", "disabled");
            $("#bocAccountNumber").removeAttr("readonly");
            $("#bocAccountNameCheckCdtRefund").removeAttr("disabled");
        }

        if ("CREDIT" == type) {
            $("#creditTransactionStatus").val("ERROR_CORRECTED");
            $("#creditCasa").show();
            $("#errorCorrectCredit").hide();
            $(".viewCreditMemo").removeAttr("id");
    		$(".viewCreditMemo").addClass("disableCreditMemo");
    		$("#btnPrepare").attr("disabled", "disabled");
        }
    }

    function unpayCasa(type, supervisorId) {
        var params = {
            type: type,
            tradeServiceId: $("#tradeServiceId").val(),
            amount: $("#totalAmountOfPayment").val(),
            currency: $("#currency").val(),
            supervisorId: supervisorId
        }

        if (type == "CREDIT") {
            params["accountName"] = $("#accountNameCdtRefund").val();
            params["accountNumber"] = $("#cdtRefundAccountNumber").val();
        }else{
        	params["accountName"] = $("#bocAccountName").val();
            params["accountNumber"] = $("#bocAccountNumber").val();
		}

        $.post('${g.createLink(controller: "cdt", action: "errorCorrectCasa")}',
            params,
            function(data) {
                if (data.status == "ok") {
                    triggerUnpaid(type);
                } else {
                    triggerPaid(type);
                    triggerAlertMessage(data.error)
                }
                mDisablePopup($("#loading_div"),$("#loading_bg"));
            }
        );
    }

    function creditCasa() {
        var params = {
            accountNumber: $("#cdtRefundAccountNumber").val(),
            amount: $("#totalAmountOfPayment").val(),
            type: "CREDIT",
            tradeServiceId: $("#tradeServiceId").val(),
            currency: $("#currency").val(),
            accountName: $("#accountNameCdtRefund").val(),
            supervisorId: $("#payAuthorizeUsernameCredit").val()
        }

        $.post('${g.createLink(controller: "cdt", action: "transactRefund")}',
            params,
            function(data) {
                if (data.status == "ok") {
                    $("#creditTransactionStatus").val("PAID");
                    $("#creditCasa").hide();
                    $("#errorCorrectCredit").show();
        			$(".viewCreditMemo").attr("id", "viewCreditMemo");
        			$(".viewCreditMemo").removeClass("disableCreditMemo");
                } else {
                    $("#creditTransactionStatus").val("ERROR_CORRECTED");
                    $("#creditCasa").show();
                    $("#errorCorrectCredit").hide();
            		$(".viewCreditMemo").removeAttr("id");
            		$(".viewCreditMemo").addClass("disableCreditMemo");         		
                    triggerAlertMessage(data.error)
                }
        		mDisablePopup($("#loading_div"),$("#loading_bg"));
            }
        );
    }
    
	var val_msg = ""
	function validateCdtRefundTab(tabId) {
		var error = 0;
		if(tabId == "#basicDetailsTabForm" && ${tradeServiceId != null}){
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
			val_msg ="Missing Required Fields:<br/>" + val_msg;
		}
	    return error;
	}

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
	    
    $(document).ready(function() {
        $("#modeOfRefund").change(changeModeOfRefund);
        
        $("#cdtRefundAccountNumber, #bocAccountNumber").on("keydown", function(e) {
            return e.which !== 32;
        });
                
        $("#cdtRefundAccountNumber").change(function() {
            $("#accountNameCdtRefund").val("");
        });

        $("#bocAccountNumber").change(function() {
            $("#bocAccountName").val("");
        });

        if (${tradeServiceId != null}) {
            $("#debitCasa, #creditCasa").removeAttr("disabled");
        }

        if ($("#modeOfRefund").val() != "" && $("#modeOfRefund").val() == "CASA") {
            $(".display-block-mode-of-refund").show();
        } else {
            $("#cdtRefundAccountNumber, #accountNameCdtRefund, #creditTransactionStatus").val("");
            $(".display-block-mode-of-refund").hide();
        }

        if($("#userRole").val().indexOf("Branch") != -1) {
        	$("#modeOfRefund>option[value=IBT_BRANCH]").hide();
		} else {
			$("#modeOfRefund>option[value=IBT_BRANCH]").show();
		}

        if ($("#debitTransactionStatus").val() == "PAID") {
            $("#debitCasa").hide();
            $("#errorCorrectDebit").show();
            $(".viewDebitMemo").attr('id', 'viewDebitMemoPayment');
    		$(".viewDebitMemo").removeClass("disableDebitMemo");    		
    		$("#bocAccountNumber").attr("readonly", "readonly");
    		$("#bocAccountNameCheckCdtRefund").attr("disabled", "disabled");
        } else {
            $("#debitCasa").show();
            $("#errorCorrectDebit").hide();
            $("#btnPrepare").attr("disabled", "disabled");
            $("#bocAccountNumber").removeAttr("readonly");
            $("#bocAccountNameCheckCdtRefund").removeAttr("disabled");
        }

        if ($("#creditTransactionStatus").val() == "PAID") {
            $("#creditCasa").hide();
            $("#errorCorrectCredit").show();
			$(".viewCreditMemo").attr("id", "viewCreditMemo");
			$(".viewCreditMemo").removeClass("disableCreditMemo");
        } else {
            $("#creditCasa").show();
            $("#errorCorrectCredit").hide();
            if ($("#modeOfRefund").val() != "" && $("#modeOfRefund").val() == "CASA") {
            	$("#btnPrepare").attr("disabled", "disabled");
            }
        }

		$("#debitCasa").click(function() {
            if ($("#bocAccountNumber").val()) {
                var params = {
                    accountNumber: $("#bocAccountNumber").val(),
                    amount: $("#totalAmountOfPayment").val(),
                    type: "DEBIT",
                    tradeServiceId: $("#tradeServiceId").val(),
                    currency: $("#currency").val()
                }

                $.post('${g.createLink(controller: "cdt", action: "transactRefund")}',
                        params,
                        function(data) {
                            if (data.status == "ok") {
                                $("#debitTransactionStatus").val("PAID");
                                $("#debitCasa").hide();
                                $("#errorCorrectDebit").show();
                        		$(".viewDebitMemo").attr('id', 'viewDebitMemoPayment');
                        		$(".viewDebitMemo").removeClass("disableDebitMemo");
                        		$("#bocAccountNumber").attr("readonly", "readonly");
    							$("#bocAccountNameCheckCdtRefund").attr("disabled", "disabled");
                            } else {
                                $("#debitTransactionStatus").val("ERROR_CORRECTED");
                                $("#debitCasa").show();
                                $("#errorCorrectDebit").hide();
                        		$(".viewDebitMemo").removeAttr('id');
                        		$(".viewDebitMemo").addClass("disableDebitMemo");
                        		$("#bocAccountNumber").removeAttr("readonly");
            					$("#bocAccountNameCheckCdtRefund").removeAttr("disabled");                       		
                        		triggerAlertMessage(data.error)
                            }
                        }
                );
            } else {
                triggerAlertMessage("MOB-BOC Account Number must not be blank.");
            }
        });
        
        $("#errorCorrectDebit").click(function() {
            $("#unpayAuthorizeUsernameDebit, #unpayAuthorizePasswordDebit").val("");
            loadPopup("unpayAuthorizeDivDebit", "unpayAuthorizeBgDebit");
            centerPopup("unpayAuthorizeDivDebit", "unpayAuthorizeBgDebit");
        });
        
        $("#unpayAuthorizeCancelDebit").click(function() {
            disablePopup("unpayAuthorizeDivDebit", "unpayAuthorizeBgDebit");
        });

        $("#unpayAuthorizeConfirmDebit").click(function() {
            disablePopup("unpayAuthorizeDivDebit", "unpayAuthorizeBgDebit");

            var params = {
                username: $("#unpayAuthorizeUsernameDebit").val(),
                password: $("#unpayAuthorizePasswordDebit").val()
            }

            $.post('${g.createLink(controller: "payment", action: "loginOfficer")}',
                    params,
                    function (unpayAuthenticationResponse) {
                if (unpayAuthenticationResponse.success == true) {
                    unpayCasa("DEBIT", $("#unpayAuthorizeUsernameDebit").val());
                    disablePopup("unpayAuthorizeDivDebit", "unpayAuthorizeBgDebit");
                } else {
                    triggerAlertMessage("Invalid username/password.");
                }
            });
        });
        
        $("#bocAccountNameCheckCdtRefund").click(function () {
              var settlementCurrency = $("#currency").val();
              var accountNumber = $("#bocAccountNumber").val();
              
			  mCenterPopup($("#loading_div"), $("#loading_bg"));
			  mLoadPopup($("#loading_div"), $("#loading_bg"));
			  
              $.post(casaUserSearchUrl, {accountNumber: accountNumber, currency: settlementCurrency}, function (data) {
                  if (data["status"] != "error") {
                      if (data['currency'] != settlementCurrency) {
                          triggerAlertMessage('Currency of account did not match Settlement Currency.');
                          $("#bocAccountNumber, #bocAccountName").val("");
                      } else {
                          $("#bocAccountName").val(data['accountName']);
                          accountNumber = $("#bocAccountNumber").val();                         
                      }
                  } else {
                      triggerAlertMessage(data["error"]);
                      $("#bocAccountNumber").val("");
                  }
                  mDisablePopup($("#loading_div"),$("#loading_bg"));
              });
      	});

        $("#creditCasa").click(function() {
            if ($("#accountNameCdtRefund").val()) {
                $.post('${g.createLink(controller: "payment", action: "validateCasaTransactionAmount")}',
                        {currency: $("#currency").val(), amount: $("#totalAmountOfPayment").val()},
                        function(validateCasaAmountResponse) {
                            if (validateCasaAmountResponse.success == true) {
                                creditCasa();
                            } else {
                                if (validateCasaAmountResponse.requiresValidation == true) {
                                    $("#payAuthorizeUsernameCredit, #payAuthorizePasswordCredit").val("");

                                    loadPopup("payAuthorizeDivCredit", "payAuthorizeBgCredit");
                                    centerPopup("payAuthorizeDivCredit", "payAuthorizeBgCredit");

                                    $("#payAuthorizeCasaIdCredit").val(id);
                                } else {
                                    triggerAlertMessage(validateCasaAmountResponse.errorMessage);
                                }
                            }
                        }
                );
            } else {
                triggerAlertMessage("Account Name must not be blank.");
            }
        });

        $("#errorCorrectCredit").click(function() {
            $("#unpayAuthorizeUsernameCredit, #unpayAuthorizePasswordCredit").val("");
            loadPopup("unpayAuthorizeDivCredit", "unpayAuthorizeBgCredit");
            centerPopup("unpayAuthorizeDivCredit", "unpayAuthorizeBgCredit");
        });

		$("#payAuthorizeConfirmCredit").click(function() {
            disablePopup("payAuthorizeDivCredit", "payAuthorizeBgCredit");
			mCenterPopup($("#loading_div"), $("#loading_bg"));
			mLoadPopup($("#loading_div"), $("#loading_bg"));
			
            var params = {
                username: $("#payAuthorizeUsernameCredit").val(),
                password: $("#payAuthorizePasswordCredit").val()
            }

            $.post('${g.createLink(controller: "payment", action: "loginOfficer")}',
                    params,
                    function (payAuthenticationResponse) {
                        if (payAuthenticationResponse.success == true) {
                            creditCasa();
                            disablePopup("payAuthorizeDivCredit", "payAuthorizeBgCredit");
                        } else {
                        	mDisablePopup($("#loading_div"),$("#loading_bg"));
                            triggerAlertMessage("Invalid username/password.");
                        }
                    });
        });

        $("#payAuthorizeCancelCredit").click(function() {
            disablePopup("payAuthorizeDivCredit", "payAuthorizeBgCredit");
        });
        
        $("#unpayAuthorizeConfirmCredit").click(function() {
            disablePopup("unpayAuthorizeDivCredit", "unpayAuthorizeBgCredit");
			mCenterPopup($("#loading_div"), $("#loading_bg"));
			mLoadPopup($("#loading_div"), $("#loading_bg"));
			
            var params = {
                username: $("#unpayAuthorizeUsernameCredit").val(),
                password: $("#unpayAuthorizePasswordCredit").val()
            }

            $.post('${g.createLink(controller: "payment", action: "loginOfficer")}',
                    params,
                    function (unpayAuthenticationResponse) {
                        if (unpayAuthenticationResponse.success == true) {
                            unpayCasa("CREDIT", $("#unpayAuthorizeUsernameCredit").val());
                            disablePopup("unpayAuthorizeDivCredit", "unpayAuthorizeBgCredit");
                        } else {
                        	mDisablePopup($("#loading_div"),$("#loading_bg"));
                            triggerAlertMessage("Invalid username/password.");
                        }
                    });
        });
        
        $("#unpayAuthorizeCancelCredit").click(function() {
            disablePopup("unpayAuthorizeDivCredit", "unpayAuthorizeBgCredit");
        });

        $("#accountNameCheckCdtRefund").click(function () {
              var settlementCurrency = $("#currency").val();
              var accountNumber = $("#cdtRefundAccountNumber").val();
              
			  mCenterPopup($("#loading_div"), $("#loading_bg"));
			  mLoadPopup($("#loading_div"), $("#loading_bg"));
			  
              $.post(casaUserSearchUrl, {accountNumber: accountNumber, currency: settlementCurrency}, function (data) {
                  if (data["status"] != "error") {
                      if (data['currency'] != settlementCurrency) {
                          triggerAlertMessage('Currency of account did not match Settlement Currency.');
                          $("#accountNumber").val("");
                      } else {
                          $("#accountNameCdtRefund").val(data['accountName']);
                          accountNumber = $("#accountNumber").val();                         
                      }
                  } else {
                      triggerAlertMessage(data["error"]);
                      $("#accountNumber").val("");
                  }
                  mDisablePopup($("#loading_div"),$("#loading_bg"));
              });
      	});
        
		$("#payAuthorizeCancelMCIssuance").click(function() {
            disablePopup("payAuthorizeDivMCIssuance", "payAuthorizeBgMCIssuance");
        });
        
        $("#payAuthorizeConfirmMCIssuance").click(function() {
            disablePopup("payAuthorizeDivMCIssuance", "payAuthorizeBgMCIssuance");

            var params = {
                username: $("#payAuthorizeUsernameMCIssuance").val(),
                password: $("#payAuthorizePasswordMCIssuance").val()
            }

            $.post('${g.createLink(controller: "payment", action: "loginOfficer")}',
                    params,
                    function (payAuthenticationResponse) {
                        if (payAuthenticationResponse.success == true) {
                            disablePopup("payAuthorizeDivMCIssuance", "payAuthorizeBgMCIssuance");
                        	mCenterPopup($("#loading_div"), $("#loading_bg"));
			   				mLoadPopup($("#loading_div"), $("#loading_bg"));
		       				$(".saveAction").show();
		       				$(".cancelAction").hide();
                            $("#basicDetailsTabForm").submit();
                        } else {
                            triggerAlertMessage("Invalid username/password.");
                        }
                    });
        });

        $("#saveConfirmBasicDetails").click(function() {
         	if(validateCdtRefundTab("#basicDetailsTabForm") > 0){
            	triggerAlertMessage(val_msg);
            } else if(($("#cdtRefundAccountNumber").val() == "" || $("#cdtRefundAccountNumber").val() == null)
            			&& $("#modeOfRefund").val() == "CASA"){
            	triggerAlertMessage("CASA Account Number must not be blank.");
            }else {
		       	if($("#userRole").val().indexOf("Branch") != -1 && $("#modeOfRefund").val() == "MC_ISSUANCE") {
		        	$("#payAuthorizeUsernameMCIssuance, #payAuthorizePasswordMCIssuance").val("");
		
		            loadPopup("payAuthorizeDivMCIssuance", "payAuthorizeBgMCIssuance");
		            centerPopup("payAuthorizeDivMCIssuance", "payAuthorizeBgMCIssuance");
		        } else {
		           	mCenterPopup($("#loading_div"), $("#loading_bg"));
			   		mLoadPopup($("#loading_div"), $("#loading_bg"));
		       		$(".saveAction").show();
		       		$(".cancelAction").hide();
		       		$("#btnPrepare").removeAttr("disabled");
		           	$("#basicDetailsTabForm").submit();
		        }
            }
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>