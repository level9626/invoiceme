'use strict';

angular.module('InvoicesApp',       []);
angular.module('PaymentsApp',       []);
angular.module('DashboardApp',      []);
angular.module('CompaniesApp',      []);
angular.module('ClientsApp',        []);
angular.module('CompaniesApp',      []);
angular.module('ProfilesApp',       []);
angular.module('EmailTemplatesApp', []);
angular.module('StaticPagesApp',    []);

angular.module('InvMe', [
  'viewhead',
  'templates',
  'angular.morris-chart',
  'ngRoute',
  'ngResource',
  'InvoicesApp',
  'PaymentsApp',
  'DashboardApp',
  'ClientsApp',
  'CompaniesApp',
  'ProfilesApp',
  'EmailTemplatesApp',
  'StaticPagesApp'
]);
