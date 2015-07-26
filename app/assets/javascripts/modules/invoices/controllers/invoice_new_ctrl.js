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
      }],
      attachments: [],
      invoice_date: new Date()
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

    // Sends builded invoice to the backend
    $scope.saveInvoice = function () {
      Invoice.save({invoice: _transformNested()}, function (data) {
        console.log('success');
        console.log(data);
      }, function (data) {
        console.log('error');
        console.log(data);
      });
    };

    // Appends/Removes invoice_items to invoice objects
    $scope.append_invoice_item = function () {
      $scope.invoice.invoice_items.push({
        description: null,
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

    // Private Scope

    // Method will give an ability to send nested attributes
    // TODO: make as overall functionality
    function _transformNested () {
      var copied = angular.copy($scope.invoice);
      copied.renameProperty('invoice_items', 'invoice_items_attributes');
      copied.renameProperty('attachments', 'attachments_attributes');
      return copied;
    }

  }]);
