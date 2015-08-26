'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceShowCtrl',[
  '$scope',
  '$routeParams',
  '$mdDialog',
  'Invoice',
  function ($scope, $routeParams, $mdDialog, Invoice) {

    _init();

    $scope.journals = function (ev) {
      $mdDialog.show({
        controller: JournalsIndexCtrl,
        templateUrl: 'journals/index.html',
        targetEvent: ev,
        locals: {
          invoice_id: $scope.invoice.id
        }
      });
    };

    $scope.receive_payment = function (ev) {
      $mdDialog.show({
        controller: PaymentNewCtrl,
        templateUrl: 'payments/new.html',
        targetEvent: ev,
        locals: {
          invoice: $scope.invoice
        }
      }).then(function(answer) {
        _init();
      });
    };

    // Private Scope
    function _init() {
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
    }

  }]);
