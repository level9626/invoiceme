'use strict';

angular.module('DashboardApp')
  .controller('DashboardCtrl',
    ['$scope',
    'Company',
    'Invoice',
    'Profile',
    function ($scope, Company, Invoice, Profile) {

      Company.query(function (data) {
        $scope.companies = data.companies;
      });

      Invoice.query(function (data) {
        $scope.invoices = data.invoices;
      });

      Profile.percent_payed()
        .success(function (data) {
          $scope.percent_payed = data.percent_payed;
        });

    }]);
