<%@ page import="net.ipc.utils.DateUtils" %>
<%-- 
(revision)
[Modified by:] Rafael Ski Poblete
[Date Modified:] 8/28/2018
[Description: ] Added CONDITIONAL on partialShipment dropdown.
				Added CONDITIONAL on transShipment dropdown.
				Corrected Transshipment to Transhipment. --%>


<%-- 
(revision)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Added input instructions, modified items of partial shipment and transshipment on MT707
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _shipments_goods_tab.gsp
--%>

<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
<g:javascript src="popups/shipment_period_popup.js" />
</g:if>
<g:javascript src="popups/description_of_goods_popup.js" />
%{--<g:javascript src="utilities/dataentry/commons/shipment_of_goods_utility.js" />--}%
<g:if test="${serviceType?.equalsIgnoreCase('AMENDMENT')}">
    <g:javascript src="utilities/dataentry/amendment/amendment_dataentry_ie_details_utility.js" />
    <g:javascript src="utilities/dataentry/amendment/amendment_dataentry_shipments_goods_utility.js" />
</g:if>
<g:else>
<g:javascript src="utilities/dataentry/commons/shipment_of_goods_utility.js" />
</g:else>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="shipmentsOfGoods" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<g:if test="${serviceType != 'Amendment' }">
<g:hiddenField name="oldRelatedLcDescriptionOfGoods" value="${oldRelatedLcDescriptionOfGoods ?: relatedLcDescriptionOfGoods}"/>
<g:hiddenField name="relatedLcDescriptionOfGoods" value="${relatedLcDescriptionOfGoods}"/>
	<table class="tabs_forms_table">
		<tr>
			<td class="label_width">
				<span class="field_label"> Latest Date of Delivery<br/>(mm/dd/yyyy)
				<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
					<span class="asterisk">*</span>
				</g:if>
				</span>
			</td>
			<td class="input_width">
                <g:textField name="latestShipmentDate" value="${latestShipmentDate ?: expiryDate}" class="datepicker_field" /><br />&#160;
                <%-- what is the purpose of lastShipmentDateComplete? --%>
                <%--<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
                    <g:hiddenField name="lastShipmentDateComplete" id="lastShipmentDateComplete" class="required" value="${lastShipmentDateComplete}" />
                </g:if>
            --%></td>
		</tr>
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			<tr>
				<td class="label_width valign_top"> <span class="field_label"> Shipment Period </span> </td>
				<td>
					<g:textArea maxlength="65" name="shipmentPeriod" value="${shipmentPeriod}" class="textarea" rows="4" readonly="readonly" />
					<input type="button" class="popup_btn_bottom" id="popup_btn_shipment_period"/>
				</td>
			</tr>
		</g:if>
		<tr>
			<td class="label_width valign_top">
				<span class="field_label"> Description of Goods and/or Services<span class="asterisk">*</span> </span>
				<br /><br />
			</td>
			<td>
				<g:textArea maxlength="6500" name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" class="textarea required" rows="4" readonly="readonly" maxlength="6500"/>
				<input type="button" class="popup_btn_bottom" id="popup_btn_description_of_goods"/>
			</td>
		</tr>
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		<tr>
			<td class="label_width"> <span class="field_label"> Commodity Code<span class="asterisk">*</span> </span> </td>
			<td class="input_width">
				<%-- Auto Complete --%>
				<input class="select2_dropdown required" name="commodity" id="commodity" />
				<g:hiddenField name="commodityCode" value="${commodityCode}" />
			</td>
		</tr>
		</g:if>
		<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
			<tr>
				<td><span class="field_label"> By...<span class="asterisk">*</span> </span></td>
				<td>
