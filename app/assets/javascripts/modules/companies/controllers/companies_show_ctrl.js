'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesShowCtrl',
  ['$scope',
   '$sce',
   'Companies',
   function ($scope, $sce, Company) {

    Company.get(function (data) {
        $scope.company = company;
        $scope.company.address = $sce.trustAsHtml(company.address);
    });
  }]);
