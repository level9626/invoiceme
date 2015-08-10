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
        $mdDialog.hide();
      }, function (responce) {
        $scope.errors = responce.data.errors;
      });
    };
  }];