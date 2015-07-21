'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   'Company',
   function ($scope, Company) {

    _init();

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      _init();
    }

    function _init() {
      Company.query(function (data) {
        $scope.companies = data.companies;
      });
    }
  }]);
