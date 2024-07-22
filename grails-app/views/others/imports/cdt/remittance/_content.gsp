<div id="body_forms">
	<div id="body_forms_header">
		
	</div>
	<div id="tab_container">
	<ul>
   		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details </span></a></li>
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
  	</ul>
  	
     	<g:form id="basicDetailsTabForm">
		   	<%-- TAB BASIC DETAILS --%>
		     <div id="basic_details_tab">
				<g:render template="../others/imports/cdt/remittance/basic_details_tab" />   
		     </div> <%-- End of TAB BASIC DETAILS --%>
      	</g:form>
      	
		<g:form id="instructionsTabForm">
		<%-- TAB INSTRUCTIONS AND ROUTING --%>
		<div id="instructions_tab">
			<g:render template="../commons/tabs/instructions_and_routing_tab" />
		</div> <%-- End of TAB INSTRUCTIONS AND ROUTING --%>
		</g:form>
		
	</div> <%-- End of TABS --%>
		
</div>