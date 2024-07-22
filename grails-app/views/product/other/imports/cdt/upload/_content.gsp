
<!-- •••••• 
 
  *(revision)
    SCR/ER Number: 
    SCR/ER Description: 
    [Revised by:] Cedrick Nungay
    [Date Deployed:] 11/23/2017
    Program [Revision] Updated approach on resending email
    PROJECT: WEB
    MEMBER TYPE  : gsp
    Project Name: index
 
 
 -->
 
<script language="javascript">
    %{--var searchCdtPaymentUrl = ' ${params.upload?.equalsIgnoreCase("ok") ? g.createLink(controller: "inquiry", action: "cdtTransactionsInquiry") : ""}';--}%
    var searchCdtPaymentUrl = '${g.createLink(controller: "inquiry", action: "cdtTransactionsInquiry")}';
    var searchCdtEmailTableUrl = '${g.createLink(controller: "inquiry", action: "viewCdtEmailTableResend")}';
    var viewCdtPaymentUrl = '${g.createLink(controller: "product", action: "viewCdtPayment")}';
</script>
<g:javascript src="grids/upload_transactions_grid.js"/>
<g:javascript src="new/cdt/cdt-payment-inquiry.js" />

<g:form method="POST" controller="cdt" action="uploadDocument" enctype="multipart/form-data" >
    <g:hiddenField name="fileType" value="transactions"/>
        %{--<div id="body_forms">--}%
            <table class="upload_header">
                <tr>
                    <td><span class="field_label">File Location:</span></td>
                    <td><input type="file" name="fileLocation" class="input_field_file"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><g:submitButton class="input_button" name="uploadCdt" value="Upload" /></td>
                </tr>
            </table>
            <br/>

        %{--</div>--}%
    </g:form>

<g:form method="POST" controller="cdt" action="resendEmail">
    <g:hiddenField name="iedieirdNumbers" id="iedieirdNumbers"/>
    <div class="grid_wrapper"> <%-- JQGRID --%>
        <table id="cdt_list_upload_transactions"> </table>
        <div id="cdt_pager_upload_transactions"> </div>
    </div><br>
    
    <td><span class="field_label">Notification status by Email Addresses:</span></td>
    <div class="grid_wrapper"> <%-- JQGRID --%>
        <table id="setResendEmailList"> </table>
        <div id="cdt_pager_email_table"> </div>
    </div>
    <div style="margin-top:15px; margin-bottom:50px;">
    <g:submitButton class="input_button2" name="resendEmail" value="Re-send Email" id='resendEmail' /></td>
    </div>
</g:form>
<script type="text/javascript">
    $(document).ready(function() {
		$("#uploadCdt").click(function(){
    		loadPopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
            centerPopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
		});


        $("#resendEmail").click(function(){
            
            var ids = [];

            // change approach on getting list of id
            $("#setResendEmailList > tbody > tr.jqgrow").each(function() {
                ids.push($(this).prop("id"));
            });
            if (ids.length>0) {
                var names = [], il;
                var idx = [], il;
                for (i=0, il=ids.length; i < il; i++) {
                	var isChecked = $('#jqg_setResendEmailList_' + ids[i]).prop('checked');
                    if (isChecked) {
                        namex =  $("#setResendEmailList").jqGrid('getCell', ids[i], 'emailStatus');
                        if (namex === 'E-mail not sent') {
                            namey =  $("#setResendEmailList").jqGrid('getCell', ids[i], 'iedieirdNumber');
                            idx.push(namey);
                            }
                        
                        }
                }

                $('#iedieirdNumbers').val(JSON.stringify(idx));
            }
        });
    });

    
</script>

    
</script>
<g:render template="/layouts/loading_cdt_upload"/>