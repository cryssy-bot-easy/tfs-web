<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System </title>
	<g:javascript src="grids/upload_client_file_grid.js"/>
	<script type="text/javascript">

	    var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}'
		
		//encode client details page
		var encodeClientDetailsUrl = '${g.createLink(controller:'encodeClientDetails', action:'viewEncodeClientDetailsCdt')}'

	</script>
  </head>
  <body>
  
    <div id="outer_wrap">
	  
	  	<%-- HEADER --%>
	  	<g:render template="../layouts/header"/>
	  	  
	  	<%-- ACCORDION --%>
	  	<g:render template="../layouts/accordion"/>

        <g:form name="uploadCdtFileForm" id="uploadTransaction" method="POST" action="uploadDocument" enctype="multipart/form-data" >
        <input type="hidden" name="fileType" value="clients"/>
		<div id="body_forms">
		  	<table class="upload_header">
			  	<tr>
			  		<td><span class="field_label">File Location:</span></td>
			  		<td><input type="file" name="fileLocation" class="input_field_file"/></td>
			  	</tr>
			  	<tr>
			  		<td></td>
                    <td><g:submitButton class="input_button" name="upload" value="Upload" /></td>
			  	</tr>
		  	</table>
			<br/>
			
			<div class="grid_wrapper"> <%-- JQGRID --%>
			  	<table id="cdt_list_upload_client_file"> </table>
				<div id="cdt_pager_upload_client_file"> </div>
			</div>
		</div>
        </g:form>
	</div>
	
  </body>
</html>