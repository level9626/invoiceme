'use strict';

angular.module('PaymentsApp')
  .controller('PaymentsIndexCtrl',[
  '$scope',
  'Search',
  'Payment',
  function ($scope, Search, Payment) {

    $scope.data = {};
    $scope.methods = {};

    Payment.query(Search.q_params(), function (data) {
      $scope.data.payments   = data.payments;
      $scope.data.pagination = data.pagination;
    });

    Payment.count(function (data) {
      $scope.data.payments_count = data.count;
    });

  }]);
