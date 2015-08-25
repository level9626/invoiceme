'use strict';

angular.module('InvoicesApp')
  .factory('Invoice',
    ['$resource',
    function($resource) {

      var _baseUrl = '/api/invoices/'

      return $resource(_baseUrl + ':id.json', { id: '@id' }, {
        update: {
          method: 'PUT',
          transformRequest: function(data){
            return Object.toFormData({invoice: data});
          },
          headers: {
            'Content-Type': undefined
          }
        },
        query: {
          method: 'GET',
          isArray: false,
          q: '@q'
        },
        invoice_number: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'invoice_number.json'
        },
        statistics: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'statistics.json'
        },
        invoice_count: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'invoice_count.json'
        },
        states: {
          method: 'GET',
          isArray: true,
          url: _baseUrl + 'states.json'
        },
        save: {
          method: 'POST',
          transformRequest: function(data){
            return Object.toFormData({invoice: data});
          },
          headers: {
            'Content-Type': undefined
          }
        }
      });

    }
  ]);
