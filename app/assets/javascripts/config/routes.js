'use strict';

angular.module('Olive')
  .config(['$routeProvider',
    '$locationProvider',
    function ($routeProvider, $locationProvider) {
    // Allow push state for navigation
    $locationProvider.html5Mode(true);


    $routeProvider
      // Add
      .when('/', {
        templateUrl: 'adds/landing.html',
        controller: 'AddLandingCtrl'
      })
      .when('/adds', {
        templateUrl: 'adds/index.html',
        controller: 'AddIndexCtrl'
      })
      .when('/adds/new', {
        templateUrl: 'adds/new.html',
        controller: 'AddNewCtrl'
      })
      .when('/adds/:addId/edit', {
        templateUrl: 'adds/edit.html',
        controller: 'AddEditCtrl'
      })
      .when('/adds/:addId', {
        templateUrl: 'adds/show.html',
        controller: 'AddShowCtrl'
      })
      // static pages
      .when('/404', {
        templateUrl: 'static_pages/404.html',
        controller: 'ErrorStatusCtrl'
      })
      .when('/500', {
        templateUrl: 'static_pages/500.html',
        controller: 'ErrorStatusCtrl'
      })
      .otherwise({
        redirectTo: '/404'
      });
  }])