<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System - Log-in </title>
	
	<script type="text/javascript">
		function init(){
            $("#selectrole").click(function() {
                $('form').submit();
            });
		}
		
		$(init);
		
	</script>
	
  </head>
  <body>
  
    <div id="outer_wrap_login">
	  
	  <%-- LOG-IN HEADER --%>
	  
	  <div id="login_area">
<%--	    <h3 id="login_title"> Log-in to your account </h3>--%>
<%--	    <div id="login_area_inside">--%>
		<%--<form id="my-form" method="post" action="login">--%>
        <g:form action="selectRole" >
	      <table id="login_area_table">
		    <tr> <td> <span class="field_label_login"> Select Role </span> </td> </tr>
		    <tr>
		      <td>
                <g:select class="select_dropdown" name="role" from="${session['userrole']}" optionKey="id" optionValue="description"/>

		        <input type="button" class="input_button" id="selectrole" value="Select" />
              </td>
			</tr>

		  </table>

		</g:form>
<%--	    </div>--%>
	  </div>



	  
	  
	
	
	</div>
  
  </body>
</html>