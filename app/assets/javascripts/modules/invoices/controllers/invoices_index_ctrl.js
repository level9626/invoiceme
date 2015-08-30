'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',[
  '$scope',
  '$mdDialog',
  'Search',
  'Invoice',
  function ($scope, $mdDialog, Search, Invoice) {

    $scope.data = {};
    $scope.methods = {};

    Invoice.query(Search.q_params(), function (data) {
      $scope.data.invoices = data.invoices;
      $scope.data.pagination = data.pagination;
    });

    Invoice.invoice_count( function (data) {
      $scope.data.invoice_count = data.invoice_count;
    });

  }]);
