<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _paymenthistory.gsp


>--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<script language="javascript">

    %{--var searchCdtPaymentUrl = ' ${params.upload?.equalsIgnoreCase("ok") ? g.createLink(controller: "inquiry", action: "cdtTransactionsInquiry") : ""}';--}%
    %{--var searchCdtPaymentUrl = '${g.createLink(controller: "inquiry", action: "cdtTransactionsInquiry")}';--}%
    var searchCdtPaymentUrl = '${g.createLink(controller: "inquiry", action: "cdtTransactionsHistoryInquiry")}';
    var viewCdtPaymentUrl = '${g.createLink(controller: "product", action: "viewCdtPayment")}';
    
    </script>
%{--<g:javascript src="grids/upload_transactions_grid.js"/>--}%
<g:javascript src="new/cdt/cdt-payment-history-inquiry.js"/>
<g:javascript src="new/cdt/cdt-payment-inquiry.js"/>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="supervisorId" value="${session.username}" />

    <g:form method="POST" controller="cdt" action="uploadDocument" enctype="multipart/form-data" >
    <g:hiddenField name="fileType" value="history"/>
    <g:hiddenField id = "confDate" name="confDate"/>
    
        %{--<div id="body_forms">--}%
            <table class="upload_header">
                <tr>
                    <td><span class="field_label">File Location:</span></td>
                    <td><input type="file" name="fileLocation" class="input_field_file"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><g:submitButton class="input_button" name="uploadCdt" value="Upload" /></td>
                </tr>
            </table>
            <br/>

        %{--</div>--}%
    </g:form>

    %{--<div class="grid_wrapper">--}%
        %{--<table id="paymenthistory">--}%
            %{--<thead>--}%
                %{--<th>IED/EIRD No.</th>--}%
                %{--<th>AAB Ref No.</th>--}%
                %{--<th>CDT Amount</th>--}%
                %{--<th>Collection Date</th>--}%
                %{--<th>Importers Name</th>--}%
                %{--<th>Request Type</th>--}%
                %{--<th>e2mStatus</th>--}%
                %{--<th>TFS Status</th>--}%
                %{--<th>Collection Data Entry</th>--}%
            %{--</thead>--}%
            %{--<tbody>--}%
                %{--<g:each in="${transactions}" var="transaction">--}%
                    %{--<tr>--}%
                        %{--<td>${transaction.iedieirdNumber}</td>--}%
                        %{--<td>${transaction.agentBankCode}</td>--}%
                        %{--<td>${transaction.amount}</td>--}%
                        %{--<td>${transaction.pchcDateReceived}</td>--}%
                        %{--<td>${transaction.clientName}</td>--}%
                        %{--<td>${transaction.paymentRequestType}</td>--}%
                        %{--<td>${transaction.e2mStatus}</td>--}%
                        %{--<td>${transaction.status}</td>--}%
                        %{--<td></td>--}%
                        %{--<td><a href="<g:createLink controller="cdt" action="viewCdtPayment" params="${[iedieirdNumber:transaction.iedieirdNumber,--}%
                        %{--username: session.username, userrole: session.userrole.id]}"/>">view</a></td>--}%
                    %{--</tr>--}%
                %{--</g:each>--}%
            %{--</tbody>--}%
        %{--</table>--}%
        %{--<div id="pager"></div>--}%
    %{--</div>--}%

<div class="grid_wrapper"> <%-- JQGRID --%>
    <table id="cdt_list_upload_transactions"> </table>
    <div id="cdt_pager_upload_transactions"> </div>
