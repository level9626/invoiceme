'use strict';

angular.module('InvoicesApp')
  .controller('InvoiceEditCtrl',
  ['$scope',
  '$routeParams',
  '$location',
  'Invoice',
  'Company',
  'Client',
  function ($scope, $routeParams, $location, Invoice, Company, Client) {
    Company.query(function (data) {
      $scope.companies = data.companies;
    });

    Client.query(function (data) {
      $scope.clients = data.clients;
    })

    Invoice.get({id: $routeParams['id']}, function (invoice) {
      $scope.invoice = invoice;
      $scope.invoice.invoice_date = new Date($scope.invoice.invoice_date);
    });

    // On company_id/client_id change, get appropriate record address, and use
    // it as one of invoice row_texts
    $scope.$watch('invoice.company_id', function (new_company_id) {
      if (!new_company_id) // if not changed to null or undefined
        return;

      var q = _.findWhere($scope.companies, {'id': parseInt(new_company_id)});
      $scope.invoice.company_row_text = q.address;
    });
    $scope.$watch('invoice.client_id', function (new_client_id) {
      if (!new_client_id) // if not changed to null or undefined
        return;

      var q = _.findWhere($scope.clients, {'id': parseInt(new_client_id)});
      $scope.invoice.client_row_text = q.address;
    });

    // Recalculate amounts on invoice_item fields change
    $scope.$watch('invoice.invoice_items', function(invoice_items) {
      // Only if items are not empty
      if (!invoice_items || invoice_items.length <= 0)
        return;

      var subtotal = 0;
      _.each(invoice_items, function (el) {
        subtotal += el.amount = ( el.hours_or_tasks || 0 ) * ( el.rate || 0 );
      });
      $scope.invoice.subtotal = subtotal;
    }, true);

    // Appends/Removes invoice_items to invoice objects
    $scope.append_invoice_item = function () {
      $scope.invoice.invoice_items.push({
        description: '',
        hours_or_tasks: null,
        rate: null,
        amount: null
      });
    };
    $scope.remove_invoice_item = function (index) {
      $scope.invoice.invoice_items.splice(index, 1);
    };

    // Invoice attachments form actions
    $scope.remove_invoice_attachment = function (index) {
      $scope.invoice.attachments.splice(index, 1);
    };
    $scope.append_invoice_attachment = function () {
      $scope.invoice.attachments.push({
        file: null
      });
    };

    // Datepicker
    $scope.openDatepicker = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.datepicker = {'opened': true};
    }

    $scope.saveInvoice = function () {
      // Invoice.create($scope.invoice);
      $scope.errors = null;
      Invoice.update($scope.invoice, function (invoice) {
        $location.path('/invoices/'+invoice.id)
      }, function (responce) {
        $scope.errors = responce.data.errors;
      });
    }
  }]);
