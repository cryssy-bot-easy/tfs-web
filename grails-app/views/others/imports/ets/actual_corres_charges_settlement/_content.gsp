<div id="body_forms">
	<div id="body_forms_header">
	%{--<div id="header_details">--}%
		%{--<h3 class="header_details_title">  </h3>--}%
		%{--<h3 class="header_details_title">  </h3>--}%
		%{--<h3 class="header_details_title">  </h3>--}%
		%{--<br /><br /><br />--}%
	%{--</div>--}%
    <div id="header_details">
        <h3 class="header_details_title" id="longNameDisplay"> ${longName} </h3> <g:hiddenField name="longName" value="${longName}" />
        <h3 class="header_details_title" id="address1Display"> ${address1} </h3> <g:hiddenField name="address1" value="${address1}" />
        <h3 class="header_details_title" id="address2Display"> ${address2} </h3> <g:hiddenField name="address2" value="${address2}" />
		<g:hiddenField name="firstName" value="${firstName}"/>
		<g:hiddenField name="middleName" value="${middleName}"/>
		<g:hiddenField name="lastName" value="${lastName}"/>
		<g:hiddenField name="tinNumber" value="${tinNumber}"/>
		<g:hiddenField name="officerCode" value="${officerCode}"/>
		<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>
        <br /><br /><br />
    </div>

	<table id="header_details2">
		<tr>
		  <td><span class="field_label"> CIF Number </span> </td>
		  <td><g:textField name="cifNumber" value="${cifNumber}" class="input_field textFormat-7" readonly="readonly" /> </td>
		</tr>
		<tr>
		  <td> <span class="field_label"> CIF Name </span> </td>
		  <td> <g:textField name="cifName" value="${cifName}" class="input_field textFormat-20" readonly="readonly" /> </td>
		</tr>
		<tr>
		  <td> <span class="field_label"> Account Officer </span> </td>
		  <td> <g:textField name="accountOfficer" value="${accountOfficer}" class="input_field" readonly="readonly" /> </td>
		</tr>
		<tr>
		  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
		  <td> <g:textField name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}" class="input_field textFormat-3" readonly="readonly" /> </td>
			</tr>
		</table>
	</div>
	<div id="tab_container">
    <ul id="tabs">
   		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details<br/>&#160; </span></a></li>
   		<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges<br/>&#160;  </span></a></li>
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing<br/>&#160;  </span></a></li>
  	</ul>
		<div id="basic_details_tab">
            <form id="basicDetailsTabForm">
		     		<g:render template="../others/imports/ets/actual_corres_charges_settlement/basic_details_tab" />
            </form>
		</div>


        <div id="charges_payment_tab">
          	<form id="chargesPaymentTabForm">
					<g:render template="../others/commons/tabs/actual_corres_charges_tab" />
    		</form>
        </div>
      		
	    <div id="instructions_tab">
            <form id="instructionsTabForm">
				<g:render template="../commons/tabs/instructions_and_routing_tab" />
            </form>
		</div>
	</div> <%-- End of TABS --%>
</div>