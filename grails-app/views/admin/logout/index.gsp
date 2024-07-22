<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="user_admin" />
</head>
<body style="visibility: hidden;" onload="js_Load()">
	<div id="outer_wrap">
	    <g:render template="../layouts/header" model="${[title:'Login Status']}"/>
	    
	     <div id="navigation">
            <div id="Accordion1" class="Accordion">
                <div class="AccordionPanel">
                    <div class="AccordionPanelTab panelHome" id="accordpanel_home">Login Status Home</div>
                    <div class="AccordionPanelContent">
                        <ul>
                            <li><a href="<g:createLink controller="batch"/>">Batch Execution</a></li>
                            <li><a href="<g:createLink controller="logout"/>">Login Status</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
		<div id="body_forms">
           <table class="body_forms_table">
               <tr>
                   <td><span class="field_label">User ID</span></td>
                   <td><input type="text" class="input_field" name="userId" id="userId" value="" maxlength="20"/></td>
                   <td><span class="field_label">Login Status</span></td>
                   <td>
                       <g:select class="select_dropdown" noSelection="${['':'ALL']}" name="loginStatus" keys="${['1','0']}" from="${['LOGGED IN','LOGGED OUT'] }"/>
                   </td>
               </tr>
               <tr>
                   <td colspan="4">
						<input type="button" class="input_button" value="Search" id="searchUsers"/>
                   </td>
               </tr>
           </table>
			<div class="grid_wrapper_user_logout">
				<table id="userTable"></table>
				<div id="userPager"></div>
			</div>
			<g:hiddenField name="selectedUserId" id="selectedUserId" value=""/>
		</div>
	</div>
	<g:render template="/layouts/loading"/>
	<g:render template="/layouts/alert_confirmation" model="${[popupId:'alert_confirmation_div',
		yesBtnId:'confirmLogout',noBtnId:'cancelLogout'] }"/>
	<script>
    $(document).ready(function() {
		$("#loginStatus").val("1");
		var origGridUrl = '${g.createLink(controller:'logout',action:'searchUsersToLogout')}';
		var logoutUserUrl = '${g.createLink(controller:'logout',action:'logoutUser')}';
		
		setupJqGridPager("userTable", 
				{width : 800, height: 500, scrollOffset : 0, rowNum: 30,  shrinkToFit: false,hoverrows:false,beforeSelectRow:function(){return false;}},
				[['userId','User ID'],
				 ['fullName','Full Name'],
				 ['unitCode','Unit Code',50,'center'],
				 ['lastLogin','Last Login'],
				 ['lastLogout','Last Logout'],
				 ['loginStatus','Login Status']],
				 //['userAction','Action']],
				'userPager',
				updateGridUrl(origGridUrl));

		$("#cancelLogout").click(function(){
			mDisablePopup($("#alert_confirmation_div"),$("#alert_confirmation_bg"));
		});		
		$("#confirmLogout").click(function(){
			$.post(logoutUserUrl,{userId:$("#selectedUserId").val()},function(data){
				updateGridContent(null);
				})
			.fail(function(){
					alert("Fail to logout user");
				});
			mDisablePopup($("#alert_confirmation_div"),$("#alert_confirmation_bg"));
		});
		$("#searchUsers").click(function(){
			updateGridContent(1);
		});
		$("#userId,#loginStatus").on("keydown",function(e){
			if(e.which == 13){
				e.preventDefault();
				updateGridContent(1);
			}
		});

		function updateGridContent(pageNumber){
			mCenterPopup($("#loading_div"),$("#loading_bg"));
			mLoadPopup($("#loading_div"),$("#loading_bg"));

			var params = {url:updateGridUrl(origGridUrl)};
			if(pageNumber != null){
				$.extend(params,{page:pageNumber});
			}
			
			$("#userTable").jqGrid("setGridParam",params).trigger("reloadGrid");
			mDisablePopup($("#loading_div"),$("#loading_bg"));			
		}
		
		function updateGridUrl(sourceUrl){
			var userId = "userId=" + $("#userId").val();
			var loginStatus = "loginStatus=" + $("#loginStatus").val();
			var sepChar = "&";
			
			return sourceUrl + "?" + userId + sepChar + loginStatus;
		}
 	});
 	
	function onLogoutClick(userId){
		$("#selectedUserId").val(userId);
		$("#alertPopupMessage").html("Logout User: "+ userId + "?");
		mCenterPopup($("#alert_confirmation_div"),$("#alert_confirmation_bg"));
		mLoadPopup($("#alert_confirmation_div"),$("#alert_confirmation_bg"));
	}
	</script>
</body>
</html>