'use strict';

var PaymentNewCtrl = [
  '$scope',
  '$mdDialog',
  'Payment',
  function ($scope, $mdDialog, Payment) {
    $scope.company = {
      name: '',
      email: '',
      address: ''
    };

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.savePayment = function () {
      Payment.save($scope.payment, function (payment) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Payment successfully created.'
        });
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