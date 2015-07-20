'use strict';

angular.module('PaymentsApp')
  .controller('PaymentNewCtrl',
  ['$scope',
   '$location',
   'Payment',
   function ($scope, $location, Payment) {

    $scope.savePayment = function () {
      Payment.save($scope.payment, function (Payment) {
        $location.path('/companies/'+payment.id);
      });
    };

  }]);
