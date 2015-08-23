'use strict';

angular.module('ClientsApp')
  .factory('Client',
    ['$resource',
    function($resource) {
      return $resource('/api/clients/:id.json', { id: '@id' }, {
          update: {
            method: 'PUT'
          },
          query: {
            method: 'GET',
            isArray: false
          }
      });
    }
  ]);