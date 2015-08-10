'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',
  ['$scope',
    '$mdDialog',
    '$location',
    'Invoice',
    function ($scope, $mdDialog, $location, Invoice) {

      Invoice.query($location.search(), function (data) {
        $scope.invoices = data.invoices;
      });

    }]);