</div>

    <form>
        <div class="upload_footer">
            <table class="upload_tbl" cellspacing="5">
            
              	<tr>
              	
              	
              		<td><span class="field_label">Confirmation Date</span></td>
					<td><g:textField class="input_field" name="sentBOCDate" value="${DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
	
                </tr>
                 <tr>
             
                    <td><p class="upload_text">Total Amount Paid</p></td><td><input type="text" id="totalAmountPaid" name="totalAmountPaid" value="${formatNumber(number:totalPaid,format:'###,##0.00')}" class="input_field_right" readonly="readonly"/></td>
                    <td></td>
                </tr>
                <tr>
             
                    <td><p class="upload_text">Total TFS(Match with E2M)</p></td><td><input type="text" id="totalAmountCollectedTFS" name="totalAmountCollectedTFS" value="${formatNumber(number:cdtTotal,format:'###,##0.00')}" class="input_field_right" readonly="readonly"/></td>
                    <td><p class="upload_text upload_second_row">Last Account Number</p></td><td><input type="text" id="lastAccountNumberUploadHistory" name="lastAccountNumberUploadHistory" value="" class="input_field_right" readonly="readonly"/></td>
                </tr>
                <tr>
                    <td><p class="upload_text">Total E2M</p></td><td><input type="text" id="totalAmountCollectedsE2M" name="totalAmountCollectedsE2M" value="${formatNumber(number:e2mTotal,format:'###,##0.00')}" class="input_field_right" readonly="readonly"/></td>
                    <td><p class="upload_text upload_second_row">Last Account Name</p></td><td><input type="text" id="lastAccountNameUploadHistory" name="lastAccountNameUploadHistory" value="" class="input_field_right" readonly="readonly"/></td>
                </tr>
                <tr>
                    <td><p class="upload_text">Transaction Type</p></td>
                    <td>
                        <g:select from="${['Send to BOC', 'Error Correct']}" keys="${['SEND_TO_MOB_BOC', 'ERROR_CORRECT']}" class="select_dropdown" name="transactionType" noSelection="${['': 'SELECT ONE...']}"/>
                    </td>
                    <td><p class="upload_text upload_second_row">Last Total Amount Collected (TFS)</p></td><td><input type="text" id="lastAmountUploadHistory" name="lastAmountUploadHistory" value="" class="input_field_right" readonly="readonly"/></td>
                </tr>
                <tr class="mobBoc">
                    <td><p class="upload_text">Account Number</p></td>
                    <td>
                        <g:textField name="mobBocAccountNumberSend" value="" class="input_field"/>
                    </td>
                    <td>
                        <span style="float: left"><input type="button" class="check_button" id="accountNameCheckSend" /></span>
                    </td>
                </tr>
                <tr class="mobBoc">
                    <td><p class="upload_text">Account Name</p></td>
                    <td>
                        <g:textField name="accountNameSend" value="" readonly="readonly" class="input_field"/>
                    </td>
                    <td>
                        <input type="button" id="sendToMobBoc" class="input_button" style="float:none;" value="Submit" />
                    </td>
                </tr>
                <tr class="errorCorrect">
                    <td><p class="upload_text">Account Number</p></td>
                    <td>
                        <g:textField name="mobBocAccountNumberEC" value="" class="input_field"/>
                    </td>
                    <td>
                        <span style="float: left"><input type="button" class="check_button" id="accountNameCheckEC" /></span>
                    </td>
                </tr>
                <tr class="errorCorrect">
                    <td><p class="upload_text">Account Name</p></td>
                    <td>
                        <g:textField name="accountNameEC" value="" readonly="readonly" class="input_field"/>
                    </td>
                    <td>
                        <input type="button" id="errorCorrect" class="input_button_negative" style="float:none;" value="Submit" />
                    </td>
                </tr>
            </table>
        </div>
        %{--<div class="upload_send">--}%
            %{--<ul style="list-style: none; float: left;">--}%
                %{--<li>--}%
                    %{--<g:textField name="mobBocAccountNumber" value="" class="input_field"/>--}%
                %{--</li>--}%
                %{--<li>--}%
                    %{--<input type="button" id="sendToMobBoc" class="input_button3" value="Send to MOB-BOC" />--}%
                %{--</li>--}%
            %{--</ul>--}%
        %{--</div>--}%
    </form>

%{--<script type="text/javascript">--}%
            %{--$(document).ready(function() {--}%
                %{--tableToGrid('#paymenthistory', {width : 780, height: 400, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]});--}%
                %{--jQuery("#paymenthistory").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");--}%

                %{--$("#btnUploadPayment").hide();--}%

                %{--if($("#totalAmountCollectedTFS").val() == $("#totalAmountCollectedsE2M").val()) {--}%
                    %{--$("#btnUploadPayment").show();--}%
                %{--}--}%
            %{--});--}%
