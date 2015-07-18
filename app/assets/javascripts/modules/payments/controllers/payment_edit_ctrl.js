'use strict';

angular.module('PaymentsApp')
  .controller('PaymentEditCtrl',
  ['$scope',
   '$routeParams',
   'Company',
   function ($scope, $routeParams, Payment) {

    Payment.get({id: $routeParams['id']}, function (payment) {
      $scope.payment = payment;
    });

    $scope.savePayment = function () {
      Payment.update($scope.payment, function (payment) {
        $location.path('/companies/'+payment.id);
      });
    };

  }]);
