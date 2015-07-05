'use strict';

angular.module('DashboardApp')
  .controller('DashboardCtrl',
    ['$scope',
    '$sce',
    'Company',
    'Invoice',
    'Profile',
    function ($scope, $sce, Company, Invoice, Profile) {

      Company.default(function (company) {
        $scope.company = company;
        $scope.company.address = $sce.trustAsHtml(company.address);
      });

      Invoice.query(function (data) {
        $scope.invoices = data.invoices;
      });

      Profile.percent_payed()
        .success(function (percent_payed) {
          $scope.userPaymentStats = [{
            label: 'Percent Payed',
            value: percent_payed
          },{
            label: 'Percent not payed',
            value: 100 - percent_payed
          }];
        });

    }]);
