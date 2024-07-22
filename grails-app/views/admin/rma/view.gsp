<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
</head>
<body>
<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "Upload RMA"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">
    	<div>
    		accepted file: *.txt,*.xml
    	</div>
		<g:form id="uploadFile" name="uploadFile" action="uploadFile" enctype="multipart/form-data">
			<input type="file" class="input_field_file" name="inputFile" id="inputFile"/>
<%--			<g:submitButton name="uploadButton" id="uploadButton" />--%>
			<input type="button" name="uploadButton" id="uploadButton" value="Upload" />
		</g:form>
		<g:if test="${flash.message}">
			<span class="errorMessage">${flash.message}</span>
		</g:if>
    </div>
</div>
    <%--GSP for triggering alert popups--%>
    <g:render template="../layouts/alert"/>
    <%--Popup plugin--%>
    <g:javascript src="pop_up.js"/>
    <g:render template="../layouts/loading"/>
    <script>
		$(function(){
			$("#uploadButton").click(function(){
				centerPopup("loading_div", "loading_bg");
				loadPopup("loading_div", "loading_bg");
				
				$("#uploadFile").submit();
			});
		});
    </script>
</body>
</html>