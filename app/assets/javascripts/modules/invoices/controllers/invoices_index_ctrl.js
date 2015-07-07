'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',
    ['$scope',
    '$location',
    'Invoice',
    function ($scope, $location, Invoice) {

      Invoice.query($location.search(), function (data) {
        $scope.invoices = data.invoices;
      });

    }]);