<%--	                <g:select class="select_dropdown required" name="availableBy" noSelection="[ '':'SELECT ONE...']"--%>
<%--	                          value="${by ?: (documentSubType2.equals("USANCE") ? "A" : ((documentSubType1.equals("REGULAR") && documentSubType2?.equals("SIGHT")) || (documentSubType1.equals("CASH"))) ? "P" : "")}"--%>
<%--	                          from="${documentSubType2.equals("USANCE") ? ["BY ACCEPTANCE", "BY NEGOTIATION"] --%>
<%--								  : ((documentSubType1.equals("REGULAR") && documentSubType2?.equals("SIGHT")) || (documentSubType1.equals("CASH")) || (documentSubType1.equals("STANDBY"))) ? ["BY PAYMENT", "BY NEGOTIATION", "BY ACCEPTANCE"] : []}"--%>
<%--	                          keys="${documentSubType2.equals("USANCE") ? ["A", "N"] : ((documentSubType1.equals("REGULAR") && documentSubType2?.equals("SIGHT")) || documentSubType1.equals("CASH") || documentSubType1.equals("STANDBY")) ? ["P", "N", "A"] : []}" />--%>
	                <g:select class="select_dropdown required" name="availableBy" noSelection="[ '':'SELECT ONE...']"
	                          value="${availableBy ?: (documentSubType2.equals("USANCE") ? "A" : ((documentSubType1.equals("REGULAR") && documentSubType2?.equals("SIGHT")) || (documentSubType1.equals("CASH"))) ? "P" : "")}"
	                          from="${(documentSubType1.equals("REGULAR") || documentSubType1.equals("CASH") || documentSubType1.equals("STANDBY")) ? ["BY PAYMENT", "BY NEGOTIATION", "BY ACCEPTANCE"] : []}"
	                          keys="${(documentSubType1.equals("REGULAR") || documentSubType1.equals("CASH") || documentSubType1.equals("STANDBY")) ? ["P", "N", "A"] : []}" />
	            </td>
			</tr>
			<tr>					
				<td><span class="field_label"> Tenor </span></td>
				<td><g:textField class="input_field" name="tenor" readonly="readonly" value="${tenor ?: 'SIGHT'}"/></td>
			</tr>
			<tr>					
				<g:if test="${tenor?.equalsIgnoreCase('Usance') }">
					<g:if test="${documentSubType1?.equalsIgnoreCase('REGULAR')}">
						<td><p class="field_label">Tenor of Draft <span class="asterisk">* </span><br />(USANCE period) </p></td>
						<td><g:textField class="right input_field_short numericWholeQuantity required" name="usancePeriod" value="${usancePeriod}" /> DAYS </td>
					</g:if>
					<g:else>
						<td><p class="field_label">Tenor of Draft <br />(USANCE period) </p></td>
						<td><g:textField class="right input_field_short numericWholeQuantity" name="usancePeriod" value="${usancePeriod}" readonly="readonly" /> DAYS </td>
					</g:else>
				</g:if>	
			</tr>
				
			<tr>					
				<g:if test="${tenor?.equalsIgnoreCase('Sight') }">
					<td><p class="field_label">Tenor of Draft</p></td>					
					<td><g:textField class="input_field" name="tenorOfDraft" value='${tenorOfDraft ?: 'DRAFT AT SIGHT'}' readonly="readonly"/></td>
				</g:if>
				<g:if test="${tenor?.equalsIgnoreCase('Usance') }">
					<g:if test="${documentSubType1?.equalsIgnoreCase('REGULAR')}">
						<td class="label_width"><span class="field_label">Tenor of Draft <span class="asterisk">* </span><br/>(Narrative)</span></td>
						<td><g:textArea class="textarea required" name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" rows="3" /></td>
					</g:if>
					<g:else>
						<td class="label_width"><span class="field_label">Tenor of Draft <br/>(Narrative)</span></td>
						<td><g:textArea class="textarea" name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" rows="3" readonly="readonly" /></td>
					</g:else>
				</g:if>	
			</tr>			
		<tr>
				<td><span class="field_label"> Partial Delivery <span class="asterisk">* </span></span></td>
				<td>
	                %{--<g:radio class="required" name="partialDelivery" value="ALLOWED" checked="${partialDelivery == 'ALLOWED' ? true : false}"/> <label for="partialDelivery">Allowed</label>--}%
					%{--<g:radio class="required" name="partialDelivery" value="NOT_ALLOWED" checked="${partialDelivery == 'NOT_ALLOWED' ? true : false}" /> <label for="partialDelivery">Not Allowed</label>--}%
	                <g:radioGroup name="partialDelivery" id="partialDelivery" labels="['Allowed','Not Allowed']" values="['ALLOWED', 'NOT_ALLOWED']" value="${partialDelivery}">
	                    <label>${it.radio}&#160;<g:message code="${it.label}" /></label>
	                </g:radioGroup>
                    <script>
                        $(document).ready(function() {
                            $("input[type=radio][name=partialDelivery]").click(function() {
                                $("#partialDeliveryComplete").val($(this).val());
                            });
                        });
                    </script>
                    <g:hiddenField name="partialDeliveryComplete" class="required" value="${partialDelivery}" />
	            </td>
			</tr>
			<%--<tr>
				<td><p class="field_label"> Place of taking in charge/<br />Dispatch from/Place of Receipt </p></td>
				<td colspan="4"><g:textField class="input_field_auto" name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceipt}" maxlength="65"/></td>
			</tr>--%>
			<tr>
	            <td class="label_width valign_top">
	                <p class="field_label">Place of Taking in Charge<br/>/Dispatch from.../Place of<br/>Receipt</p>
	           </td>
	            <td colspan="3"><g:textArea maxlength="65" name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceiptTo ?: placeOfTakingDispatchOrReceipt}" class="textarea" rows="4" maxlength="65"/></td>
	        </tr>
			<%--<tr>
				<td><p class="field_label"> Place of final destination/For<br />transportation to/Place of Delivery </p></td>
				<td colspan="4"><g:textField class="input_field_auto" name="placeOfFinalDestination" value="${placeOfFinalDestination}" maxlength="65"/></td>
			</tr>--%>
			<tr>
	            <td class="label_width valign_top">
	                <p class="field_label">Place of Final Destination<br/>/For Transportation to.../<br/>Place of Delivery</p>
	           </td>
	            <td colspan="3"><g:textArea maxlength="65" name="placeOfFinalDestination" value="${placeOfFinalDestinationTo ?: placeOfFinalDestination}" class="textarea" rows="4" maxlength="65"/></td>
	        </tr>
		</g:if>
		
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && (documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR'))}">
			<tr>
	            <td class="label_width"><span class="field_label">Partial Shipment <span class="asterisk">*</span></span></td>
	            <td colspan="3">
	              <g:select name="partialShipment" value="${partialShipment}"  from="${['ALLOWED', 'CONDITIONAL', 'NOT ALLOWED']}" keys="${['ALLOWED','CONDITIONAL', 'NOT ALLOWED']}" noSelection="['':'SELECT ONE...']" class="select_dropdown required" />
	           </td>
	        </tr>
	        <tr>
	            <td class="label_width"><span class="field_label">Transhipment<span class="asterisk">*</span></span></td>
	            <td colspan="3">
	              <g:select name="transShipment" value="${transShipment}" from="${['ALLOWED', 'CONDITIONAL', 'NOT ALLOWED']}" keys="${['ALLOWED','CONDITIONAL', 'NOT ALLOWED']}" noSelection="['':'SELECT ONE...']" class="select_dropdown required" />
	           </td>
	        </tr>
	        <tr>
	            <td class="label_width">
	                <p class="field_label">Place of Taking in Charge<br/>/Dispatch from.../Place of<br/>Receipt</p>
	           </td>
	            <td colspan="3"><g:textArea maxlength="65" name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceiptTo ?: placeOfTakingDispatchOrReceipt}" class="textarea" rows="4" maxlength="65"/></td>
	        </tr>
	        <tr>
	            <td class="label_width">
	                <p class="field_label">Port of Loading/Airport of<br/>Departure <span class="asterisk">*</span></p>
				</td>
	            <td><g:textArea maxlength="65" name="portOfLoadingOrDeparture" value="${portOfLoadingOrDeparture}" class="textarea required" rows="4" maxlength="65"/></td>
	            <td><span class="field_label">BSP Country Code <span class="asterisk">*</span></span></td>
	            <td>
	        		<input class="tags_country select2_dropdown bigdrop required" name="bspCountryCode" id="bspCountryCode" />
				</td>
	        </tr>
	        <tr>
	            <td class="label_width">
	                <p class="field_label">Port of Discharge/Airport<br/>of Destination <span class="asterisk">*</span> </p>
	           </td>
	            <td colspan="3"><g:textArea maxlength="65" name="portOfDischargeOrDestination" value="${portOfDischargeOrDestinationTo ?: portOfDischargeOrDestination}" class="textarea required" rows="4" maxlength="65"/></td>
	        </tr>
	        <tr>
	            <td class="label_width">
	                <p class="field_label">Place of Final Destination<br/>/For Transportation to.../<br/>Place of Delivery</p>
	           </td>
	            <td colspan="3"><g:textArea maxlength="65" name="placeOfFinalDestination" value="${placeOfFinalDestinationTo ?: placeOfFinalDestination}" class="textarea" rows="4" maxlength="65"/></td>
	        </tr>
        </g:if>
		
	</table>
	<script>    	

    	function checkDescriptionOfGoods() {

    		var str_generalDescriptionOfGoods = $("#generalDescriptionOfGoods").val()
    		var str_relatedLcDescriptionOfGoods = $("#relatedLcDescriptionOfGoods").val()
    		var str_oldDescriptionOfGoods = $("#oldDescriptionOfGoods").val()
    		var str_oldRelatedLcDescriptionOfGoods = $("#oldRelatedLcDescriptionOfGoods").val()
        	
        	if(($.trim(str_relatedLcDescriptionOfGoods) != '' || $.trim(str_relatedLcDescriptionOfGoods) != $.trim(str_oldRelatedLcDescriptionOfGoods))){
            	if ($.trim(str_generalDescriptionOfGoods) == $.trim(str_oldDescriptionOfGoods)){
	        		$("#generalDescriptionOfGoods").val($("#relatedLcDescriptionOfGoods").val());
	        		$("#oldRelatedLcDescriptionOfGoods").val($("#relatedLcDescriptionOfGoods").val());
            	} else {
            		$("#oldDescriptionOfGoods").val($("#generalDescriptionOfGoods").val());
              	}
        	}
       	}

    	$(checkDescriptionOfGoods);
	</script>
