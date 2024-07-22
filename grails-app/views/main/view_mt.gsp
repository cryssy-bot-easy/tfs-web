<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <g:javascript library="jquery"/>
    <r:layoutResources />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'styles.css')}" type="text/css" />
    <title> View MT ${messageType} </title>
  </head>
  <body style="margin-left:1em" onload="js_Load()">
	<div>
		<g:if test="${flash.mtErrorMessage}">
			<h4 class="asterisk">${flash.mtErrorMessage}</h4>
		</g:if>
		<g:else>
	        <ul class="swiftErrorMessage">
	            <g:each in="${errors}" var="error">
	                <li>${error}</li>
	            </g:each>
	        </ul>
	        <g:textArea name="mt_message" class="textarea_view_mt" value="${message}"/>
		</g:else>
    </div>
  </body>
</html>