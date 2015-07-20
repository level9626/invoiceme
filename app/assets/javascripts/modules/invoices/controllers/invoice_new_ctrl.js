'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceNewCtrl',
  ['$scope',
  'Invoice',
  'Company',
  'Client',
  function ($scope, Invoice, Company, Client) {

    $scope.invoice = {};

    Invoice.invoice_number(function (data) {
      $scope.invoice.invoice_number = data.invoice_number;
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
