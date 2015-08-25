'use strict';

angular.module('JournalsApp')
  .factory('Journal',[
  '$resource',
  function($resource) {
    var url = '/api/invoices/:invoice_id/journals/:id.json';

    return $resource(url, { id: '@id', invoice_id: '@invoice_id' }, {
      update: {
        method: 'PUT',
      },
      query: {
        method: 'GET',
        isArray: false,
        q: '@q'
      }
    });

  }]);
