'use strict';

var CompanyNewCtrl = [
  '$scope',
  '$mdDialog',
  'Company',
  function ($scope, $mdDialog, Company) {
    $scope.company = {
      name: '',
      email: '',
      address: ''
    };

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.saveCompany = function () {
      Company.save($scope.company, function (company) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Company successfully created.'
        });
        $scope.$emit('companies.create', true);
        $mdDialog.hide();
      }, function (responce) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix validation errors, and try again!'
        });
        $scope.errors = responce.data.errors;
      });
    };
  }];