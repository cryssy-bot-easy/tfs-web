<g:if test="${flash.message}">
    <span class="errorMessage">${flash.message}</span>
</g:if>
<g:hiddenField name="referenceType" value="incomingMt"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="mtType" value="${mtType}"/>
<table class="tabs_forms_table">
	<tr>
		<td><span class="fiopenDoneConfirmationeld_label">LC Number</span></td>
		<td>
            <g:hiddenField name="id" value="${id}" />
            <g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">MT Message</span></td>
		<td class="space"><div><g:textArea name="message" value="${message}" class="textarea_mt_message" readonly="readonly"/></div></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Instruction</span></td>
		<td class="space"><g:textArea name="instruction" value="${instruction}" class="textarea_mt_instruction" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Reference Number</span></td>
		<td>
			<g:textField name="tradeServiceReferenceNumber" class="input_field" value="${tradeServiceReferenceNumber}" />
		</td>
	</tr>
</table>
<table class="buttons tabs_forms_table">
	<tr>
		<td>
            %{--<g:submitToRemote name="print" class="input_button" value="Print"/>--}%
            <input type="button" class="input_button generateMtMessage" name="print" value="Print" />
        </td>
	</tr>
	<tr>
		<td>
            %{--<g:submitToRemote name="done" class="input_button" value="Done"/>--}%
            <input type="button" class="input_button openDoneConfirmation" name="done" value="Done" />
        </td>
	</tr>
    <g:if test="${"INCOMING".equals(session.mtModel.messageClass)}">
    <tr>
        <td>
            <input type="button" class="input_button3" id="createLcFromMt"  name="createLcFromMt" value="Create Advise" />
        </td>
    </tr>
    </g:if>
</table>

<g:render template="../product/commons/popups/confirm_alert3"
          model="[confirmId: 'createLcFromMtConfirm', cancelId: 'createLcFromMtCancel', confirmDivId: 'createLcFromMtDiv', confirmBgId: 'createLcFromBg']" />

<script>
    var createLcUrl = '${g.createLink(controller:'incomingMt', action:'createLc')}';

    $(document).ready(function() {
        $("#createLcFromMt").click(function() {
            mCenterPopup($("#createLcFromMtDiv"), $("#createLcFromBg"));
            mLoadPopup($("#createLcFromMtDiv"), $("#createLcFromBg"));
        });

        $("#createLcFromMtCancel").click(function() {
            mDisablePopup($("#createLcFromMtDiv"), $("#createLcFromBg"));
        });

        $("#createLcFromMtConfirm").click(function() {
            var url = createLcUrl;
            url += "?id="+$("#id").val();
            location.href = url;
        });
        var tradeServiceId = $('#tradeServiceId').val();
        var mtType = $('#mtType').val();

        if(mtType == "761" || mtType == "775"){
            $("#createLcFromMt").hide();
        } else if(tradeServiceId && ${!session.mtModel?.canCreateLC}){
            $("#createLcFromMt").hide();
        }
    });
</script>