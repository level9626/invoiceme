angular.module('AddsApp')
  .factory('Adds',
    ['$resource',
    function($resource) {

      return $resource('/api/v1/adds/:id', { id: '@id' }, {
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