'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   'Company',
   function ($scope, Company) {

     Company.query(function (data) {
         $scope.companies = data.companies;
     });
  }]);
