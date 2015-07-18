'use strict';

angular.module('InvoicesApp')
  .factory('Invoice',
    ['$resource',
    function($resource) {

      var _baseUrl = '/api/invoices/'

      return $resource(_baseUrl + ':id', { id: '@id' }, {
        update: {
          method: 'PUT'
        },
        query: {
          method: 'GET',
          isArray: false,
          q: '@q'
        },
        invoice_number: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'invoice_number'
        }
      });

    }
  ]);
