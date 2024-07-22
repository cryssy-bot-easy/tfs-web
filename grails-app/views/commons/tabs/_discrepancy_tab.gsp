<%-- 
(revision)
SCR/ER Number: 
SCR/ER Description: 
[Revised by:] John Patrick C. Bautista
[Date revised:] July 27, 2017
[Date deployed:] 
Program [Revision] Details: Added js file for validations
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _discrepancy_tab.gsp
--%>

<g:javascript src="utilities/dataentry/commons/discrepancy_utility.js" />
<g:javascript src="js-temp/validation_negotiation_discrepancy.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="discrepancy" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="expiredStatus" value="${expiredStatus}"/>

<table class="tabs_form_table">
	<tr>
		<td>
            <g:checkBox name="expiredLcSwitchDisplay"/>
            <g:hiddenField name="expiredLcSwitch" value="${expiredLcSwitch ?: 'off'}" />
        </td>
		<td>
			<span class="field_label">Expired LC</span>
		</td>
	</tr>
	
	<tr>
		<td>
            <g:checkBox name="overdrawnForAmountSwitchDisplay"/>
            <g:hiddenField name="overdrawnForAmountSwitch" value="${overdrawnForAmountSwitch ?: 'off'}" />
        </td>
		<td>
			<span class="field_label">Overdrawn for (Amount)</span>
		</td>
		<td>
			<g:textField name="overdrawnForAmount" value="${overdrawnForAmount}" class="input_field numericCurrency" style="text-align: right;" readonly="readonly" onblur="validateOverdrawnAmt();"/>
		</td>
	</tr>
	
<%--	<g:hiddenField name="totalLines" id="totalLines" value="" />--%>
<%--	<g:hiddenField name="totalLinesDescriptionOfGoods" id="totalLinesDescriptionOfGoods" value="0" />--%>
<%--	<g:hiddenField name="totalLinesDocumentsNotPresent" id="totalLinesDocumentsNotPresent" value="0" />--%>
<%--	<g:hiddenField name="totalLinesOthers" id="totalLinesOthers" value="0" />--%>
	<tr>
		<td valign="top">
            <g:checkBox name="descriptionOfGoodsNotPerLcSwitchDisplay"/>
            <g:hiddenField name="descriptionOfGoodsNotPerLcSwitch" value="${descriptionOfGoodsNotPerLcSwitch ?: 'off'}" />
        </td>
		<td valign="top">
			<span class="field_label">Description of Goods not as per LC</span>
		</td>
		<td>
			<g:textArea class="textarea_long" rows="4" name="descriptionOfGoodsNotAsPerLc" value="${descriptionOfGoodsNotAsPerLc}" style="width: 325px;" readonly="readonly" />
		</td>
		<td valign="bottom">
			<span>
				<a href="javascript:void(0)" class="add_btn" id="popup_btn_description_of_goods_not_as_per_lc">+</a>
			</span>
		</td>
	</tr>
	
	<tr>
		<td valign="top">
            <g:checkBox name="documentsNotPresentedSwitchDisplay"/>
            <g:hiddenField name="documentsNotPresentedSwitch" value="${documentsNotPresentedSwitch ?: 'off'}" />
        </td>
		<td valign="top">
			<span class="field_label">Documents not Presented</span>
		</td>
		<td>
			<g:textArea class="textarea_long" rows="4" name="documentsNotPresented" value="${documentsNotPresented}" style="width: 325px;" readonly="readonly" />
		</td>
		<td valign="bottom">
			<span>
				<a href="javascript:void(0)" class="add_btn" id="popup_btn_documents_not_presented">+</a>
			</span>
		</td>
	</tr>
	
	<tr>
		<td valign="top">
            <g:checkBox name="othersSwitchDisplay"/>
            <g:hiddenField name="othersSwitch" value="${othersSwitch ?: 'off'}" />
        </td>
		<td valign="top"><span class="field_label">Others</span></td>
		<td>
			<g:textArea class="textarea_long" rows="4" name="others" value="${others}" style="width: 325px;" readonly="readonly" />
		</td>
		<td valign="bottom">
			<span>
				<a href="javascript:void(0)" class="add_btn" id="popup_btn_others">+</a>
			</span>
		</td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />