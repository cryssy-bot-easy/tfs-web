<div id="body_forms">
	<div id="body_forms_header">
	<div id="header_details">
		<h3 class="header_details_title">  </h3>
		<h3 class="header_details_title">  </h3>
		<h3 class="header_details_title">  </h3>
		<br /><br /><br />
	</div>
	<table id="header_details2">
		<tr>
		  <td><span class="field_label"> CIF Number </span> </td>
		  <td><g:textField name="cifNumber" class="input_field textFormat-7" readonly="readonly" /> </td>
		</tr>
		<tr> 
		  <td> <span class="field_label"> CIF Name </span> </td>
		  <td> <g:textField name="cifName" class="input_field textFormat-20" readonly="readonly" /> </td>
		</tr>
		<tr> 
		  <td> <span class="field_label"> Account Officer </span> </td>
		  <td> <g:textField name="accountOfficer" class="input_field" readonly="readonly" /> </td>
		</tr>
		<tr> 
		  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
		  <td> <g:textField name="ccbdBranchUnitCode" class="input_field textFormat-3" readonly="readonly" /> </td>
			</tr>
		</table>
	</div>
	<div id="tab_container">
	<ul>
   		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details </span></a></li>
   		<li><a href="#charges_payment_details_tab" id=""><span class="tab_titles"> Payment Details for Charges </span></a></li>
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
  	</ul>
     	<g:form id="basicDetailsTabForm">
		     <div id="basic_details_tab">
		     	<g:render template="../others/imports/ets/other_import_charges_payment/basic_details_tab" />
		     </div> 
      	</g:form>
      	
      	<g:form id="chargesPaymentDetailsTabForm">
		     <div id="charges_payment_details_tab">
		     	<g:render template="../others/commons/tabs/other_import_charges_payment_details_tab" />
		     </div> 
      	</g:form>
      	
		<g:form id="instructionsTabForm">
			<div id="instructions_tab">
				<g:render template="../commons/tabs/instructions_and_routing_tab" />
			</div>
		</g:form>
	</div> <%-- End of TABS --%>
</div>