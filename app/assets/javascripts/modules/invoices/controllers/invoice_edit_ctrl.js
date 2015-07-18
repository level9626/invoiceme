'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceEditCtrl',
  ['$scope',
  '$routeParams',
  'Invoice',
  'Company',
  'Client',
  function ($scope, $routeParams, Invoice, Company, Client) {
    Invoice.get({id: $routeParams['id']}, function (invoice) {
      $scope.invoice = invoice;
    });

    Company.query(function (data) {
      $scope.companies = data.companies;
    });

    Client.query(function (data) {
      $scope.clients = data.clients;
    })

    $scope.saveInvoice = function () {
      // Invoice.create($scope.invoice);
      console.log('valid');
    }
  }]);
