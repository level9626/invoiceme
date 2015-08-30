'use strict';

angular.module('PaymentsApp')
  .controller('PaymentEditCtrl',
  ['$scope',
   '$routeParams',
   'Payment',
   function ($scope, $routeParams, Payment) {

    Payment.get({id: $routeParams['id']}, function (payment) {
      $scope.payment = payment;
    });

    $scope.savePayment = function () {
      Payment.update($scope.payment, function (payment) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Payment successfully updated.'
        });
        $location.path('/payments');
      }, function (responce) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix validation errors, and try again!'
        });
        $scope.errors = responce.data.errors;
      });
    };

  }]);
