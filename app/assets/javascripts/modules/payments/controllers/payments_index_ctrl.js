'use strict';

angular.module('PaymentsApp')
  .controller('PaymentsIndexCtrl',
  ['$scope',
   'Payment',
   function ($scope, Payment) {

    Payment.query(function (data) {
      $scope.payments = data.payments;
    });

  }]);
