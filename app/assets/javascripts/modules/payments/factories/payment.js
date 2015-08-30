'use strict';

angular.module('PaymentsApp')
  .factory('Payment',
  ['$resource',
  function($resource) {

    var _baseUrl = '/api/payments/'

    return $resource(_baseUrl + ':id.json', { id: '@id' }, {
      update: {
        method: 'PUT'
      },
      query: {
        method: 'GET',
        isArray: false
      },
      count: {
          method: 'GET',
          isArray: false,
          url: _baseUrl + 'count.json'
      },
    });
  }]);