%{--</script>--}%

<g:javascript src="new/cdt_override_authorization_utils.js" />
<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'payAuthorizeCdtDiv',
                  overrideAuthDivBg: 'payAuthorizeCdtBg',
                  overrideAuthUsernameId: 'payAuthorizeUsernameCdt',
                  overrideAuthPasswordId: 'payAuthorizePasswordCdt',
                  overrideAuthConfirmId: 'payAuthorizeConfirmCdt',
                  overrideAuthCancelId: 'payAuthorizeCancelCdt',
                  overrideAuthCasaPaymentId: 'payAuthorizeCasaIdCdt'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeCdtDiv',
                  overrideAuthDivBg: 'unpayAuthorizeCdtBg',
                  overrideAuthUsernameId: 'unpayAuthorizeUsernameCdt',
                  overrideAuthPasswordId: 'unpayAuthorizePasswordCdt',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirmCdt',
                  overrideAuthCancelId: 'unpayAuthorizeCancelCdt',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaIdCdt'
          ]"/>

<g:render template="/layouts/loading_cdt_upload"/>

<script type="text/javascript">
function hideTransactionTypes() {
    $(".mobBoc").hide();
    $(".errorCorrect").hide();
    $("#transactionType").val("");
}

function validateAccountNumber(accountNumber, transactionType) {
    $.post("${g.createLink(controller: 'modeOfPayment', action: 'searchCasaAccountsByUser')}",
            {accountNumber: accountNumber, currency: "PHP"},
            function (data) {
        if (data["status"] != "error") {
            if (data['currency'] != "PHP") {
                triggerAlertMessage('Currency of account did not match Settlement Currency.');

                if (transactionType == "SEND_TO_MOB_BOC") {
                    $("#mobBocAccountNumberSend").val("");
                } else if (transactionType == "ERROR_CORRECT") {
                    $("#mobBocAccountNumberEC").val("");
                }
            } else {
                if (transactionType == "SEND_TO_MOB_BOC") {
                    $("#accountNameSend").val(data['accountName']);
                } else if (transactionType == "ERROR_CORRECT") {
                    $("#accountNameEC").val(data['accountName']);
                }
            }
        } else {
            triggerAlertMessage(data["error"]);
            $("#accountNumber").val("");
        }
    });
}

var sendToMobBocUrl = '${g.createLink(controller: "cdt", action: "sendToMobBoc")}';
var ecMobBocUrl = '${g.createLink(controller: "cdt", action: "errorCorrectMobBoc")}';

