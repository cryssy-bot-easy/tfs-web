<g:javascript src="grids/transmittal_letter_jqgrid.js" />
<g:javascript src="popups/transmittal_letter_popup.js" />

<script type="text/javascript">
    var transmittalLettersUrl = '${g.createLink(controller: "transmittalLetter", action: "findAllTransmittalLetter")}';
    var savedTransmittalLetterUrl = '${g.createLink(controller: "transmittalLetter", action: "findAllSavedTransmittalLetters")}';
    var addedLetterUrl = '${g.createLink(controller: "transmittalLetter", action: "findAllAddedLetter")}';
    var getAllAddedLetterUrl = '${g.createLink(controller: "transmittalLetter", action: "getAllAddedLetters")}';
    $(document).ready(function() {
//        $("#tempContainer").hide();
    });
</script>

<div id="tempContainer">

</div>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="detailsForTransmittalLetter" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<div class="grid_wrapper_min"> <%-- JQGRID --%>
    <table id="grid_list_clients_documents"> </table>
    <g:hiddenField name="transmittalLetterList" value="" />
</div>
<ul class="buttons_add_trans_letter">
    <li><a href="javascript:void(0)" id="addTransmittalLetter" class="add_btn">	</a></li>
    <li>Add</li>
</ul>
<br /><br />

<table class="buttons_for_grid_wrapper">
    %{--<g:if test="${!documentClass?.equalsIgnoreCase('lc') }">--}%
        %{--<tr>--}%
            %{--<td>--}%
                %{--<input type="button" class="input_button3" name="addConditions" value="Add Documents" />--}%
            %{--</td>--}%
        %{--</tr>--}%
    %{--</g:if>--}%
</table>

<div class="grid_wrapper_min"> <%-- JQGRID --%>
    <table id="grid_list_transmittal_letter"> </table>
    %{--<div id="grid_pager_transmittal_letter"></div>--}%
    <g:hiddenField class="input_field_long" name="addedTransmittalLetterList" value="" />
</div>
<br />

<script>
    $(document).ready(function() {
        $("#detailsTransmittalLetterTabForm").change(function() {
            formChanged = "#detailsTransmittalLetterTabForm";
            formIsChanged = true;
        });
    });
</script>

<g:render template="../commons/popups/addedit_letter_popup" />
<g:render template="../layouts/buttons_for_grid_wrapper" />

