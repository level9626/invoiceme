'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceShowCtrl',[
  '$scope',
  '$routeParams',
  '$mdDialog',
  'Invoice',
  function ($scope, $routeParams, $mdDialog, Invoice) {

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

    $scope.journals = function (ev) {
      $mdDialog.show({
        controller: JournalsIndexCtrl,
        templateUrl: 'journals/index.html',
        targetEvent: ev,
        locals: {
          invoice_id: $scope.invoice.id
        }
      });
    }

  }]);
