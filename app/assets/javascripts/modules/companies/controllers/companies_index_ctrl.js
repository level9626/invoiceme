'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   '$mdDialog',
   'Company',
   'Invoice',
   function ($scope, $mdDialog, Company, Invoice) {

    _init();

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      _init();
    };

    $scope.newCompany = function (ev) {
      $mdDialog.show({
        controller: CompanyNewCtrl,
        templateUrl: 'companies/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    $scope.editCompany = function (ev, id) {
      $mdDialog.show({
        controller: CompanyEditCtrl,
        templateUrl: 'companies/edit.html',
        targetEvent: ev,
        locals: {
          id: id
        }
      }).then(function(answer) {
        _init();
      });
    };

    $scope.removeCompany = function (id) {
      Company.remove({id: id});
      _init();
    };

    function _init() {
      Company.query(function (data) {
        $scope.companies = data.companies;
      });

      Invoice.states(function (states) {
        $scope.states = states
      })
    }
  }]);
