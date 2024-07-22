<script>
    var documentsEnclosedUrl = '${g.createLink(controller: "documentEnclosed", action: "displayDocumentsEnclosedDM")}';
    var enclosedInstructionsUrl = '${g.createLink(controller: "documentEnclosed", action: "displayInstructions")}';
    var additionalInstructionsUrl = '${g.createLink(controller: "documentEnclosed", action: "displayAdditionalInstructions")}';
</script>

<g:javascript src="grids/documents_enclosed_instructions_jqgrid.js"/>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="docEnclosedInstructions" />


<ul class="buttons">
	<li> <a href="javascript:void(0)" class="add_btn" id="add_new_document"> </a> </li>
</ul>
<br /><br />
<%--TENTATIVE COLUMN HEADERS (INTENDED TO BE IMPROVED LATER)--%>
<%--<span style="float: right; width: 217px; height:22px; text-align: center; background: #efe9e5; border: 1px solid #d7d3d0;"> Duplicate </span>--%>
<%--<span style="float: right; width: 225px; height:22px; text-align: center; background: #efe9e5; border: 1px solid #d7d3d0;"> Original </span>--%>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_documents_enclosed"> </table>
</div>

<g:hiddenField name="documentsEnclosedList" value="${documentsEnclosedList}" id="documentsEnclosedList"/>

<br />
<ul class="buttons">
	<li> <a href="javascript:void(0)" class="add_btn" id="add_new_condition"> </a> </li>
	<li> Add Instructions </li>
</ul>
<br /><br />
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_instructions"> </table>
</div>
<g:hiddenField name="enclosedInstructionList" value="${enclosedInstructionList}" id="enclosedInstructionList"/>

<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_additional_conditions"> </table>
</div>

<g:render template="../others/commons/popups/add_new_document_popup" />

<g:render template="../product/commons/popups/add_instructions_popup" />
<g:render template="../product/commons/popups/add_new_instructions_popup" />

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmDocEnclosedInstructions" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmDocEnclosedInstructions" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>


<script>
    $(document).ready(function() {
        $("#saveConfirmDocEnclosedInstructions").click(function() {
            // documentEnclosed
            var selectedDocEnclosed = $("#grid_list_documents_enclosed").jqGrid("getGridParam", "selarrrow");

            for (i in selectedDocEnclosed) {
                var id = selectedDocEnclosed[i];

                // applies changes on click save - start
                var obj = new Object();
                obj.keys = true;
                obj.oneditfunc = null;
                obj.successfunc = null;
                obj.url = documentsEnclosedUrl;
                obj.extraparam = null;
                obj.aftersavefunc = null;
                obj.errorfunc = null;
                obj.afterrestorefunc = null;
                obj.restoreAfterError = true;
                obj.mtype = "POST";

                $("#grid_list_documents_enclosed").saveRow(id, obj, undefined, undefined, undefined, undefined, undefined);
            }

            var arr1 = "";

            $.each(selectedDocEnclosed, function(id, val) {
                var documentSelected = $("#grid_list_documents_enclosed").jqGrid("getRowData", val);

                documentSelected["id"] = val;

                arr1 += JSON.stringify(documentSelected)+"|"
            });

            $("#documentsEnclosedList").val(arr1);

            // enclosedInstructions
            var selectedEnclosedInstr = $("#grid_list_instructions").jqGrid("getGridParam", "selarrrow");

            for (i in selectedEnclosedInstr) {
                var id = selectedEnclosedInstr[i];

                // applies changes on click save - start
                var obj = new Object();
                obj.keys = true;
                obj.oneditfunc = null;
                obj.successfunc = null;
                obj.url = enclosedInstructionsUrl;
                obj.extraparam = null;
                obj.aftersavefunc = null;
                obj.errorfunc = null;
                obj.afterrestorefunc = null;
                obj.restoreAfterError = true;
                obj.mtype = "POST";

                $("#grid_list_instructions").saveRow(id, obj, undefined, undefined, undefined, undefined, undefined);
            }

            var arr2 = "";

            $.each(selectedEnclosedInstr, function(id, val) {
                var instrSelected = $("#grid_list_instructions").jqGrid("getRowData", val);

                instrSelected["id"] = val;
                delete instrSelected.edit;

                arr2 += JSON.stringify(instrSelected)+"|"
            });

            $("#enclosedInstructionList").val(arr2);

            $(".saveAction").show();
        	$(".cancelAction").hide();
            $("#docEnclosedInstructionsTabForm").submit();
        });

        $("#cancelConfirmDocEnclosedInstructions").click(function() {
        	$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#docEnclosedInstructionsDiv"), $("#docEnclosedInstructionsBg"));
            mLoadPopup($("#docEnclosedInstructionsDiv"), $("#docEnclosedInstructionsBg"));
        });
    });
</script>