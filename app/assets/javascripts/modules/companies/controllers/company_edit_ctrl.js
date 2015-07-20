'use strict';

angular.module('CompaniesApp')
  .controller('CompanyEditCtrl',
  ['$scope',
   '$routeParams',
   'Company',
   function ($scope, $routeParams, Company) {

    Company.get({id: $routeParams['id']}, function (company) {
      $scope.company = company;
    });

    $scope.saveCompany = function () {
      Company.update($scope.company, function (company) {
        $location.path('/companies/'+company.id);
      });
    };

  }]);
