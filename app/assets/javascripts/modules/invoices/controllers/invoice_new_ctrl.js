'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceNewCtrl',
  ['$scope',
  'Invoice',
  'Company',
  'Client',
  function ($scope, Invoice, Company, Client) {

    // Init Invoice object
    $scope.invoice = {
      invoice_items: [{
        description: null,
        hours_or_tasks: null,
        rate: null,
        amount: null
      }]
    };

    // Get Unique for user invoice number identifier
    Invoice.invoice_number(function (data) {
      $scope.invoice.invoice_number = data.invoice_number;
    });

    // List of companies/cliets are used to get their address
    Company.query(function (data) {
      $scope.companies = data.companies;
    });
    Client.query(function (data) {
      $scope.clients = data.clients;
    })

    // On company_id/client_id change, get appropriate record address, and use
    // it as one of invoice row_texts
    $scope.$watch('invoice.company_id', function (new_company_id) {
      if (!new_company_id) // if not changed to null or undefined
        return

      var q = _.findWhere($scope.companies, {'id': parseInt(new_company_id)});
      $scope.invoice.company_row_text = q['address'];
    });
    $scope.$watch('invoice.client_id', function (new_client_id) {
      if (!new_client_id) // if not changed to null or undefined
        return

      var q = _.findWhere($scope.clients, {'id': parseInt(new_client_id)});
      $scope.invoice.client_row_text = q['address'];
    });

    // Sends builded invoice to the backend
    $scope.saveInvoice = function () {
      // Invoice.create($scope.invoice);
      console.log($scope.invoice);
    }

    // Appends/Removes invoice_items to invoice objects
    $scope.append_invoice_item = function () {
      $scope.invoice.invoice_items.push({
        description: null,
        hours_or_tasks: null,
        rate: null,
        amount: null
      });
    }
    $scope.remove_invoice_item = function (index) {
      $scope.invoice.invoice_items.splice(index, 1);
    }

  }]);
