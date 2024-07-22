<%-- 
(revision)
SCR/ER Number: 20170510-057
SCR/ER Description: Encounter error 500 or unending loading screen when the idle timeout (15 minutes) was reached and try to click view MT or click the charges tab.
[Revised by:] Jesse James Joson
[Date deployed:]
Program [Revision] Details: Add variable logoutUrl that contains the link to be called by the force logout in login.js.
Member Type: GSP 
Project: WEB
Project Name: _header.gsp

--%> 
	  
	  <div id="header" 
	  	<g:if test="${windowed && !(documentClass in ['DP', 'DA', 'DR', 'OA'])}">class="window"</g:if>
	  	<g:if test="${windowed && (documentClass in ['DP', 'DA', 'DR', 'OA'])}">class="window_nonlc"</g:if>
	  >
	    <a href="javascript:void(0)" id="logo"> UCPB - We do more because we care </a>
	    <div class="header-pane">
			<h1 id="title"> Trade Finance System </h1>
			<h2 id="subtitle"> ${title} </h2>
			<div>
				<ul id="header_info">
				  <li> ${session?.userrole?.description} </li>
				  <li> | </li>
				  <li> ${session?.firstname} ${session?.lastname}</li>
				  <li> | </li>
				  <li> <span class="jclock"></span> </li>
				  <li> | </li>
				  <li>
		              ${new Date().format('dd MMM yyyy')}
		              %{--<span id="dateNow">${new Date().format('dd MMM yyyy')}</span>--}%
		          </li>
				  <li> | </li>
				  <li> <a href="javascript:void(0)" id="help"> Help </a> </li>
				  <li> | </li>
				  <g:if test="${windowed}">
			  			<li> <a href="javascript:void(0)" id="close"> Close </a> </li>
				  </g:if>
				  <g:else>	
				  		<li> <a href="javascript:location.href='${g.createLink(controller:'login', action:'logout')}'" id="logout"> Logout </a> </li>
				  </g:else>
				</ul>
			</div>
		</div>
		<%-- for url parameters, for reports --%>
		<g:hiddenField name="preparedByFirstName" value="${session?.firstname}"/>
		<g:hiddenField name="preparedByLastName" value="${session?.lastname}"/>
		<g:hiddenField name="currentDate" value="${new Date().format('MM/dd/yyyy')}"/>
		<g:hiddenField name="userRole" value="${session?.userrole?.description}"/>
		<g:hiddenField name="userRoleId" value="${session?.userrole?.id}"/>
	  </div>
	  
	  
	  <script type="text/javascript">

		var startTimerUrl = '${g.createLink(controller:'login', action:'startTimer')}';
		var logoutUrl = '${g.createLink(controller:'login', action:'sessionEnd')}';
		var logout = '${g.createLink(controller:'login', action:'logout')}';
		var test = "";
          $(document).ready(function(){

            $(window).bind('beforeunload', function(){
                if (test == "FORCED") {
                	test = "FORCED";
                } else {
                    return "You are about to close Trade Finance System.";
                }
            });
            $(window).bind('unload', function(){
                if (test == "FORCED") {
                	test = "";
                } else {
                	$.get("${g.createLink(controller:'login', action:'logout')}",{message: 'HERE...'}, function(){});
                }
            });
            
			$("a, input[type='button']").live('click', function(){
				bindUnbind();
			});

            $("form").on("submit", function(){
            	bindUnbind();
            });
            
            function bindUnbind() {

            	$(window).unbind('unload');
                $(window).unbind('beforeunload');
            }
         });
      </script>
      	
	<g:javascript src="login.js"/>