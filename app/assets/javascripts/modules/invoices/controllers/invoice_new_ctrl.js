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

    $scope.$watch('invoice.company_id', function (new_company_id) {
      // if not changed to null or undefined
      if (!new_company_id)
        return

      var q = _.findWhere($scope.companies, {'id': parseInt(new_company_id)});
      $scope.invoice.company_row_text = q['address'];
    });

    $scope.$watch('invoice.client_id', function (new_client_id) {
      // if not changed to null or undefined
      if (!new_client_id)
        return

      var q = _.findWhere($scope.clients, {'id': parseInt(new_client_id)});
      $scope.invoice.client_row_text = q['address'];
    });

    $scope.saveInvoice = function () {
      // Invoice.create($scope.invoice);
      console.log('valid');
    }

  }]);
