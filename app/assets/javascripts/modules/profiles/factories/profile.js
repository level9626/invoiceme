'use strict';

angular.module('ProfilesApp')
  .factory('Profile',
    ['$http',
    function($http) {

      var _base = 'api/profiles/';

      return {
        percent_payed: function() {
          return $http.get(_base + 'percent_payed');
        }
      }

    }
  ]);
