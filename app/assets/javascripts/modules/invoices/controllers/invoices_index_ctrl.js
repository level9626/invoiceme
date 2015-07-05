'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',
    ['$scope',
    '$sce',
    'Invoice',
    function ($scope, $sce, Invoice) {

      Invoice.query(function (data) {
        $scope.invoices = data.invoices;
      });

    }]);
