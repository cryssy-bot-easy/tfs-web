(function() {
  'use strict';

  function RequiredDocumentController(requiredDocumentService, $filter) {
    var vm = this;
    vm.requiredList = [];
    vm.defaultDocument = { documentCode: '', description: '', amendCode: '', isChecked: true,
      isLcSaved: false, isNew: true, isForModify: false, isDisabled: false };
    vm.disableReplaceAll = false;

    function initializeIndex() {
      angular.forEach(vm.requiredList, function(v, k) {
        v.index = k;
      });
    }

    function setDocumentsToBeSaved() {
      var checkedDocuments = [], i = 1, addedList = [], mtDocuments = '', hasAmendment = false, hasReplaceAll = false;
      initializeIndex();
      angular.forEach(vm.requiredList, function(rec) {
        if ((rec.isChecked && !rec.isNew) || rec.isLcSaved) {
          rec.sequenceNumber = i;
          requiredDocumentService.generateAmendId(rec, vm.requiredList);
          i++;
          checkedDocuments.push(rec);
        }
      });
      angular.element('#requiredDocumentsList').val(JSON.stringify(checkedDocuments));

      i = 1;
      angular.forEach(vm.requiredList, function(rec) {
        if (rec.isChecked && rec.documentCode == '') {
          rec.sequenceNumber = i;
          rec.amendId = '';
          if (rec.amendCode == 'REPALL') {
            hasReplaceAll = true;
          }
          addedList.push(rec);
          i++;
        }
      });
      angular.element('#addedDocumentsList').val(JSON.stringify(addedList));
      if(!hasReplaceAll) {
        angular.forEach(checkedDocuments, function(v, i) {
          if (v.amendCode != '') {
            mtDocuments += '/' + v.amendCode + '/' + v.description;
            if (checkedDocuments.length != (i + 1) || addedList.length > 0) {
              mtDocuments += '|';
            }
            hasAmendment = true;
          }
        });
      }
      angular.forEach(addedList, function(v, i) {
        hasAmendment = true;
        mtDocuments += '/' + v.amendCode + '/' + v.description;
        if (addedList.length != (i + 1)) {
          mtDocuments += '|';
        }
      });
      angular.element('#mtDocuments').val(mtDocuments);
      angular.element('#mtDocumentsSwitch').val(hasAmendment ? 'on' : 'off');
    }

    function getRequiredDocuments(documentNumber, tradeServiceId, documentType) {
      var hasReplaceAll = false, replaceAllDocument;
      requiredDocumentService
        .getAllDocuments(documentNumber, tradeServiceId, documentType)
        .then(function httpSuccess(response) {
          vm.requiredList = response.data.results;
          setDocumentsToBeSaved();
          initializeIndex();
          replaceAllDocument = $filter('filter')(vm.requiredList, {amendCode: 'REPALL'}, true);
          hasReplaceAll = replaceAllDocument.length > 0;
          if (hasReplaceAll) {
            vm.requiredList.unshift(replaceAllDocument[0]);
            vm.requiredList.splice(replaceAllDocument[0].index + 1, 1);
            initializeIndex();
            toggleReplaceAll(vm.requiredList[0]);
          }
        });
    }

    function showActiveDocumentsPopup(document) {
      vm.activeDocument = angular.copy(document ? document : vm.defaultDocument);

      centerPopup("popup_docsRequired", "add_docsRequired_bg");
      loadPopup("popup_docsRequired", "add_docsRequired_bg");
    }

    function showPopup(popup, popupBg) {
      centerPopup(popup, popupBg);
      loadPopup(popup, popupBg);
    }

    function closePopup(id, bgId) {
      disablePopup(id, bgId);
    }

    function saveNew(document) {
      var r = angular.copy(vm.defaultDocument);
      r.amendCode = 'ADD';
      r.description = angular.copy(document.description);
      vm.requiredList.push(r);
    }

    function saveModifiedOld(document) {
      document.amendCode = 'ADD';
      document.isChecked = true;
      vm.requiredList[document.index] = angular.copy(document);
    }

    function saveModifiedSaved(document) {
      function hasItem(documentCode, amendCode) {
        return $filter('filter')(origList, {documentCode: documentCode, amendCode: amendCode}, true).length > 0;
      }
      var origList = angular.copy(vm.requiredList),
        modified = hasItem(document.documentCode, 'DELETE') &&
          hasItem(document.documentCode, 'ADD'),
        origDocument;
      document.isChecked = true;
      document.isForModify = true;
      if (!modified) {
        document.amendCode = 'DELETE';
        origDocument = angular.copy(document);
        origDocument.modifyIndex = document.index;
        setDefaultDescription(origDocument);
        vm.requiredList.push(origDocument);
      }
      document.amendCode = 'ADD';
      vm.requiredList[document.index] = angular.copy(document);
    }

    function saveReplaceAll(document) {
      var r = angular.copy(vm.defaultDocument);
      r.amendCode = 'REPALL';
      r.description = angular.copy(document.description);
      vm.requiredList.unshift(r);
      initializeIndex();
      toggleCheck(r);
      vm.disableReplaceAll = true;
    }

    function saveActiveDocument(document) {
      switch(vm.saveType) {
        case 'NEW':
          saveNew(document);
          break;
        case 'EDITNEW':
          vm.requiredList[document.index] = angular.copy(document);
          break;
        case 'EDITOLD':
          saveModifiedOld(document);
          break;
        case 'EDITSAVED':
          saveModifiedSaved(document);
          break;
        case 'NEWREPALL':
          saveReplaceAll(document);
          break;
      }
      setDocumentsToBeSaved();
      closePopup("popup_docsRequired", "add_docsRequired_bg");
    }

    function setDefaultDescription(document) {
      var defaultDocument = $filter('filter')(vm.defaultDocuments, { documentCode: document.documentCode }, true)[0];
      if (defaultDocument) {
        document.description = defaultDocument.description;
      }
    }

    function getDefaultDescription(documentNumber, documentType) {
      requiredDocumentService
        .getRefDocuments(documentNumber, documentType)
        .then(function httpSuccess(response) {
          vm.defaultDocuments = response.data.results;
        });
    }

    function toggleReplaceAll(document) {
      var i, deletedModifyDocuments, hasToBeDeleted;
      vm.disableReplaceAll = document.isChecked;
      if (document.isChecked) {
        // loop all documents with no replace all document and no deleted documents for modify
        angular.forEach(vm.requiredList, function(v, k) {
          if (k != 0 && !(v.amendCode == 'ADD' && v.isForModify)) {
            i = v.index;
            vm.requiredList[i].isChecked = false;
            vm.requiredList[i].isDisabled = true;
            if (v.amendCode == 'DELETE' && v.isForModify) {
              v.amendCode = v.isLcSaved ? 'DELETE' : '';
              v.amendId = i;
              v.isForModify = false;
            }
            if (v.isLcSaved) {
              vm.requiredList[i].amendCode = 'DELETE';
            }

            if (!v.isLcSaved && !v.isNew) {
              v.amendCode = '';
              setDefaultDescription(v);
            }
          }
        });
        // loop all deleted documents for modify
        initializeIndex();
        deletedModifyDocuments = $filter('filter')(vm.requiredList, { amendCode: 'ADD', isForModify: true }, true);
        hasToBeDeleted = deletedModifyDocuments.length > 0;
        while (hasToBeDeleted) {
          vm.requiredList.splice(deletedModifyDocuments[0].index, 1);
          deletedModifyDocuments = $filter('filter')(vm.requiredList, { amendCode: 'ADD', isForModify: true }, true);
          hasToBeDeleted = deletedModifyDocuments.length > 0;
          initializeIndex();
        }
      } else {
        angular.forEach(vm.requiredList, function(v) {
          v.isDisabled = false;
        });
      }
    }

    function toggleCheck(document) {
      var deletedDocument;
      // if replace all document is unchecked/checked
      if (document.amendCode == 'REPALL') {
        toggleReplaceAll(document);
      }

      // if document modified is unchecked
      if (document.isForModify && !document.isChecked) {
        deletedDocument = $filter('filter')(vm.requiredList, {documentCode: document.documentCode, amendCode: 'DELETE'}, true);
        deletedDocument[0].amendCode = document.isLcSaved ? 'DELETE' : '';
        deletedDocument[0].amendId = deletedDocument.index;
        deletedDocument[0].isForModify = false;
        deletedDocument[0].isChecked = false;
        vm.requiredList.splice(document.index, 1);
        initializeIndex();
      }

      // if original document is unchecked
      if (document.isLcSaved) {
        document.amendCode = document.isChecked ? (document.isForModify ? 'ADD' : '') : 'DELETE';
      }

      // if referral document but not original is unchecked
      if (!document.isLcSaved) {
        if (!document.isChecked && !document.isNew){
          document.amendCode = '';
          setDefaultDescription(document);
        } else if(document.isChecked && document.amendCode != 'REPALL') {
          document.amendCode = 'ADD';
        }
      }
      setDocumentsToBeSaved();
    }

    function toggleCheckAll() {
      angular.forEach(vm.requiredList, function(v, k) {
        if (!v.isDisabled) {
          vm.requiredList[k].isChecked = vm.checkAll;
        }
        if (!(v.amendCode == 'DELETE' && v.isForModify)) {
          toggleCheck(v);
        }
      });
      setDocumentsToBeSaved();
    }

    function saveSpecialPayment() {
      switch (vm.specialPayment) {
        case 'BENEFICIARY':
          vm.specialPaymentConditionsForBeneficiaryTo = vm.specialPaymentDescription;
          break;
        case 'RECEIVINGBANK':
          vm.specialPaymentConditionsForReceivingBankTo = vm.specialPaymentDescription;
          break;
      }
      closePopup('popup_special_payment', 'special_payment_bg');
    }

    function toggleSpecialPaymentCheck(specialPayment) {
      switch (specialPayment) {
        case 'BENEFICIARY':
          if (!vm.specialPaymentConditionsForBeneficiaryCheck) {
            vm.specialPaymentConditionsForBeneficiaryTo = '';
            angular.element('#specialPaymentConditionsForBeneficiaryTo').removeClass('required');
          } else {
            angular.element('.popup_btn_input_instructions').click();
            angular.element('#specialPaymentConditionsForBeneficiaryTo').addClass('required');
          }
          break;
        case 'RECEIVINGBANK':
          if (!vm.specialPaymentConditionsForReceivingBankCheck) {
            vm.specialPaymentConditionsForReceivingBankTo = '';
            angular.element('#specialPaymentConditionsForReceivingBankTo').removeClass('required');
          } else {
            angular.element('.popup_btn_input_instructions').click();
            angular.element('#specialPaymentConditionsForReceivingBankTo').addClass('required');
          }
          break;
      }
    }

    function showSpecialPaymentPopup(specialPayment) {
      vm.specialPayment = specialPayment;
      switch (specialPayment) {
      case 'BENEFICIARY':
        vm.specialPaymentDescription = vm.specialPaymentConditionsForBeneficiaryTo;
        break;
      case 'RECEIVINGBANK':
        vm.specialPaymentDescription = vm.specialPaymentConditionsForReceivingBankTo;
        break;
      }
      showPopup('popup_special_payment', 'special_payment_bg');
    }

    getRequiredDocuments($('#documentNumber').val(), $('#tradeServiceId').val(), $('#documentType').val());
    getDefaultDescription($('#documentNumber').val(), $('#documentType').val());
    vm.showActiveDocumentsPopup = showActiveDocumentsPopup;
    vm.showPopup = showPopup;
    vm.closePopup = closePopup;
    vm.saveActiveDocument = saveActiveDocument;
    vm.toggleCheck = toggleCheck;
    vm.toggleCheckAll = toggleCheckAll;
    vm.saveSpecialPayment = saveSpecialPayment;
    vm.toggleSpecialPaymentCheck = toggleSpecialPaymentCheck;
    vm.showSpecialPaymentPopup = showSpecialPaymentPopup;
  }

  RequiredDocumentController.$inject = ['RequiredDocumentService', '$filter'];

  angular
    .module('ApplicationModule')
    .controller('RequiredDocumentController', RequiredDocumentController);
}());

$('#requiredDocDescription').limitCharAndLines(65, 100, 'Z');
$('#specialPaymentDescription').limitCharAndLines(65, 800, 'Z');
