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
		  <g:if test="${serviceType?.equalsIgnoreCase('payment')}">
		  <td><a href="javascript:void(0)" class="popup_btn" id="popup_btn_cif"> Search/Look-up Button </a></td>
		  </g:if>
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
   		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details <br/> &#160;</span></a></li>
   		<li><a href="#import_advance_amount_details_tab" id="importAdvanceAmountDetailsTab"><span class="tab_titles"> Import Advance Amount Payment Details <br/> &#160;</span></a></li>
		<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges  <br/> &#160;</span></a></li>
   		<li><a href="#charges_payment_details_tab" id="chargesDetailsTab"><span class="tab_titles"> Charges Payment Details <br/> &#160;</span></a></li>
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing <br/> &#160;</span></a></li>
  	</ul>
     	<g:form id="basicDetailsTabForm">
     		<div id="basic_details_tab">
				<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">
					<g:render template="../others/imports/ets/import_advance/payment/basic_details_tab" />   
		    	</g:if>
		     	<g:else>
		     		<g:render template="../others/imports/ets/import_advance/refund/basic_details_tab" />
		     	</g:else>
		     </div>  
      	</g:form>
      	
      	<g:form id="importAdvanceAmountDetailsTabForm">
	      	<div id="import_advance_amount_details_tab">
				%{--<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">--}%
					%{--<g:render template="../others/commons/tabs/import_advance_payment_details_tab" />   --}%
				%{--</g:if>--}%
				%{--<g:else>--}%
					%{--<g:render template="../others/commons/tabs/import_advance_refund_details_tab" />--}%
				%{--</g:else>--}%
                <g:render template="../others/commons/tabs/new/product_payment_tab" />
	      	</div>
      	</g:form>
      	
      	<g:form id="chargesTabForm">
      		<div id="charges_tab">
      			%{--<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">--}%
      				%{--<g:render template="../others/commons/tabs/import_advance_payment_charges_tab" />--}%
      			%{--</g:if>--}%
      			%{--<g:else>--}%
      				%{--<g:render template="../others/commons/tabs/import_advance_refund_charges_tab" />--}%
      			%{--</g:else>--}%
                <g:render template="../others/commons/tabs/new/charges_tab" />
      		</div>
      	</g:form>
      	
      	<g:form id="chargesDetailsTabForm">
      	<div id="charges_payment_details_tab">
      		<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">
				<g:render template="../others/commons/tabs/import_advance_payment_charges_details_tab" />   
			</g:if>
			<g:else>
				<g:render template="../others/commons/tabs/import_advance_refund_charges_details_tab" />   
			</g:else>
      	</div>
		</g:form>
		
		<g:form id="instructionsTabForm">
		<%-- TAB INSTRUCTIONS AND ROUTING --%>
		<div id="instructions_tab">
			<g:render template="../commons/tabs/instructions_and_routing_tab" />
		</div> <%-- End of TAB INSTRUCTIONS AND ROUTING --%>
		</g:form>
	</div> <%-- End of TABS --%>
</div>