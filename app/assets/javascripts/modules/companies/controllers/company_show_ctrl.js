'use strict';

angular.module('CompaniesApp')
  .controller('CompanyShowCtrl',
  ['$scope',
   '$routeParams',
   '$location',
   'Company',
   function ($scope, $routeParams, $location, Company) {

    Company.get({id: $routeParams['id']}, function (company) {
      $scope.company = company;
    });

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      $location.path('/companies')
    }

  }]);
