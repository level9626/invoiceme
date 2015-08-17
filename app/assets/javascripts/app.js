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
angular.module('LayoutsApp',        []);
angular.module('UsersApp',          []);

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
  'ngMessages',
  'angular-loading-bar',
  'ngAnimate',
  'InvoicesApp',
  'PaymentsApp',
  'DashboardApp',
  'ClientsApp',
  'CompaniesApp',
  'ProfilesApp',
  'EmailTemplatesApp',
  'StaticPagesApp',
  'LayoutsApp',
  'UsersApp'
]);
