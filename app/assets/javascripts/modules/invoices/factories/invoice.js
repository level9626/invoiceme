'use strict';

angular.module('InvoicesApp')
  .factory('Invoice',
    ['$resource',
    function($resource) {

      var _baseUrl = '/api/invoices/'

      return $resource(_baseUrl + ':id', { id: '@id' }, {
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
          url: _baseUrl + 'invoice_number'
        },
        statistics: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'statistics'
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
