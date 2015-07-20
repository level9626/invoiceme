'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   '$location',
   'Company',
   function ($scope, $location, Company) {

    Company.query(function (data) {
      $scope.companies = data.companies;
    });

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      $location.path('/companies')
    }
  }]);
