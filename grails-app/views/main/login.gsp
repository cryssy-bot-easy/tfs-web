<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">

<%-- 
  	PROLOGUE
  	SCR/ER Description: Implementation of Version Control Management in TFS login screen
	[Revised by:] Jesse James Joson
 	Program [Revision] Details: Add new container for the area of version number
 								Add label of version number
 	Date deployment: 4/24/2018
 	Member Type: GSP
 	Project: WEB
 	Project Name: login.gsp
--%>
 
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System - Log-in </title>
    
	<script type="text/javascript">

		function onExitClick(){

			window.open('', '_self', ''); //for Chrome
			window.close();
			
		}

		function init(){
			
			setTimeout(function() {
				$('#username').focus();
			}, 1);
			$('#exit').click(onExitClick);
			$('#username').blur(function(){
				$(this).val($(this).val().toUpperCase());
			});
		}

		$(init);
	</script>	

    
  </head>
  <body>
  
    <div id="outer_wrap_login">
	  
	  <%-- LOG-IN HEADER --%>
	  	  
	  <div id="login_area">
	   		<div id="version_area">
	  			<span class="field_label_version"> Version 6.4.14</span>
	  		</div>
			<%--<form id="my-form" method="post" action="login">--%>
        	<g:form action="login" autocomplete="off">
	      		<table id="login_area_table">
	      			<tr>
            			<td colspan="2">
                			<span class="errorMessage">${flash.message}</span>
                		</td>
                	</tr>
                    <tr>
                        <td> <span class="field_label_login"> Domain </span> </td>
                        <td>
                            <g:select from="${['BRANCH', 'UCPB8']}" value="" name="ldapDomain" class="select_dropdown" />
                        </td>
                    </tr>
		    		<tr>
		    			<td> <span class="field_label_login"> User ID </span> </td> 
		    			<td>
                            <g:textField class="input_field_login required1 name" name="username" type="text" />
                        </td>
		    		</tr>
		    		<tr> 
		    			<td> <span class="field_label_login"> Password </span> </td>
		    			<td> <g:passwordField  class="input_field_login required1 pass" name="pwd"/> </td> 
		    		</tr>
		    		<tr>
		    			<td> &nbsp; </td>
		      			<td>
		      				<div id="login_button">
		        				<button type="button" class="input_button_negative" id="exit" value="Exit" >Exit</button>
		        				<button type="reset" class="input_button_negative" id="reset" value="Reset" >Reset</button>
		        				<button type="submit" class="input_button" id="signin" value="Sign-in" >Login</button>
		        			</div>
              			</td>
					</tr>
            		<tr>
            		</tr>
		  		</table> %{--End of login_area_table--}%
				<table style="margin: 75px 0 0 0;width: 100%;">
					<tr> 
		    			<td> 
		    			<p style=" color: #666666; font-family: Calibri; font-weight: bolder; font-style: italic; font-size:14px; text-align:center">
							You are attempting to access a Bank system. Unauthorized access, or access in excess of your authority, 
							<br>may result in administrative and criminal penalties. Your activities are being logged and monitored. 
						</p>
						</td>
		    		</tr>
				</table>
			</g:form>
	  </div> %{--End of login_area--}%

	</div>

  </body>
</html>