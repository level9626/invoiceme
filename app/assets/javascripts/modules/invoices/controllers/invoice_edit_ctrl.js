'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceEditCtrl',
    ['$scope',
    '$routeParams',
    'Invoice',
    function ($scope, $routeParams, Invoice) {
      Invoice.get({id: $routeParams['id']}, function (invoice) {
        $scope.invoice = invoice;
      });
    }]);
