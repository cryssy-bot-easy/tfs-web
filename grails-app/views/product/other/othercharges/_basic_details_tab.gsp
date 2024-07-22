<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />

<g:hiddenField name="currency" value="${currency}" />

<%--
	PROLOGUE:
	(revision)
	SCR/ER Number: ER# 20160620-066 
	SCR/ER Description: Discrepancy under gl code 561201680000 which is not included in the TF Alloc and TFS exception report of May 2016 but reflected in GL RM4105
	[Revised by:] Lymuel Arrome Saul
	[Date revised:] 06/16/2016
	Program [Revision] Details: Removed the condition in the select query which replaces the dash with blanks and exact match only when searching for a document number.
	Date deployment: 6/17/2016
	Member Type: GSP
	Project: WEB
	Project Name: _basic_details_tab.gsp
 --%>
 
<table>
	<tr>
		<td><span class="field_label">TS Number</span></td>
		<td><g:textField name="tradeServiceReferenceNumber" class="input_field" value="${tradeServiceReferenceNumber}" readonly="readonly"/></td>
	</tr>
    <tr>
        <td><span class="field_label">Document Number <span class="asterisk">*</span></span></td>
        <td>
            <g:textField class="input_field required" name="documentNumber" value="${documentNumber}" /><%--<input type="button" class="check_button" id="documentNumberCheck" />--%>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Transaction Type <span class="asterisk">*</span></span></td>
        <td>
            <g:if test="${"IMPORT_CHARGES".equals(documentClass)}">
                <tfs:paymentTransactionTypeImports class="select_dropdown" name="transactionType" value="" />
            </g:if>
            <g:if test="${"EXPORT_CHARGES".equals(documentClass)}">
                <tfs:paymentTransactionTypeExports class="select_dropdown" name="transactionType" value="" />
            </g:if>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Charge Type <span class="asterisk">*</span></span></td>
        <td>
            <g:if test="${"IMPORT_CHARGES".equals(documentClass)}">
                <tfs:paymentChargeTypeImports class="select_dropdown" name="chargeType" value="" />
            </g:if>
            <g:if test="${"EXPORT_CHARGES".equals(documentClass)}">
                <tfs:paymentChargeTypeExports class="select_dropdown" name="chargeType" value="" />
            </g:if>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Charge Amount <span class="asterisk">*</span></span></td>
        <td>
            <g:textField class="input_field_right numericCurrency" name="chargeAmount" value=""/>
        </td>
    </tr>
    <tr>
    	<td><span class="field_label">2% CWT?</span></td>
    	<td>
            <div id="cwtDiv">
    		<g:radioGroup name="cwtFlag" id="cwtFlag" labels="['Yes', 'No']" values="['Y','N']"  value="${cwtFlag ?: 'N'}">
				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
			</g:radioGroup>
            </div>
    	</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <input type="button" id="addCharge" class="input_button2" value="Add" style="float: left"/>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <div class="grid_wrapper_auto2">
                <table id="grid_list_added_charges"></table>
            </div>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Total Amount Due</span></td>
        <td>
            <g:textField class="input_field_right numericCurrency" name="totalAmountDueDisplay" readonly="readonly" value=""/>
        </td>
    </tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<style>
