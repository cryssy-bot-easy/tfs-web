<div id="navigation">
	<div id="Accordion1" class="Accordion">
		<div class="AccordionPanel">
		    <div class="AccordionPanelTab panelHome" id="accordpanel_home">Actions</div>
		    <div class="AccordionPanelContent">
		        <ul>
		           	<li><a href="${g.createLink(controller:'telecoms',action:'viewUnactedMt')}">Unacted MTs</a></li>            
		           	<li><a href="${g.createLink(controller:'telecoms',action:'viewTransmittedMt')}" id="">View Transmitted MTs</a></li>            
		           	<li><a href="${g.createLink(controller:'telecoms',action:'viewDiscardedMt')}" id="">View Discarded MTs</a></li>
         			<g:if test="${title?.toString().toUpperCase().contains('TRANSMITTED')}">
         				<li><a href="javascript:void(0)" class="generateOutgoingMt">View Report</a></li>
					</g:if>            
		        </ul>
		    </div>
		</div>
	</div>
</div>	    