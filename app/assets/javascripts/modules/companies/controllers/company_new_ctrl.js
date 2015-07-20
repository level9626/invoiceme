'use strict';

angular.module('CompaniesApp')
  .controller('CompanyNewCtrl',
  ['$scope',
   '$location',
   'Company',
   function ($scope, $location, Company) {

    $scope.saveCompany = function () {
      Company.save($scope.company, function (Company) {
        $location.path('/companies/'+company.id);
      });
    };

  }]);
