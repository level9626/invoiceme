'use strict';

var PaymentNewCtrl = [
  '$scope',
  '$mdDialog',
  'Payment',
  'invoice',
  function ($scope, $mdDialog, Payment, invoice) {
    $scope.invoice = invoice;
    $scope.payment = {
      invoice_id: invoice.id,
      currency: invoice.currency,
      amount: invoice.subtotal - ( parseInt(invoice.balance) || 0 ),
      banking_overhead: ''
    };

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.save_payment = function () {
      Payment.save($scope.payment, function (payment) {
        // Show site overall message
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Payment successfully created.'
        });
        // send message to modules that need to do
        // data reload after this action
        $scope.$emit('payment.created', true);
        $mdDialog.hide();
      }, function (responce) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix validation errors, and try again !'
        });
        $scope.errors = responce.data.errors;
      });
    };
  }];