<div id="body_forms">
	<div id="body_forms_header">
		<div id="header_details">
			<h3 class="header_details_title">  </h3>
			<h3 class="header_details_title">   </h3>
			<h3 class="header_details_title">   </h3>
			<br /><br /><br />
		</div>
		<table id="header_details2">
			<tr>
			  <td> <span class="field_label"> CIF Number </span> </td>
			  <td> <g:textField name="cifNumber" class="input_field" readonly="readonly" value="123456" /> </td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> CIF Name </span> </td>
			  <td> <g:textField name="cifName" class="input_field" readonly="readonly" value="San Fernando Transpo" /> </td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> Account Officer </span> </td>
			  <td> <g:textField name="accountOfficer" class="input_field" readonly="readonly" value="Juliet Periabras" /> </td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
			  <td> <g:textField name="ccbdBranchUnitCode" class="input_field" readonly="readonly" value="930" /> </td>
			</tr>
		</table>
	</div>
	<div id="tab_container">
	<ul>
   		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details </span></a></li>
   		<li><a href="#refund_details_lc_amount_tab" id="refundDetailsLcAmountTab"><span class="tab_titles"> Refund Details for LC Amount </span></a></li>
   		<li><a href="#refund_details_charges_tab" id="refundDetailsChargesTab"><span class="tab_titles"> Refund Details for Charges </span></a></li>
   		<li><a href="#mode_refund_tab" id="modeOfRefundTab"><span class="tab_titles"> Mode of Refund </span></a></li>
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
  	</ul>
  	
     	<g:form id="basicDetailsTabForm">
		   	<%-- TAB BASIC DETAILS --%>
		     <div id="basic_details_tab">
				<g:render template="../others/imports/dataentry/refund_of_cash_lc/basic_details_tab" />   
			 </div>
      	</g:form>

		<g:form id="refundDetailsLcAmountTabForm">
		     <div id="refund_details_lc_amount_tab">
				<g:render template="../others/commons/tabs/refund_details_lc_amount_tab" />   
			 </div>
      	</g:form>
      	
      	<g:form id="refundDetailsChargesTabForm">
		     <div id="refund_details_charges_tab">
				<g:render template="../others/commons/tabs/other_import_charges_payment_details_tab" />   
			 </div>
      	</g:form>
      	
      	<g:form id="modeOfRefundTabForm">
		     <div id="mode_refund_tab">
				<g:render template="../others/commons/tabs/mode_of_refund_tab" />   
			 </div>
      	</g:form>
      	
		<g:form id="instructionsTabForm">
		<%-- TAB INSTRUCTIONS AND ROUTING --%>
		<div id="instructions_tab">
			<g:render template="../commons/tabs/instructions_and_routing_tab" />
		</div> <%-- End of TAB INSTRUCTIONS AND ROUTING --%>
		</g:form>
		<g:render template="../others/commons/popups/other_import_charges_payment_popup"/>
	</div> <%-- End of TABS --%>
		
</div>