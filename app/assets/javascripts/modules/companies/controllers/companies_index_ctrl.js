'use strict';

function DialogController($scope, $mdDialog) {
  $scope.submit = function() {
    $mdDialog.hide();
  };
  $scope.cancel = function() {
    $mdDialog.cancel();
  };
}

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   '$mdDialog',
   'Company',
   function ($scope, $mdDialog, Company) {

    _init();

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      _init();
    };

    $scope.newCompany = function (ev) {
      $mdDialog.show({
        controller: DialogController,
        templateUrl: 'companies/new.html',
        targetEvent: ev,
      });
    };

    function _init() {
      Company.query(function (data) {
        $scope.companies = data.companies;
      });
    }

    $scope.states = [
      'Draft',
      'Unpaid',
      'Partly',
      'Paid',
      'Overdue',
      'Bad Dept'
    ];
  }]);
