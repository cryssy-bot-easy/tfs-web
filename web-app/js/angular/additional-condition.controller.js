(function() {
  'use strict';

  function AdditionalConditionController(additionalConditionService, $filter) {
    var vm = this;
    vm.conditionList = [];
    vm.defaultCondition = { conditionCode: '', description: '', amendCode: '', isChecked: true,
      isLcSaved: false, isNew: true, isForModify: false, isDisabled: false };
    vm.disableReplaceAll = false;

    function initializeIndex() {
      angular.forEach(vm.conditionList, function(v, k) {
        v.index = k;
      });
    }

    function setConditionsToBeSaved() {
      var checkedConditions = [], i = 1, addedList = [], mtConditions = '', hasAmendment = false, hasReplaceAll = false;
      initializeIndex();
      angular.forEach(vm.conditionList, function(rec) {
        if ((rec.isChecked && !rec.isNew) || rec.isLcSaved) {
          rec.sequenceNumber = i;
          additionalConditionService.generateAmendId(rec, vm.conditionList);
          i++;
          checkedConditions.push(rec);
        }
      });
      angular.element('#additionalConditionsList').val(JSON.stringify(checkedConditions));

      i = 1;
      angular.forEach(vm.conditionList, function(rec) {
        if (rec.isChecked && rec.conditionCode == '') {
          rec.sequenceNumber = i;
          rec.amendId = '';
          if (rec.amendCode == 'REPALL') {
              hasReplaceAll = true;
            }
          addedList.push(rec);
          i++;
        }
      });
      angular.element('#addedAdditionalConditionsList').val(JSON.stringify(addedList));
      if(!hasReplaceAll) {
        angular.forEach(checkedConditions, function(v, i) {
          if (v.amendCode != '') {
            mtConditions += '/' + v.amendCode + '/' + v.description;
            if (checkedConditions.length != (i + 1) || addedList.length > 0) {
              mtConditions += '|';
            }
            hasAmendment = true;
          }
        });
      }
      angular.forEach(addedList, function(v, i) {
        if (v.amendCode != '') {
          hasAmendment = true;
          mtConditions += '/' + v.amendCode + '/' + v.description;
          if (addedList.length != (i + 1)) {
            mtConditions += '|';
          }
        }
      });
      angular.element('#mtConditions').val(mtConditions);
      angular.element('#mtConditionsSwitch').val(hasAmendment ? 'on' : 'off');
    }

    function getAdditionalConditions(documentNumber, tradeServiceId) {
      var hasReplaceAll = false, replaceAllCondition;
      additionalConditionService
        .getAllConditions(documentNumber, tradeServiceId)
        .then(function httpSuccess(response) {
          vm.conditionList = response.data.results;
          setConditionsToBeSaved();
          initializeIndex();
          replaceAllCondition = $filter('filter')(vm.conditionList, {amendCode: 'REPALL'}, true);
          hasReplaceAll = replaceAllCondition.length > 0;
          if (hasReplaceAll) {
            vm.conditionList.unshift(replaceAllCondition[0]);
            vm.conditionList.splice(replaceAllCondition[0].index + 1, 1);
            initializeIndex();
            toggleReplaceAll(vm.conditionList[0]);
          }
        });
    }

    function showActiveConditionsPopup(condition) {
      vm.activeCondition = angular.copy(condition ? condition : vm.defaultCondition);

      centerPopup("popup_addCondition", "add_addCondition_bg");
      loadPopup("popup_addCondition", "add_addCondition_bg");
    }

    function showPopup(popup, popupBg) {
      centerPopup(popup, popupBg);
      loadPopup(popup, popupBg);
    }

    function closePopup(id, bgId) {
      disablePopup(id, bgId);
    }

    function saveNew(condition) {
      var r = angular.copy(vm.defaultCondition);
      r.amendCode = 'ADD';
      r.description = angular.copy(condition.description);
      vm.conditionList.push(r);
    }

    function saveModifiedOld(condition) {
      condition.amendCode = 'ADD';
      condition.isChecked = true;
      vm.conditionList[condition.index] = angular.copy(condition);
    }

    function saveModifiedSaved(condition) {
      function hasItem(conditionCode, amendCode) {
        return $filter('filter')(origList, {conditionCode: conditionCode, amendCode: amendCode}, true).length > 0;
      }
      var origList = angular.copy(vm.conditionList),
        modified = hasItem(condition.conditionCode, 'DELETE') &&
          hasItem(condition.conditionCode, 'ADD'),
        origCondition;
      condition.isChecked = true;
      condition.isForModify = true;
      if (!modified) {
        condition.amendCode = 'DELETE';
        origCondition = angular.copy(condition);
        origCondition.modifyIndex = condition.index;
        setDefaultDescription(origCondition);
        vm.conditionList.push(origCondition);
      }
      condition.amendCode = 'ADD';
      vm.conditionList[condition.index] = angular.copy(condition);
    }

    function saveReplaceAll(condition) {
      var r = angular.copy(vm.defaultCondition);
      r.amendCode = 'REPALL';
      r.description = angular.copy(condition.description);
      vm.conditionList.unshift(r);
      initializeIndex();
      toggleCheck(r);
      vm.disableReplaceAll = true;
    }

    function saveActiveCondition(condition) {
      switch(vm.saveType) {
        case 'NEW':
          saveNew(condition);
        break;
        case 'EDITNEW':
          vm.conditionList[condition.index] = angular.copy(condition);
          break;
        case 'EDITOLD':
          saveModifiedOld(condition);
          break;
        case 'EDITSAVED':
          saveModifiedSaved(condition);
          break;
        case 'NEWREPALL':
          saveReplaceAll(condition);
          break;
      }
      setConditionsToBeSaved();
      closePopup("popup_addCondition", "add_addCondition_bg");
    }

    function setDefaultDescription(condition) {
      var defaultCondition = $filter('filter')(vm.defaultConditions, { conditionCode: condition.conditionCode }, true)[0];
      if (defaultCondition) {
        condition.description = defaultCondition.description;
      }
    }

    function getDefaultDescription(documentNumber) {
      additionalConditionService
        .getRefConditions(documentNumber)
        .then(function httpSuccess(response) {
          vm.defaultConditions = response.data.results;
        });
    }

    function toggleReplaceAll(condition) {
      var i, deletedModifyConditions, hasToBeDeleted;
      vm.disableReplaceAll = condition.isChecked;
      if (condition.isChecked) {
        // loop all conditions with no replace all condition and no deleted conditions for modify
        angular.forEach(vm.conditionList, function(v, k) {
          if (k != 0 && !(v.amendCode == 'ADD' && v.isForModify)) {
            i = v.index;
            vm.conditionList[i].isChecked = false;
            vm.conditionList[i].isDisabled = true;
            if (v.amendCode == 'DELETE' && v.isForModify) {
              v.amendCode = v.isLcSaved ? 'DELETE' : '';
              v.amendId = i;
              v.isForModify = false;
            }
            if (v.isLcSaved) {
              vm.conditionList[i].amendCode = 'DELETE';
            }

            if (!v.isLcSaved && !v.isNew) {
              v.amendCode = '';
              setDefaultDescription(v);
            }
          }
        });
        // loop all deleted conditions for modify
        initializeIndex();
        deletedModifyConditions = $filter('filter')(vm.conditionList, { amendCode: 'ADD', isForModify: true }, true);
        hasToBeDeleted = deletedModifyConditions.length > 0;
        while (hasToBeDeleted) {
          vm.conditionList.splice(deletedModifyConditions[0].index, 1);
          deletedModifyConditions = $filter('filter')(vm.conditionList, { amendCode: 'ADD', isForModify: true }, true);
          hasToBeDeleted = deletedModifyConditions.length > 0;
          initializeIndex();
        }
      } else {
        angular.forEach(vm.conditionList, function(v) {
          v.isDisabled = false;
        });
      }
    }

    function toggleCheck(condition) {
      var deletedCondition;
      // if replace all condition is unchecked/checked
      if (condition.amendCode == 'REPALL') {
        toggleReplaceAll(condition);
      }

      // if condition modified is unchecked
      if (condition.isForModify && !condition.isChecked) {
        deletedCondition = $filter('filter')(vm.conditionList, {conditionCode: condition.conditionCode, amendCode: 'DELETE'}, true);
        deletedCondition[0].amendCode = condition.isLcSaved ? 'DELETE' : '';
        deletedCondition[0].amendId = deletedCondition.index;
        deletedCondition[0].isForModify = false;
        deletedCondition[0].isChecked = false;
        vm.conditionList.splice(condition.index, 1);
        initializeIndex();
      }

      // if original condition is unchecked
      if (condition.isLcSaved) {
        condition.amendCode = condition.isChecked ? (condition.isForModify ? 'ADD' : '') : 'DELETE';
      }

      // if referral condition but not original is unchecked
      if (!condition.isLcSaved) {
        if (!condition.isChecked && !condition.isNew){
          condition.amendCode = '';
          setDefaultDescription(condition);
        } else if(condition.isChecked && condition.amendCode != 'REPALL') {
          condition.amendCode = 'ADD';
        }
      }
      setConditionsToBeSaved();
    }

    function toggleCheckAll() {
      angular.forEach(vm.conditionList, function(v, k) {
        if (!v.isDisabled) {
          vm.conditionList[k].isChecked = vm.checkAll;
        }
        if (!(v.amendCode == 'DELETE' && v.isForModify)) {
          toggleCheck(v);
        }
      });
      setConditionsToBeSaved();
    }

    function toggleChargesNarrativeCheck() {
    	
    }

    function toggleNarrativeCharges() {
      vm.additionalNarrative =  "ALL CHARGES OUTSIDE THE PHILIPPINES ARE FOR THE ACCOUNT OF THE " + vm.narrativeCharges + " INCLUDING REIMBURSING CHARGES.";
    }

    getAdditionalConditions($('#documentNumber').val(), $('#tradeServiceId').val());
    getDefaultDescription($('#documentNumber').val());
    vm.showActiveConditionsPopup = showActiveConditionsPopup;
    vm.showPopup = showPopup;
    vm.closePopup = closePopup;
    vm.saveActiveCondition = saveActiveCondition;
    vm.toggleCheck = toggleCheck;
    vm.toggleCheckAll = toggleCheckAll;
    vm.toggleChargesNarrativeCheck = toggleChargesNarrativeCheck;
    vm.toggleNarrativeCharges = toggleNarrativeCharges;
  }

  AdditionalConditionController.$inject = ['AdditionalConditionService', '$filter'];

  angular
    .module('ApplicationModule')
    .controller('AdditionalConditionController', AdditionalConditionController);
}());

$('#additionalConditionDescription').limitCharAndLines(65, 100, 'Z');
