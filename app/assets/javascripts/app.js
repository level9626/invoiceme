angular.module('AddsApp',        []);
angular.module('StaticPagesApp', []);

angular.module('Olive', [
  'templates',
  'ngRoute',
  'ngResource',
  'AddsApp',
  'StaticPagesApp'
]);