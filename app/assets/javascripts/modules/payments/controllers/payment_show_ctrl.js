'use strict';

angular.module('PaymentsApp')
  .controller('PaymentShowCtrl',
  ['$scope',
   '$routeParams',
   '$location',
   'Payment',
   function ($scope, $routeParams, $location, Payment) {

    Payment.get({id: $routeParams['id']}, function (payment) {
        $scope.payment = payment;
    });

    $scope.destoryPayment = function (payment_id) {
      Payment.remove({id: payment_id});
      $location.path('/payments')
    }

  }]);
