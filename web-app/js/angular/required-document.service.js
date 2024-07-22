(function() {
  'use strict';

  function RequiredDocumentService($http, $filter) {
    function getAllDocuments(tradeServiceId, documentType) {
      return $http({
        url: allDocumentsUrl,
        method: 'GET',
        params: {
          documentNumber: documentNumber,
          tradeServiceId: tradeServiceId,
          documentType: documentType
        }
      });
    }

    function generateAmendId(rec, documents) {
      var i = rec.sequenceNumber, deleteDocument;
      if (rec.amendCode == 'DELETE' && !rec.isForModify) {
        rec.amendId = i;
      } else if (rec.amendCode == 'DELETE' && rec.isForModify) {
        if (rec.modifyIndex) {
          rec.amendId = rec.modifyIndex + 0.1;
        } else {
          rec.amendId = Math.round($filter('filter')(documents, { documentCode: rec.documentCode, amendCode: 'ADD' }, true)[0].amendId) + 0.1;
        }
      } else if (rec.amendCode == 'ADD' && rec.isForModify) {
        rec.amendId = i + 0.2;
      } else {
        rec.amendId = '';
      }
      return rec.amendId.toString();
    }

    function getRefDocuments(documentNumber, documentType) {
      return $http({
        url: refDocumentsUrl,
        method: 'GET',
        params: {
          documentNumber: documentNumber,
          documentType: documentType
        }
      });
    }

    return { getAllDocuments: getAllDocuments,
      generateAmendId: generateAmendId,
      getRefDocuments: getRefDocuments };
  }

  RequiredDocumentService.$inject = ['$http', '$filter'];

  angular
    .module('ApplicationModule')
    .factory('RequiredDocumentService', RequiredDocumentService);
}());
