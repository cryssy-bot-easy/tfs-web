<script type="text/javascript">
    var additionalConditionsUrl = '${g.createLink(controller: "additionalCondition", action: "findAllAdditionalConditions")}';
    var savedAdditionalConditionUrl = '${g.createLink(controller: "additionalCondition", action: "findAllSavedAdditionalConditions")}';
    var addedConditionUrl = '${g.createLink(controller: "additionalCondition", action: "findAllAddedConditions")}';
    var getAllAddedConditionUrl = '${g.createLink(controller: "additionalCondition", action: "getAllAddedConditions")}';

    var swiftChargesUrl = '${g.createLink(controller: "swiftCharge", action: "displayAllSwiftCharges")}';
    var savedSwiftChargesUrl = '${g.createLink(controller: "swiftCharge", action: "getAllSavedSwiftCharges")}';

    var originalConditionsUrl = '${g.createLink(controller: "additionalCondition", action: "findAllOriginalConditions")}';
    var allConditionsUrl = '${g.createLink(controller: "additionalCondition", action: "getAllConditions")}';
    var refConditionsUrl = '${g.createLink(controller: "additionalCondition", action: "getRefConditions")}';
</script>

<g:javascript src="grids/additional_conditions1_original_jqgrid.js" />
<g:javascript src="grids/additional_conditions2_jqgrid.js" />
<g:javascript src="utilities/dataentry/commons/additionalCheckBoxFunction1.js" />
<g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="additionalConditions1" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<table>
    <tr>
        <td> <span class="field_label"> Discrepancy Currency <span class="asterisk">*</span> </span> </td>
        <td> 
            <%-- Auto Complete --%>
            <input class="tags_currency select2_dropdown bigdrop required" name="discrepancyCurrency" id="discrepancyCurrency" />
        </td>
    </tr>
    <tr>
        <td> <span class="field_label"> Discrepancy Amount<span class="asterisk">*</span> </span> </td>
        <td> <g:textField name="discrepancyAmount" value="${discrepancyAmount ?: 60}" class="input_field_right numericCurrency" /> </td>
    </tr>
</table>

