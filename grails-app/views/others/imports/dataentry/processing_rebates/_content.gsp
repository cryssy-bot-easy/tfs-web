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
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
  	</ul>
  	
     	<g:form id="basicDetailsTabForm">
		   	<%-- TAB BASIC DETAILS --%>
		     <div id="basic_details_tab">
				<g:render template="../others/imports/dataentry/processing_rebates/basic_details_tab" />   
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