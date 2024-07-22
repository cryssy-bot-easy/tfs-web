
<script language="javascript">
    %{--var searchCdtPaymentUrl = ' ${params.upload?.equalsIgnoreCase("ok") ? g.createLink(controller: "inquiry", action: "cdtInquiryClientInquiry") : ""}';--}%
    var searchCdtPaymentUrl = '${g.createLink(controller: "inquiry", action: "cdtInquiryClientInquiry")}';
    var viewCdtClientUrl = '${g.createLink(controller: "product", action: "viewCdtClient")}';
</script>
<g:javascript src="grids/upload_client_file_grid.js"/>
<g:javascript src="new/cdt/cdt-client-inquiry.js" />
<g:form method="POST" controller="cdt" action="uploadDocument" enctype="multipart/form-data" >
    <g:hiddenField name="fileType" value="clients"/>
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


    <div class="grid_wrapper"> <%-- JQGRID --%>
        <table id="cdt_list_upload_client_file"> </table>
        <div id="cdt_pager_upload_client_file"> </div>
    </div>


<script type="text/javascript">
    $(document).ready(function() {

    });
</script>