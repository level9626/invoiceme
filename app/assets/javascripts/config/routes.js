'use strict';

angular.module('InvMe')
  .config(['$routeProvider',
    '$locationProvider',
    function ($routeProvider, $locationProvider) {
    // Allow push state for navigation
    $locationProvider.html5Mode(true);

    $routeProvider
      // Add
      .when('/', {
        templateUrl: 'dashboard/index.html',
        controller: 'DashboardCtrl'
      })
      .when('/invoices', {
        templateUrl: 'invoices/index.html',
        controller: 'InvoicesIndexCtrl'
      })
      .when('/invoices/:id', {
        templateUrl: 'dashboard/index.html',
        controller: 'InvoicesShowCtrl'
      })
      .when('/clients', {
        templateUrl: 'clients/index.html',
        controller: 'ClientsIndexCtrl'
      })
      .when('/companies', {
        templateUrl: 'companies/index.html',
        controller: 'CompaniesIndexCtrl'
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