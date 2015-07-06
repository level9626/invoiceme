'use strict';

angular.module('InvoicesApp')
  .factory('Invoice',
    ['$resource',
    function($resource) {

      return $resource('/api/invoices/:id', { id: '@id' }, {
        update: {
          method: 'PUT'
        },
        query: {
          method: 'GET',
          isArray: false,
          q: '@q'
        }
      });

    }
  ]);