<div ng-controller="AdditionalConditionController as acc">

    <p class="p_header">Additional Conditions</p>
    <div class="grid_wrapper">
        <table id="add_conditions1_original_list" class="jqgrid_uppercase"></table>
    </div>

    <span class="right_indent">
        <table>
            <tr>
                <td><input type="button" value="Replace All Conditions" class="input_button_long" ng-click="acc.saveType = 'NEWREPALL'; acc.showActiveConditionsPopup()" ng-disabled="acc.disableReplaceAll"/></td>
                <td><input type="button" value="Add Conditions" id="addCondition" class="input_button_long" ng-click="acc.saveType = 'NEW'; acc.showActiveConditionsPopup();" ng-disabled="acc.disableReplaceAll"/></td>
            </tr>
        </table>
    </span>
    <br/>
    <br/>
    <br/>
    <div class="grid_wrapper">
        <div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" dir="ltr" style="width: 780px;">
            <div class="ui-jqgrid-view" style="width: 780px;">
                <div class="ui-state-default ui-jqgrid-hdiv" style="width: 780px;">
                    <div class="ui-jqgrid-hbox">
                        <table class="ui-jqgrid-htable" style="width:780px" role="grid" aria-labelledby="gbox_add_conditions_list" cellspacing="0" cellpadding="0" border="0">
                            <thead>
                                <tr class="ui-jqgrid-labels" role="rowheader">
                                    <th role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 25px;">
                                        <div><input role="checkbox" class="cbox" type="checkbox" ng-model="acc.checkAll" ng-click="acc.toggleCheckAll()"><span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div>
                                    </th>
                                    <th role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 690px;">
                                        <span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                        <div class="ui-jqgrid-sortable">Available Conditions<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div>
                                    </th>
                                    <th role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 47px;">
                                        <span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                        <div class="ui-jqgrid-sortable">Edit<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div>
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div class="ui-jqgrid-bdiv" style="height: auto; width: 780px;">
                    <div style="position:relative;">
                        <div></div>
                        <table class="jqgrid_uppercase ui-jqgrid-btable" tabindex="1" cellspacing="0" cellpadding="0" border="0" role="grid" aria-multiselectable="true" aria-labelledby="gbox_add_conditions_list" style="width: 780px;">
                            <tbody>
                                <tr ng-repeat="r in acc.conditionList" tabindex="-1" role="row" class="ui-widget-content jqgrow ui-row-ltr" ng-class="{'ui-state-highlight' : r.isChecked}" aria-selected="true" ng-hide="(r.amendCode == 'DELETE' && r.isForModify)" ng-init="r.index = $index;">
                                    <td role="gridcell" style="text-align:center; width: 25px;" aria-describedby="add_conditions_list_cb"><input role="checkbox" type="checkbox" class="cbox" ng-model="r.isChecked" ng-disabled="r.isDisabled" ng-click="acc.toggleCheck(r)"></td>
                                    <td role="gridcell" style="width: 690px;" title="{{r.description}}" aria-describedby="add_conditions_list_description">{{r.description}}</td>
                                    <td role="gridcell" style="text-align:center; width: 47px;" title="edit" aria-describedby="add_conditions_list_edit"><a href="javascript:void(0)" class="jqgrid_inline_links jqgrid_lowercase" ng-hide="r.isDisabled"
                                        ng-click="acc.saveType = r.isNew ? 'EDITNEW' : (r.isLcSaved ? 'EDITSAVED' : 'EDITOLD'); acc.showActiveConditionsPopup(r)">edit</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br/>
    <br/>
    <br/>
    <p class="p_header">Charges</p>
    <div class="swift-narrative-option">
        <br/>
        <label for="chargesNarrativeCheck">
            <input type="checkbox" name="chargesNarrativeCheck" id="chargesNarrativeCheck" ng-init="acc.chargesNarrativeCheck = ${ chargesNarrativeSwitch == 'on' }"
                    ng-model="acc.chargesNarrativeCheck" ng-click="acc.toggleChargesNarrativeCheck()"/>
            &#160;Narrative</label>
        <g:hiddenField name="chargesNarrativeSwitch" value="{{acc.chargesNarrativeCheck ? 'on' : 'off'}}"/>
        <br/>
        <g:select name="narrativeCharges" ng-model="acc.narrativeCharges" ng-change="acc.toggleNarrativeCharges()" ng-disabled="!acc.chargesNarrativeCheck" from="${['BENEFICIARY','APPLICANT']}" ng-init="acc.narrativeCharges = '${narrativeCharges ?: 'BENEFICIARY'}'" class="select_dropdown" />
        <div class="narrative-option small_margin_left">
            <g:textField name="additionalNarrative" style="width: 100%" class="amendment_narrative input_field" ng-disabled="!acc.chargesNarrativeCheck"
                ng-init="acc.additionalNarrative = '${additionalNarrative ? additionalNarrative.toString().replace('\'', '\\\'') : 'All charges outside the Philippines are for the account of the beneficiary including reimbursing charges.'}'"
                ng-model="acc.additionalNarrative"/>
        </div>
    </div>
    <br/>
    <g:hiddenField name="addedAdditionalConditionsList" />
    <g:hiddenField name="additionalConditionsList"/>
    <g:hiddenField name="mtConditions"/>
    <g:hiddenField name="mtConditionsSwitch"/>
    <g:hiddenField name="swiftChargesList" value="[]"/>
    <g:render template="../angular/mt707/popups/active_condition_popup"/>
</div>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<div id="domMessage" style="display:none;">
    <h1>We are processing your request.  Please be patient.</h1>
</div>

<script>
    $(document).ready(function() {
        $("#discrepancyCurrency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${discrepancyCurrency ?: 'USD'}'});
    });
</script>

<r:require module="additionalCondition"/>
