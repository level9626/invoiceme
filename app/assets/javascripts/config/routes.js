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
      .when('/invoices/new/client/:client_id', {
        templateUrl: 'invoices/new.html',
        controller: 'InvoiceNewCtrl'
      })
      .when('/invoices/new/company/:company_id', {
        templateUrl: 'invoices/new.html',
        controller: 'InvoiceNewCtrl'
      })
      // Clients Recourse
      .when('/clients', {
        templateUrl: 'clients/index.html',
        controller: 'ClientsIndexCtrl'
      })
      // Companies Recourse
      .when('/companies', {
        templateUrl: 'companies/index.html',
        controller: 'CompaniesIndexCtrl'
      })
      // Payments Recourse
      .when('/payments', {
        templateUrl: 'payments/index.html',
        controller: 'PaymentsIndexCtrl'
      })
      .when('/payments/new', {
        templateUrl: 'payments/new.html',
        controller: 'PaymentNewCtrl'
      })
      .when('/payments/:id', {
        templateUrl: 'payments/show.html',
        controller: 'PaymentShowCtrl'
      })
      .when('/payments/:id/edit', {
        templateUrl: 'payments/edit.html',
        controller: 'PaymentEditCtrl'
      })
      // users
      .when('/users/edit', {
        templateUrl: 'users/edit.html',
        controller: 'UserEditCtrl'
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
