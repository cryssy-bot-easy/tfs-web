(function() {
  'use strict';

  function Mt759DetailsService($http, $filter) {

    function isFieldsValid(requiredFields, documentNumber, lcNumber) {
      var isValid = true;
      if (documentNumber === '') {
        if (lcNumber === '') {
          isValid = false;
        }
      } else {
        angular.forEach(requiredFields, function(v) {
          if (v === '') {
            isValid = false;
          }
        });
      }
      return isValid;
    }

    return { isFieldsValid: isFieldsValid };
  }

  Mt759DetailsService.$inject = [];

  angular
    .module('ApplicationModule')
    .factory('Mt759DetailsService', Mt759DetailsService);
}());
