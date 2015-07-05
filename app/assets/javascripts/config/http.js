'use strict';

angular.module('InvMe')
  .config([
    '$httpProvider',
    function ($httpProvider) {
      $httpProvider.defaults.headers.common = 'application/json';
    }]);
