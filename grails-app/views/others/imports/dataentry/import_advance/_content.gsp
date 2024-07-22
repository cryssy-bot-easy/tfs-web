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
		<%-- import Advance Refund --%>
		
   			<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details <br/> &#160;</span></a></li>
	   		<g:if test="${serviceType?.equalsIgnoreCase('Refund')}">
	   			<li><a href="#process_refund_tab" id="processRefundTab"><span class="tab_titles"> Process Refund <br/> &#160;</span></a></li>
	   		</g:if>
   			<%-- import Advance Payment --%>
	   		<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">
	   			<li><a href="#mt_details_tab" id="mtDetailsTab2"><span class="tab_titles"> MT Details <br/> &#160;</span></a></li>
	   			<li><a href="#import_advance_amount_details_tab" id="importAdvanceAmountDetailsTab"><span class="tab_titles"> Import Advance Amount Payment Details <br/> &#160;</span></a></li>
	   		</g:if>
   			<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges </span></a></li>
   			<li><a href="#charges_payment_tab" id="chargesDetailsTab"><span class="tab_titles"> Charges Payment <br/> &#160;</span></a></li>
   		
   		
   		
  		
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing <br/> &#160;</span></a></li>
  	</ul>
  	
  		<%-- Import Advance Refund --%>
  		
	     	<g:form id="basicDetailsTabForm">
			   	<%-- TAB BASIC DETAILS --%>  	
				     <div id="basic_details_tab">
				     	<g:if test="${serviceType?.equalsIgnoreCase('Refund')}">
							<g:render template="../others/imports/dataentry/import_advance/refund/basic_details_tab" />   			    	
				    	</g:if>
				    	<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">
							<g:render template="../others/imports/dataentry/import_advance/payment/basic_details_tab" />   			    	
				    	</g:if>
				     </div> <%-- End of TAB BASIC DETAILS --%>   
	      	</g:form>
	      	
	      	<g:if test="${serviceType?.equalsIgnoreCase('Refund')}">
	      		<g:form id="processRefundTabForm">
			   	<%-- TAB BASIC DETAILS --%>  	
				     <div id="process_refund_tab">
							<g:render template="../others/commons/tabs/import_advance_refund_details_tab" />   			    	
				     </div> 
	      		</g:form>
	      	 </g:if>	
	      	 
	      	<g:form id="chargesTabForm">	
				     <div id="charges_tab">
							%{--<g:render template="../others/commons/tabs/import_advance_refund_charges_tab" />   			    	--}%
                         <g:render template="../others/commons/tabs/new/charges_tab" />
				     </div> 
	      	</g:form>
	      	
	      	<g:form id="chargesDetailsTabForm">	
				     <div id="charges_payment_tab">
							<g:render template="../others/commons/tabs/import_advance_refund_charges_details_tab" />   			    	
				     </div> 
	      	</g:form>
       
        
        
        
        
      	<%-- Import Advance Payment --%>
      	<g:if test="${serviceType?.equalsIgnoreCase('Payment')}">
	      	<g:form id="importAdvanceAmountDetailsTabForm">
		      	<div id="import_advance_amount_details_tab">
		      		<g:render template="../others/commons/tabs/import_advance_payment_details_tab" />     
		      	</div>
		    </g:form>  	
	      	<g:form id="mtDetailsTabForm2">
	      		<div id="mt_details_tab">
	      			<g:render template="../others/imports/dataentry/import_advance/payment/mt_details_tab" />
	   			</div>
	      	</g:form>
      	</g:if>
		<g:form id="instructionsTabForm">
		<%-- TAB INSTRUCTIONS AND ROUTING --%>
		<div id="instructions_tab">
			<g:render template="../commons/tabs/instructions_and_routing_tab" />
		</div> <%-- End of TAB INSTRUCTIONS AND ROUTING --%>
		</g:form>
		
	</div> <%-- End of TABS --%>
		
</div>