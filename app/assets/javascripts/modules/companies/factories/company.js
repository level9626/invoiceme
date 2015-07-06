'use strict';

angular.module('CompaniesApp')
  .factory('Company',
    ['$resource',
    function($resource) {

      var _basePath = '/api/companies/';

      return $resource(_basePath + ':id', { id: '@id' }, {
        update: {
          method: 'PUT'
        },
        query: {
          method: 'GET',
          isArray: false
        },
        default: {
          method: 'GET',
          isArray: false,
          url: _basePath + 'default'
        }
      });

    }
  ]);
