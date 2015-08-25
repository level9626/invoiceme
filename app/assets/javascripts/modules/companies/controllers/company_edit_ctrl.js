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
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Company successfully updated.'
        });
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