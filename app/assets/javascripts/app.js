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
  'ngSanitize',
  'ngMaterial',
  'viewhead',
  'templates',
  'angular.morris-chart',
  'file-model',
  'ui.bootstrap',
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
