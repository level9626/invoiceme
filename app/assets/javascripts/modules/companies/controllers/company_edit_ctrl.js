'use strict';

var CompanyEditCtrl = [
  '$scope',
  '$mdDialog',
  'Company',
  'id',
  function ($scope, $mdDialog, Company, id) {
    Company.get({id: id}, function (company) {
      $scope.company = company;
    });

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.saveCompany = function () {
      Company.update($scope.company, function (company) {
        $mdDialog.hide();
      }, function (responce) {
        $scope.errors = responce.data.errors;
      });
    };
  }];