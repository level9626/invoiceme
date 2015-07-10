'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesShowCtrl',
    ['$scope',
    '$routeParams',
    'Invoice',
    function ($scope, $routeParams, Invoice) {

      Invoice.get({id: $routeParams['id']}, function (invoice) {
        $scope.invoice = invoice;
        var percent_payed = Math.round(invoice.percent_payed)
        $scope.invoicePaymentStats = [{
          label: 'Percent Payed',
          value: percent_payed
        },{
          label: 'Percent not payed',
          value: 100 - percent_payed
        }];
      });

    }]);
