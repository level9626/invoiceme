'use strict';

var JournalsLatestCtrl = [
  '$scope',
  '$mdDialog',
  'Journal',
  'invoice_id',
  'Invoice',
  '$routeParams',
  function ($scope, $mdDialog, Journal, invoice_id, Invoice, $routeParams) {

    Journal.query({invoice_id: invoice_id}, function (data) {
      $scope.journals = data.journals.splice(0, 20);
    });

    Invoice.get({id: $routeParams['id']}, function (invoice) {
      $scope.invoice = invoice;
    });

    $scope.close = function() {
      $mdDialog.cancel();
    };
  }];