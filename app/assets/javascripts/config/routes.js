'use strict';

angular.module('InvMe')
  .config(['$routeProvider',
    '$locationProvider',
    function ($routeProvider, $locationProvider) {
    // Allow push state for navigation
    $locationProvider.html5Mode(true);

    $routeProvider
      .when('/', {
        templateUrl: 'dashboard/index.html',
        controller: 'DashboardCtrl'
      })
      // Invoices Recourse
      .when('/invoices', {
        templateUrl: 'invoices/index.html',
        controller: 'InvoicesIndexCtrl'
      })
      .when('/invoices/new', {
        templateUrl: 'invoices/new.html',
        controller: 'InvoiceNewCtrl'
      })
      .when('/invoices/:id', {
        templateUrl: 'invoices/show.html',
        controller: 'InvoiceShowCtrl'
      })
      .when('/invoices/:id/edit', {
        templateUrl: 'invoices/edit.html',
        controller: 'InvoiceEditCtrl'
      })
      // Clients Recourse
      .when('/clients', {
        templateUrl: 'clients/index.html',
        controller: 'ClientsIndexCtrl'
      })
      .when('/clients/new', {
        templateUrl: 'clients/new.html',
        controller: 'ClientNewCtrl'
      })
      .when('/clients/:id', {
          templateUrl: 'clients/show.html',
          controller: 'ClientShowCtrl'
      })
      .when('/clients/:id/edit', {
          templateUrl: 'clients/edit.html',
          controller: 'ClientEditCtrl'
      })
      // Companies Recourse
      .when('/companies', {
        templateUrl: 'companies/index.html',
        controller: 'CompaniesIndexCtrl'
      })
      .when('/companies/:id', {
          templateUrl: 'companies/show.html',
          controller: 'CompaniesShowCtrl'
      })
      // Payments Recourse
      .when('/payments', {
        templateUrl: 'payments/index.html',
        controller: 'PaymentsIndexCtrl'
      })
      .when('/payments/:id', {
          templateUrl: 'payments/show.html',
          controller: 'PaymentsShowCtrl'
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
