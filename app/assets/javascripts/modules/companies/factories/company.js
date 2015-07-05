'use strict';

angular.module('CompaniesApp')
  .factory('Company',
    ['$resource',
    function($resource) {

      return $resource('/api/companies/:id', { id: '@id' }, {
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
