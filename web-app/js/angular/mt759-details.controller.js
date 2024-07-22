(function() {
  'use strict';

  function Mt759DetailsController(mt759DetailsService) {
    var vm = this;

    vm.documentNumber = documentNumber;

    function save() {
      var requiredFields = [ vm.destinationBank, vm.lcNumber, vm.formOfUndertaking, vm.functionOfMessage, vm.narrative ];
      if (vm.fileIdentificationCode !== '' && vm.fileIdentificationCode !== undefined) {
        requiredFields.push(vm.fileIdentificationDescription);
      }
      if(mt759DetailsService.isFieldsValid(requiredFields, vm.documentNumber, vm.lcNumber)){
        mCenterPopup($('#loading_div'), $('#loading_bg'));
        mLoadPopup($('#loading_div'), $('#loading_bg'));
        angular.element('form#basicDetailsTabForm').submit();
      } else {
        triggerAlertMessage('Please fill in the required fields.');
      }
    }

    function toggleIssuer() {
      if (!vm.issuer) {
        vm.issuer = angular.element('#originalIssuer').val();
      }
      if (vm.issuer === 'A') {
        vm.issuerNameAndAddress = '';
        vm.hideIssuerD = true;
        $(".issuerMt759OptionLetter").text("A");
        angular.element('#issuerIdentifierCode').select2('enable');
      } else if(vm.issuer === 'D') {
        vm.hideIssuerD = false;
        $(".issuerMt759OptionLetter").text("D");
      } else {
        vm.issuerNameAndAddress = '';
        vm.hideIssuerD = true;
        angular.element('#issuerIdentifierCode').select2('disable');
        angular.element('#issuerIdentifierCode').select2('data',{id: ''});
      }
    }

    function showPopup(title, description) {
      vm.popupTitle = title;
      vm.popupDescription = description;
      switch(vm.popupTitle) {
      case 'Name and Address':
        angular.element('#nameAndAddressDescription').limitCharAndLines(35, 4);
        break;
      case 'Narrative':
        angular.element('#narrativeDescription').limitCharAndLines(150, 65, 'Z');
        break;
      case 'File Identification':
        angular.element('#fileDescription').limitCharAndLines(65, 1);
        break;
      }

      centerPopup('popup_description', 'description_bg');
      loadPopup('popup_description', 'description_bg');
    }

    function closePopup() {
      disablePopup('popup_description', 'description_bg');
    }

    function saveDescription() {
      switch(vm.popupTitle) {
      case 'Name and Address':
        vm.issuerNameAndAddress = angular.copy(vm.popupDescription);
        break;
      case 'Narrative':
        vm.narrative = angular.copy(vm.popupDescription);
        break;
      case 'File Identification':
    	vm.fileIdentificationDescription = angular.copy(vm.popupDescription);
    	break;
      }
      vm.popupDescription = '';
      closePopup();
    }

    vm.issuerNameAndAddress = angular.element('#hiddenNameAndAddress').val();
    vm.narrative = angular.element('#hiddenNarrative').val();
    vm.fileIdentificationDescription = angular.element('#hiddenFileIdentificationDescription').val();
    toggleIssuer();
    vm.save = save;
    vm.toggleIssuer = toggleIssuer;
    vm.showPopup = showPopup;
    vm.closePopup = closePopup;
    vm.saveDescription = saveDescription;
  }

  Mt759DetailsController.$inject = ['Mt759DetailsService'];

  angular
    .module('ApplicationModule')
    .controller('Mt759DetailsController', Mt759DetailsController);
}());
