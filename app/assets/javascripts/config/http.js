'use strict';

angular.module('InvMe')
  .config([
  '$httpProvider',
  'cfpLoadingBarProvider',
  function ($httpProvider, cfpLoadingBarProvider) {
    $httpProvider.defaults.headers.common = 'application/json';
    cfpLoadingBarProvider.includeSpinner = false;
  }]);