</g:if>

<%-- FOR AMENDMENT ONLY --%>
<g:if test="${serviceType == 'Amendment' }">
	<table class="tabs_forms_table">
		<tr>
			<td>
                <g:checkBox name="latestShipmentDateSwitchDisplay"/>
                <g:hiddenField name="latestShipmentDateSwitch" value="${latestShipmentDateSwitch ?: 'off'}" />
            </td>
			<td class="label_width"><span class="field_label"> Latest Date of Delivery<br/>(mm/dd/yyyy) </span></td>
			<td><g:textField name="latestShipmentDateFrom" class="input_field" readonly="readonly" value="${latestShipmentDateFrom ?: latestShipmentDate ?: expiryDate}"/></td>
			<td class="td1"><span class="right_indent">To: <span class="latestShipmentDateToAsterisk">*</span></span></td>
			<td><g:textField maxlength="10" name="latestShipmentDateTo" class="datepicker_field" value="${latestShipmentDateTo}"/></td>
		</tr>
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			<tr>
				<td class="valign_top">
	                <g:checkBox name="shipmentPeriodSwitchDisplay" id="shipmentPeriodSwitchDisplay"/>
	                <g:hiddenField name="shipmentPeriodSwitch" value="${shipmentPeriodSwitch ?: 'off'}" />
	            </td>
				<td class="label_width valign_top"><span class="field_label"> Shipment Period </span></td>
				<td><g:textArea name="shipmentPeriodFrom" class="textarea" readonly="readonly" rows="4" value="${shipmentPeriodFrom ?: shipmentPeriod}"/></td>
				<td class="td1"><span class="right_indent">To: <span class="shipmentPeriodToAsterisk">*</span></span></td>
				<td>
					<g:textArea maxlength="65" name="shipmentPeriodTo" value="${shipmentPeriodTo}" class="textarea" rows="4" readonly="readonly"/>
					<a href="javascript:void(0)" class="popup_btn_bottom amend_shipment_period_btn" id="popup_btn_shipment_period">...</a>
				</td>
			</tr>
		</g:if>
		<tr>
			<td class="valign_top">
                <g:checkBox name="generalDescriptionOfGoodsSwitchDisplay"/>
                <g:hiddenField name="generalDescriptionOfGoodsSwitch" value="${generalDescriptionOfGoodsSwitch ?: 'off'}" />
            </td>
			<td class="label_width valign_top">
				<span class="field_label"> Description of Goods and/or Services </span><br/>
				<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && !documentSubType1?.toString().equalsIgnoreCase('STANDBY')}">
				    <a href="javascript:void(0)" class="popup_btn_input_instructions descriptionOfGoods">input instructions?</a>
				</g:if>
			</td>
			<td><g:textArea name="generalDescriptionOfGoodsFrom" class="textarea" readonly="readonly" rows="4" value="${generalDescriptionOfGoodsFrom ?: generalDescriptionOfGoods}"/></td>
			<td><span class="right_indent">To: <span class="generalDescriptionOfGoodsToAsterisk">*</span></span></td>
			<td>
				<g:textArea name="generalDescriptionOfGoodsTo" value="${generalDescriptionOfGoodsTo}" class="textarea" rows="4" readonly="readonly"/>
				<input type="button" class="popup_btn_bottom amend_description_of_goods_btn" id="popup_btn_description_of_goods"/>
			</td>
		</tr>
		<tr>
			<td>
				<g:checkBox name="partialShipmentSwitchDisplay" />
				<g:hiddenField name="partialShipmentSwitch" value="${partialShipmentSwitch ?: 'off'}" />
			</td>
			<td class="label_width"><span class="field_label">Partial Shipment</span></td>
			<td><g:textField name="partialShipmentFrom" value="${partialShipmentFrom ?: partialShipment}" class="input_field" readonly="readonly" /></td>
			<td><span class="right_indent">To: <span class="partialShipmentToAsterisk">*</span></span></td>
			<td><g:select name="partialShipmentTo" value="${partialShipmentTo}" from="${['ALLOWED', 'CONDITIONAL', 'NOT ALLOWED']}" keys="${['ALLOWED', 'CONDITIONAL', 'NOT ALLOWED']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" /></td>
		</tr>
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			<tr>
				<td>
					<g:checkBox name="commodityCodeSwitchDisplay" />
					<g:hiddenField name="commodityCodeSwitch" value="${commodityCodeSwitch ?: 'off'}" />
				</td>
				<td class="label_width"><span class="field_label">Commodity Code</span></td>
				<td><g:textField name="commodityCodeFrom" value="${commodityCodeFrom ?: commodityCode}" class="select2_dropdown" readonly="readonly" /></td>
				<g:hiddenField name="commodityFrom" value="${commodityCode}"/>
				<td><span class="right_indent">To: <span class="commodityCodeToAsterisk">*</span></span></td>
				<td class="input_width">
	            <%-- Auto Complete  doesnt save if <g:hiddenField is used in field commodityCodeTo--%>
	                <input class="select2_dropdown required" name="commodityTo" id="commodityTo" />
	                <g:textField name="commodityCodeTo" value="${commodityCodeTo}" style="display: none;"/> 
		        </td>
		        
			</tr>
		</g:if>
		<tr>
			<td>
				<g:checkBox name="transShipmentSwitchDisplay" />
				<g:hiddenField name="transShipmentSwitch" value="${transShipmentSwitch ?: 'off'}" />
			</td>
			<td class="label_width"><span class="field_label">Transhipment</span></td>
			<td><g:textField name="transShipmentFrom" value="${transShipmentFrom ?: transShipment}" class="input_field" readonly="readonly" />
			</td>
			<td><span class="right_indent">To: <span class="transShipmentToAsterisk">*</span></span></td>
			<td>
				<g:select name="transShipmentTo" value="${transShipmentTo}" from="${['ALLOWED', 'CONDITIONAL', 'NOT ALLOWED']}" keys="${['ALLOWED','CONDITIONAL', 'NOT ALLOWED']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" />
			</td>
		</tr>
		<tr><td> &#160;</td></tr>
		<tr>
			<td>
				<g:checkBox name="placeOfTakingDispatchOrReceiptSwitchDisplay" />
				<g:hiddenField name="placeOfTakingDispatchOrReceiptSwitch" value="${placeOfTakingDispatchOrReceiptSwitch ?: 'off'}" />
			</td>
	        <td class="label_width"><p class="field_label">Place of Taking in Charge/Dispatch from.../Place of Receipt</p></td>
	        <td><g:textArea name="placeOfTakingDispatchOrReceiptFrom" value="${placeOfTakingDispatchOrReceiptFrom ?: placeOfTakingDispatchOrReceipt}" class="textarea" rows="4" readonly="readonly"/></td>
	    	<td><span class="right_indent">To: <span class="placeOfTakingDispatchOrReceiptToAsterisk">*</span></span></td>
	        <td><g:textArea name="placeOfTakingDispatchOrReceiptTo" value="${placeOfTakingDispatchOrReceiptTo}" class="textarea" rows="4" maxlength="65"/></td>
	    </tr>
		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			<tr>
				<td>
					<g:checkBox name="portOfLoadingOrDepartureSwitchDisplay" />
					<g:hiddenField name="portOfLoadingOrDepartureSwitch" value="${portOfLoadingOrDepartureSwitch ?: 'off'}" />
				</td>
				<td class="label_width"><p class="field_label">Port of Loading/Airport of<br/>Departure</p></td>
				<td><g:textArea name="portOfLoadingOrDepartureFrom" value="${portOfLoadingOrDepartureFrom ?: portOfLoadingOrDeparture}" class="textarea" rows="4" readonly="readonly"/></td>
				<td><span class="right_indent">To: <span class="portOfLoadingOrDepartureTo">*</span></span></td>
				<td><g:textArea name="portOfLoadingOrDepartureTo" value="${portOfLoadingOrDepartureTo}" class="textarea" rows="4" maxlength="65"/></td>
			</tr>
			<tr>
				<td>
					<g:checkBox name="bspCountryCodeSwitchDisplay" />
					<g:hiddenField name="bspCountryCodeSwitch" value="${bspCountryCodeSwitch ?: 'off'}" />
				</td>
				<td class="label_width"><span class="field_label">BSP Country Code</span></td>
				<td><g:textField name="bspCountryCodeFrom" value="${bspCountryCodeFrom ?: bspCountryCode}" class="input_field" readonly="readonly"/></td>
				<td><span class="right_indent">To: <span class="bspCountryCodeToAsterisk">*</span></span></td>
				<td><input class="tags_country select2_dropdown bigdrop" name="bspCountryCodeTo" id="bspCountryCodeTo" />
					<!--<g:textField name="bspCountryCodeTo" value="${bspCountryCodeTo}" style="display: none;"/> -->
				</td>
			</tr>
			<tr>
				<td>
					<g:checkBox name="portOfDischargeOrDestinationSwitchDisplay" />
					<g:hiddenField name="portOfDischargeOrDestinationSwitch" value="${portOfDischargeOrDestinationSwitch ?: 'off'}" />
				</td>
				<td class="label_width"><p class="field_label">Port of Discharge/Airport<br/>of Destination</p></td>
				<td><g:textArea name="portOfDischargeOrDestinationFrom" value="${portOfDischargeOrDestinationFrom ?: portOfDischargeOrDestination}" class="textarea" rows="4" readonly="readonly"/></td>
				<td><span class="right_indent">To: <span class="portOfDischargeOrDestinationToAsterisk">*</span></span></td>
				<td><g:textArea name="portOfDischargeOrDestinationTo" value="${portOfDischargeOrDestinationTo}" class="textarea" rows="4" maxlength="65"/></td>
			</tr>
		</g:if>
	    <tr>
	    	<td>
				<g:checkBox name="placeOfFinalDestinationSwitchDisplay" />
				<g:hiddenField name="placeOfFinalDestinationSwitch" value="${placeOfFinalDestinationSwitch ?: 'off'}" />
			</td>
	        <td class="label_width"><p class="field_label">Place of Final Destination/For Transportation to.../<br/>Place of Delivery</p></td>
	        <td><g:textArea name="placeFinalDestinationFrom" value="${placeFinalDestinationFrom ?: placeOfFinalDestination}" class="textarea" rows="4" readonly="readonly"/></td>
			<td><span class="right_indent">To: <span class="placeOfFinalDestinationToAsterisk">*</span></span></td>
	        <td><g:textArea name="placeOfFinalDestinationTo" value="${placeOfFinalDestinationTo}" class="textarea" rows="4" maxlength="65"/></td>
	    </tr>
	</table>
	<br/>
	%{--<div class="amendmentNarrative">--}%
		%{--<ul>--}%
			%{--<li><span class="bold field_label"> Narrative </span></li>--}%
			%{--<li><div><g:textArea name="narrative_shipment" class="amendment_narrative" value="${narrative_shipment}"/></div></li>--}%
			%{--<li><span class="field_label"><span id="remaining_char_narrative_shipment"></span>&#160;Characters</span></li>--}%
			%{--<li><span class="field_label"><span id="remaining_line_narrative_shipment"></span>&#160;Lines</span></li>--}%
		%{--</ul>--}%
	%{--</div>--}%
</g:if>

<br /><br />

<g:render template="../layouts/buttons_for_grid_wrapper" />


<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
<g:render template="../commons/popups/shipment_period_popup" />
</g:if>
<g:render template="../commons/popups/description_goods_popup" />

<script>
    $(document).ready(function() {
        var commodityCodeFrom = $('#commodityCodeFrom').val(),
            commodityCodeTo = $('#commodityCodeTo').val(),
            commodityFrom = $('#commodityFrom').val(),
            bspCountryCodeTo = $('#bspCountryCodeTo').val(),
            splittedCommodity;

    	$("#bspCountryCodeTo").setCountryDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCodeTo}'});
    	$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

    	$("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });

    	// for amendment
    	$("#commodityTo").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCodeTo').val(splittedCommodity[0].toString().trim());
                $('#commodityCode').val(splittedCommodity[0].toString().trim())
            } else {
                
            	$('#commodityCodeTo').val('');
            	console.log('commodityCodeTo is empty');
            }
        });
		
    	if(commodityFrom) {
            $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityFrom.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#commodityCodeFrom").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                } else {
                	$("#commodityCodeFrom").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: null});
                }
            });
        } else {
        	$("#commodityCodeFrom").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: commodityFrom});
        }
        

    	if(commodityCodeTo) {
            $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCodeTo.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#commodityTo").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                } else {
                    $("#commodityTo").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: commodityCodeTo});
                }
            });
        } else {
        	$("#commodityTo").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: commodityCodeTo});
        }

    	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
    		$("#latestShipmentDate").removeAttr("readonly");
    	</g:if>
        $("#latestShipmentDate").change(function() {
            if ($("#latestShipmentDate").val() != "") {
                $("#latestShipmentDateComplete").val("true");
            } else {
                $("#latestShipmentDateComplete").val("");
            }
        });
    });
</script>