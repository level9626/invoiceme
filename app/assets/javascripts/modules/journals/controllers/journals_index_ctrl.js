'use strict';

var JournalsIndexCtrl = [
  '$scope',
  '$mdDialog',
  'Journal',
  'invoice_id',
  function ($scope, $mdDialog, Journal, invoice_id) {
    Journal.query({invoice_id: invoice_id}, function (data) {
      $scope.journals = data.journals;
    });
    $scope.close = function() {
      $mdDialog.cancel();
    };
  }];