$(document).ready(function() {
    $("#mobBocAccountNumberSend, #mobBocAccountNumberEC").on("keydown", function(e) {
        return e.which !== 32;
    });

    hideTransactionTypes();

    $("#transactionType").change(function() {
        $("#mobBocAccountNumberSend, #accountNameSend, #mobBocAccountNumberEC, #accountNameEC").val("");

        if ($("#transactionType").val() == "SEND_TO_MOB_BOC") {
            $(".mobBoc").show();
            $(".errorCorrect").hide();
			$(".viewCreditMemo").attr("id", "viewCreditMemo");
			$(".viewCreditMemo").removeClass("disableCreditMemo");
        } else if ($("#transactionType").val() == "ERROR_CORRECT") {
            $(".errorCorrect").show();
            $(".mobBoc").hide();
    		$(".viewCreditMemo").removeAttr("id");
    		$(".viewCreditMemo").addClass("disableCreditMemo");
        } else {
            hideTransactionTypes();
    		$(".viewCreditMemo").removeAttr("id");
    		$(".viewCreditMemo").addClass("disableCreditMemo");
        }
    });

    $("#accountNameCheckSend").click(function() {
        var accountNumber = $("#mobBocAccountNumberSend").val();

        validateAccountNumber(accountNumber, $("#transactionType").val());
    });

    $("#accountNameCheckEC").click(function() {
        var accountNumber = $("#mobBocAccountNumberEC").val();

        validateAccountNumber(accountNumber, $("#transactionType").val());
    });

    $("#sendToMobBoc").click(function() {

    
        if ($("#accountNameSend").val()) {
            var params = {
                amount: $("#totalAmountCollectedTFS").val(),
                currency: "PHP",
                amountSettlement: $("#totalAmountCollectedTFS").val()
            }
            
            //set last history
            $("#lastAccountNumberUploadHistory").val($("#mobBocAccountNumberSend").val());
            $("#lastAccountNameUploadHistory").val($("#accountNameSend").val());
            $("#lastAmountUploadHistory").val($("#totalAmountCollectedTFS").val());
            
            $.post(validateCasaTransactionAmountUrl, params, function (validateCasaAmountResponse) {
                hideTransactionTypes();
                if (validateCasaAmountResponse.success == true) {
                    onPayClickAuthenticateCdt($("#supervisorId").val());
      
                } else {
                    if (validateCasaAmountResponse.requiresValidation == true) {

                        $("#payAuthorizeUsernameCdt, #payAuthorizePasswordCdt").val("");

                        mLoadPopup($("#payAuthorizeCdtDiv"), $("#payAuthorizeCdtBg"));
                        mCenterPopup($("#payAuthorizeCdtDiv"), $("#payAuthorizeCdtBg"));

                        $("#payAuthorizeCasaIdCdt").val(id);
                    } else {
                        triggerAlertMessage(validateCasaAmountResponse.errorMessage);
                    }
                }
            });
        } else {
            triggerAlertMessage("Account Name must not be blank.");
        }
    });


   
    $("#sentBOCDate").change(function() {
    	var confDate = $("#sentBOCDate").val();
    	
        	
        	var searchCdtPaymentUrlsss = '${g.createLink(controller: "inquiry", action: "cdtTransactionsHistoryInquiry")}';
		 	console.log("dumaan0");

		 	searchCdtPaymentUrlsss += ("?confDate=" + confDate)
		 	$("#cdt_list_upload_transactions").jqGrid('setGridParam', {url: searchCdtPaymentUrlsss, page: 1}).trigger("reloadGrid");
		 	
		    var searchCdtPaymentUrlyou = '${g.createLink(controller: "cdt", action: "computeonChangeDate")}';
		    
		    
			var params = {confDate:confDate,unitcode: '${session.unitcode}'};
	

			   $.getJSON(searchCdtPaymentUrlyou,params, function (data) {

				   if(data){

					   $('input[id=confDate]').val(confDate);			
					   $("#totalAmountCollectedTFS").val(parseFloat(data.cdtTotal).toFixed(2));
					   $("#totalAmountPaid").val(parseFloat(data.totalPaid).toFixed(2));
					   
					   $("#totalAmountCollectedsE2M").val(parseFloat(data.e2mTotal).toFixed(2));
				   

					   }

				   
			   });
			

    });
    

   $("#sentBOCDate").datepicker({
                showOn: 'both',
                buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                changeMonth: true,
                changeYear: true,
                constrainInput:true,
                defaultDate: new Date(),
                dateFormat:'mm/dd/yy'
            });


    

    
    $("#errorCorrect").click(function() {
        if ($("#accountNameEC").val()) {

            //set last history
            $("#lastAccountNumberUploadHistory").val($("#mobBocAccountNumberEC").val());
            $("#lastAccountNameUploadHistory").val($("#accountNameEC").val());
            $("#lastAmountUploadHistory").val($("#totalAmountCollectedTFS").val());
            
            $("#unpayAuthorizeUsernameCdt, #unpayAuthorizePasswordCdt").val("");
            mLoadPopup($("#unpayAuthorizeCdtDiv"), $("#unpayAuthorizeCdtBg"));
            mCenterPopup($("#unpayAuthorizeCdtDiv"), $("#unpayAuthorizeCdtBg"));
        } else {
            triggerAlertMessage("Account Name must not be blank.");
        }

        hideTransactionTypes();
    });

});
</script>