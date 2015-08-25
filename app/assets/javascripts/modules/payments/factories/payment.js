'use strict';

angular.module('PaymentsApp')
  .factory('Payment',
  ['$resource',
  function($resource) {
    return $resource('/api/payments/:id.json', { id: '@id' }, {
      update: {
        method: 'PUT'
      },
      query: {
        method: 'GET',
        isArray: false
      }
    });
  }]);
