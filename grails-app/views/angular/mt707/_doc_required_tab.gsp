<%@ page import="net.ipc.utils.DateUtils" %>
<script type="text/javascript">
    var documentsRequiredUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllRequiredDocuments")}';
    var savedDocumentsRequiredUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllSavedRequiredDocuments")}';
    var addedDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllAddedDocuments")}';
    var getAllAddedDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "getAllAddedDocuments")}';

    var originalDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllOriginalDocuments")}';
    var allDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "getAllDocuments")}';
    var refDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "getRefDocuments")}';
</script>

<g:javascript src="grids/doc_original_jqgrid.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="documentsRequired" />
<g:hiddenField name="draftStatus" value="${draftStatus}" />
<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<div ng-controller="RequiredDocumentController as rdc">
    <div class="grid_wrapper">
        <table id="doc_original_list" class="jqgrid_uppercase"></table>
    </div>
    <span class="right_indent">
        <table>
            <tr>
                <td><input type="button" value="Replace All Documents" class="input_button_long" ng-click="rdc.saveType = 'NEWREPALL'; rdc.showActiveDocumentsPopup()" ng-disabled="rdc.disableReplaceAll"/></td>
                <td><input type="button" value="Add Documents" id="addDocument" class="input_button_long" ng-click="rdc.saveType = 'NEW'; rdc.showActiveDocumentsPopup();" ng-disabled="rdc.disableReplaceAll"/></td>
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
                        <table class="ui-jqgrid-htable" style="width:780px" role="grid" aria-labelledby="gbox_doc_required_list" cellspacing="0" cellpadding="0" border="0">
                            <thead>
                                <tr class="ui-jqgrid-labels" role="rowheader">
                                    <th role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 25px;">
                                        <div><input role="checkbox" class="cbox" type="checkbox" ng-model="rdc.checkAll" ng-click="rdc.toggleCheckAll()"><span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div>
                                    </th>
                                    <th role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 690px;">
                                        <span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                        <div class="ui-jqgrid-sortable">Available Documents<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div>
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
                        <table class="jqgrid_uppercase ui-jqgrid-btable" tabindex="1" cellspacing="0" cellpadding="0" border="0" role="grid" aria-multiselectable="true" aria-labelledby="gbox_doc_required_list" style="width: 780px;">
                            <tbody>
                                <tr ng-repeat="r in rdc.requiredList" tabindex="-1" role="row" class="ui-widget-content jqgrow ui-row-ltr" ng-class="{'ui-state-highlight' : r.isChecked}" aria-selected="true" ng-hide="(r.amendCode == 'DELETE' && r.isForModify)" ng-init="r.index = $index;">
                                    <td role="gridcell" style="text-align:center; width: 25px;" aria-describedby="doc_required_list_cb"><input role="checkbox" type="checkbox" class="cbox" ng-model="r.isChecked" ng-disabled="r.isDisabled" ng-click="rdc.toggleCheck(r)"></td>
                                    <td role="gridcell" style="width: 690px;" title="{{r.description}}" aria-describedby="doc_required_list_description">{{r.description}}</td>
                                    <td role="gridcell" style="text-align:center; width: 47px;" title="edit" aria-describedby="doc_required_list_edit"><a href="javascript:void(0)" class="jqgrid_inline_links jqgrid_lowercase" ng-hide="r.isDisabled"
                                        ng-click="rdc.saveType = r.isNew ? 'EDITNEW' : (r.isLcSaved ? 'EDITSAVED' : 'EDITOLD'); rdc.showActiveDocumentsPopup(r)">edit</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <g:hiddenField name="addedDocumentsList" value="" />
    <br/>
    <div>
        <table class="amendment_special_condition">
            <tr>
                <td>
                    <input type="checkbox" ng-init="rdc.specialPaymentConditionsForBeneficiaryCheck = ${ specialPaymentConditionsForBeneficiarySwitch == 'on' }"
                        ng-model="rdc.specialPaymentConditionsForBeneficiaryCheck" ng-click="rdc.toggleSpecialPaymentCheck('BENEFICIARY')"/>
                    <g:hiddenField name="specialPaymentConditionsForBeneficiarySwitch" value="{{rdc.specialPaymentConditionsForBeneficiaryCheck ? 'on' : 'off'}}"/>
                </td>
                <td><p class="title_label">Special Payment Conditions for Beneficiary</p></td>
            </tr>
            <tr>
                <td></td>
                <td><a href="javascript:void(0)" class="popup_btn_input_instructions" ng-show="rdc.specialPaymentConditionsForBeneficiaryCheck">input instructions?</a></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <g:textArea name="specialPaymentConditionsForBeneficiaryFrom" value="${specialPaymentConditionsForBeneficiary ?: specialPaymentConditionsForBeneficiaryFrom}" class="textarea" rows="10" readonly="readonly"/>
                </td>
                <td><span>To: <span class="asterisk" ng-show="rdc.specialPaymentConditionsForBeneficiaryCheck">*</span></span></td>
                <td>
                    <g:textArea name="specialPaymentConditionsForBeneficiaryTo" ng-init="rdc.specialPaymentConditionsForBeneficiaryTo = '${specialPaymentConditionsForBeneficiaryTo ? specialPaymentConditionsForBeneficiaryTo.toString().replace('\'', '\\\'') : ''}'"
                        ng-model="rdc.specialPaymentConditionsForBeneficiaryTo" class="textarea" rows="10" readonly="readonly"/>
                    <input type="button" class="popup_btn_bottom" ng-show="rdc.specialPaymentConditionsForBeneficiaryCheck"
                        ng-click="rdc.showSpecialPaymentPopup('BENEFICIARY')"/>
                </td>
            <tr>
        </table>
    </div>
    <br/>
    <div>
        <table class="amendment_special_condition">
            <tr>
                <td>
                    <input type="checkbox" ng-init="rdc.specialPaymentConditionsForReceivingBankCheck = ${ specialPaymentConditionsForReceivingBankSwitch == 'on' }"
                        ng-model="rdc.specialPaymentConditionsForReceivingBankCheck" ng-click="rdc.toggleSpecialPaymentCheck('RECEIVINGBANK')"/>
                    <g:hiddenField name="specialPaymentConditionsForReceivingBankSwitch" value="{{rdc.specialPaymentConditionsForReceivingBankCheck ? 'on' : 'off'}}"/>
                </td>
                <td><p class="title_label">Special Payment Conditions for Receiving Bank</p></td>
            </tr>
            <tr>
                <td></td>
                <td><a href="javascript:void(0)" class="popup_btn_input_instructions" ng-show="rdc.specialPaymentConditionsForReceivingBankCheck">input instructions?</a></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <g:textArea name="specialPaymentConditionsForReceivingBankFrom" value="${specialPaymentConditionsForReceivingBank ?: specialPaymentConditionsForReceivingBankFrom}" class="textarea" rows="10" readonly="readonly"/>
                </td>
                <td><span>To: <span class="asterisk" ng-show="rdc.specialPaymentConditionsForReceivingBankCheck">*</span></span></td>
                <td>
                    <g:textArea name="specialPaymentConditionsForReceivingBankTo" ng-init="rdc.specialPaymentConditionsForReceivingBankTo = '${specialPaymentConditionsForReceivingBankTo ? specialPaymentConditionsForReceivingBankTo.toString().replace('\'', '\\\'') : ''}'"
                        ng-model="rdc.specialPaymentConditionsForReceivingBankTo" class="textarea" rows="10" readonly="readonly"/>
                    <input type="button" class="popup_btn_bottom" ng-show="rdc.specialPaymentConditionsForReceivingBankCheck"
                        ng-click="rdc.showSpecialPaymentPopup('RECEIVINGBANK')"/>
                </td>
            <tr>
        </table>
    </div>
    <br/>
    <g:hiddenField name="requiredDocumentsList"/>
    <g:hiddenField name="mtDocuments"/>
    <g:hiddenField name="mtDocumentsSwitch"/>
    <g:render template="../angular/mt707/popups/active_documents_popup"/>
    <g:render template="../angular/mt707/popups/special_payment_popup"/>
</div>
<br/>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<r:require module="requiredDoc"/>