#documentNumber, #documentNumberCheck {float:left;}
</style>
<script>
    var savedOtherChargesOthersUrl = '${g.createLink(controller: "otherCharges", action: "displaySavedOtherChargesOthersGrid")}';
    var addOtherChargesOthersUrl = '${g.createLink(controller: "otherCharges", action: "addOtherChargesOthers")}';
    var deleteOtherChargesOthersUrl = '${g.createLink(controller: "otherCharges", action: "deleteOtherChargesOthers")}';

    function disableAll() {
        $("#addCharge").hide();
        $("#transactionType, #chargeType").attr("disabled", "disabled");
        $("#chargeAmount").attr("readonly", "readonly");
    }

    function setTotalAmountDue() {
        var data = $("#grid_list_added_charges").getGridParam("userData");
        $("#totalAmountDueDisplay").val(data.totalAmountDue);
        $("#totalAmountDue").val(data.totalAmountDue);
    }

    function addCharge() {
        var transactionType = $("#transactionType").val();
        var chargeType = $("#chargeType").val();
        var chargeAmount = $("#chargeAmount").val();

        if (!transactionType || !chargeType || !chargeAmount) {
            triggerAlertMessage("Please fill in all the required fields");
            return;
        }

        var tempCwtFlag = $("input[name=cwtFlag]:checked").val();
        if(tempCwtFlag == null ){
            tempCwtFlag = "N";
        }

        var params = {tradeServiceId: $("#tradeServiceId").val(),
                      transactionType: $("#transactionType").val(),
                      chargeType: $("#chargeType").val(),
                      amount: $("#chargeAmount").val(),
                      cwtFlag:tempCwtFlag};

        $.post(addOtherChargesOthersUrl, params, function(data) {
            $("#transactionType, #chargeType, #chargeAmount").val("");

            $("#grid_list_added_charges").jqGrid('setGridParam', {url: savedOtherChargesOthersUrl, page: 1}).trigger("reloadGrid");
        });
    }

    function deleteAddedCharge(id) {
        $.post(deleteOtherChargesOthersUrl, {tradeServiceId: $("#tradeServiceId").val(),
                                              id: id}, function(data) {
            $("#grid_list_added_charges").jqGrid('setGridParam', {url: savedOtherChargesOthersUrl, page: 1}).trigger("reloadGrid");
        });
    }

    $(document).ready(function() {
        disableAll();
        if ($("#tradeServiceId").val() != "") {
            $("#addCharge").show();

            $("#transactionType, #chargeType").removeAttr("disabled");
            $("#chargeAmount").removeAttr("readonly");
        }

        if ('${documentNumber}') {
            $("#documentNumber").attr("readonly", "readonly");
        }

        setupJqGridWidthNoPagerHiddenShort("grid_list_added_charges", {
            width : 330, height: 100, loadui: "disable", scrollOffset : 0, userDataOnFooter:true,
            gridComplete: setTotalAmountDue
        }, [[ "transactionType", "Transaction Type", 100, "left" ],
            [ "chargeType", "Charge Type", 100, "left" ],
            [ "amount", "Amount", 130, "right"],
            [ "delete", "&nbsp;", 60, "center"]], savedOtherChargesOthersUrl);

        $("#saveConfirmBasicDetails").click(function() {
            if(validateExportTab("#basicDetailsTabForm") > 0){
            	triggerAlertMessage(val_msg);
            } else {
            	mCenterPopup($("#loading_div"), $("#loading_bg"));
            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                $("#basicDetailsTabForm").submit();
            }
        });

        $("#cancelConfirmBasicDetails").click(function() {
            $(".saveAction").hide();
            $(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });

        $("#addCharge").click(addCharge);

        //$("#documentNumberCheck").click(function() {
        $("#documentNumber").change(function() {
            if($("#documentNumber").val()){
                $.post('${g.createLink(controller: "otherCharges", action: "getCifDetailsFromDocumentNumber")}', {documentNumber: $("#documentNumber").val()}, function(data){
                	$("#cifNumber").val(data.cifNumber);
                	$("#cifNumberParam").val(data.cifNumber);
                	$("#cifName").val(data.cifName);
                	$("#cifNameParam").val(data.cifName);
                	$("#accountOfficer").val(data.accountOfficer);
                	$("#accountOfficerParam").val(data.accountOfficer);
                	$("#ccbdBranchUnitCode").val(data.ccbdBranchUnitCode);
                	$("#ccbdBranchUnitCodeParam").val(data.ccbdBranchUnitCode);
                	$("#longName").val(data.longName);
                	$("#longNameDisplay").text(data.longName);
                	$("#address1").val(data.address1);
                	$("#address1Display").text(data.address1);
                	$("#address2").val(data.address2);
                	$("#address2Display").text(data.address2);

                	if(data.status == "error"){
                		triggerAlertMessage("Document Number Not Found in TFS.");
                    }
                }).error(function(){
                    //$("#documentNumber").val("")
                    triggerAlertMessage("Document Number Not Found in TFS.");
                });
            }
         });


        $("#chargeType").change(function() {
            if($("#chargeType").val() == "BANK COMMISSION" || $("#chargeType").val() == "Bank Commission"){
				$("input[name=cwtFlag]").removeAttr("disabled");
            } else {
				$("input[name=cwtFlag][value=N]").attr("checked", "checked");
				$("input[name=cwtFlag]").attr("disabled", "disabled");
            }
        });

    });
</script>