<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="loading_cdt_upload_div">
    <g:img file="loader.gif" dir="images" />
    <br/>
    <g:if test="${title.equals('Collection of Customs Duties and Taxes - Upload Payment History')}">
    	<span class="cdt_loading">Sending all CDT Payments to BOC <br/> and Sending Email to Clients</span>
    </g:if>
    <g:else>
    	<span class="cdt_loading">Uploading of Today/Pending CDT Transactions <br/> and Sending Email to Clients</span>
    </g:else>    
    
</div>
<div class="popup_bg_alert" id="loading_cdt_upload_bg"></div>
<%-- CONFIRMATION POPUP END --%>