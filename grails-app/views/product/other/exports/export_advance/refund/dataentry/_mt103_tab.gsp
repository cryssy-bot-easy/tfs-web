<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt103DetailsTab" />

    <table class="tabs_forms_table">
        <tr>
            <td><span class="field_label">Value Date</span></td>
            <td><g:textField class="input_field" name="valueDate" value="${valueDate}" readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Receiving Bank</span></td>
            <td><g:select from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="receivingBank" value="${receivingBank}"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Bank Operation Code</span></td>
            <td><g:select from="${['CREDIT','SPAY']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="bankOperationCode" value="${bankOperationCode}"/></td>
        </tr>
        <tr>
            <td><h3 class="title_label">Ordering Customer Details</h3></td>
        </tr>
        <tr>
            <td><span class="field_label">Buyer's CASA Number</span></td>
            <td><g:textField class="input_field" name="buyerCasaNumber"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Buyer's Name</span></td>
            <td><g:textField class="input_field" name="buyerName" maxlength="60"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Buyer's Address</span></td>
            <td><g:textArea class="textarea_long" name="buyerAddress" /></td>
        </tr>
        <tr>
            <td><span class="field_label">Account with Institution</span></td>
            <td><g:select from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="accountWithInstitution"/></td>
        </tr>
        <tr>
            <td><h3 class="title_label">Seller Details</h3></td>
        </tr>
        <tr>
            <td><span class="field_label">Seller's Account Number</span></td>
            <td><g:textField class="input_field" name="sellerAccountNumber"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Seller's Name</span></td>
            <td><g:textField class="input_field" name="sellerName" maxlength="60"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Seller's Address</span></td>
            <td><g:textArea class="textarea_long" name="sellerAddress" /></td>
        </tr>
        <tr>
            <td><h3 class="title_label">Details of Charges</h3></td>
            <td><g:select value="${detailsOfCharges}" from="${['SHA','BEN','OUR']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="detailsOfCharges"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Sender's Charges</span></td>
            <td>
                <g:select from="${['PHP']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="senderChargesCurrency"/>
                <g:textField class="input_field" name="senderCharges"/>
            </td>
        </tr>
        <tr>
            <td><span class="field_label">Receiver's Charges</span></td>
            <td>
                <g:select from="${['PHP']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="receiverChargesCurrency"/>
                <g:textField class="input_field" name="receiverCharges"/>
            </td>
        </tr>
    </table>


<table class="buttons_for_grid_wrapper saveButtonsContainer">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 103" onclick="goToViewMt(103)"/>
		</td>
	</tr>	
    <tr>
        <td><input type="button" id="saveConfirmMtDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmMtDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    $(document).ready(function() {
        $("#saveConfirmMtDetails").click(function() {
        	$(".saveAction").show();
        	$(".cancelAction").hide();
            $("#mt103TabForm").submit();
        });

        $("#cancelConfirmMtDetails").click(function() {
        	$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#mtDetailsDiv"), $("#mtDetailsBg"));
            mLoadPopup($("#mtDetailsDiv"), $("#mtDetailsBg"));
        });
    });
</script>