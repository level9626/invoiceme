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
          label: 'Payed',
          value: percent_payed
        },{
          label: 'Unpayed',
          value: 100 - percent_payed
        }];
      });

    }]);
