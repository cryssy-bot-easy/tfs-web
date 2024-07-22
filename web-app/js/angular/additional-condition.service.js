(function() {
  'use strict';

  function AdditionalConditionService($http, $filter) {
    function getAllConditions(documentNumber, tradeServiceId) {
      return $http({
        url: allConditionsUrl,
        method: 'GET',
        params: {
          documentNumber: documentNumber,
          tradeServiceId: tradeServiceId
        }
      });
    }

    function generateAmendId(rec, conditions) {
      var i = rec.sequenceNumber, deleteCondition;
      if (rec.amendCode == 'DELETE' && !rec.isForModify) {
        rec.amendId = i;
      } else if (rec.amendCode == 'DELETE' && rec.isForModify) {
        if (rec.modifyIndex) {
           rec.amendId = rec.modifyIndex + 0.1;
        } else {
          rec.amendId = Math.round($filter('filter')(conditions, { conditionCode: rec.conditionCode, amendCode: 'ADD' }, true)[0].amendId) + 0.1;
        }
      } else if (rec.amendCode == 'ADD' && rec.isForModify) {
        rec.amendId = i + 0.2;
      } else {
        rec.amendId = '';
      }
      return rec.amendId.toString();
    }

    function getRefConditions(documentNumber) {
      return $http({
        url: refConditionsUrl,
        method: 'GET',
        params: {
          documentNumber: documentNumber
        }
      });
    }

    return { getAllConditions: getAllConditions,
      generateAmendId: generateAmendId,
      getRefConditions: getRefConditions };
  }

  AdditionalConditionService.$inject = ['$http', '$filter'];

  angular
    .module('ApplicationModule')
    .factory('AdditionalConditionService', AdditionalConditionService);
}());
