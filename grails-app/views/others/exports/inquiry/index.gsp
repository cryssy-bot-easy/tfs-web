<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System </title>
		<meta name="layout" content="main" />
		<script type="text/javascript">
			var referenceType = '${referenceType}';
			var serviceType = '${serviceType}';
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var subType1 = '${subType1}';
			var subType2 = '${subType2}';
			var username = '${username}';

			//Auto Complete
		    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
		    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
		    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
		    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
		    
			
		</script>	
		<g:javascript src="popups/alert_utility.js" />
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			<g:render template="../layouts/header"/>
		
			<%-- ACCORDION --%>
			<g:render template="../layouts/accordion" />
			
			<%-- INQUIRY CONTENT --%>
			<div id="body_forms">
			
				<g:if test="${documentType?.equalsIgnoreCase('advising bank')}">
					<g:render template="../others/exports/inquiry/advise/content" />
				</g:if>
				<g:if test="${serviceType?.equalsIgnoreCase('Export Advance')}">
					<g:render template="../others/exports/inquiry/export_advance/content" />
				</g:if>
				<g:if test="${documentType?.equalsIgnoreCase('other export charges')}">
					<g:render template="../others/exports/inquiry/other_export_charges/content" />
				</g:if>
		 	        <g:if test="${documentType?.equalsIgnoreCase('Export Bills')}">
				        <g:render template="../others/exports/inquiry/export_bills/content" />
			        </g:if>
			 </div>
		</div>	
	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/alert" />
	</body>
</html>