'use strict';

angular.module('LayoutsApp')
  .controller('ProfileNavCtrl',[
    '$scope',
    'Company',
    function ($scope, Company) {
      Company.companies_count(function (data) {
        $scope.companies_count = data.companies_count;
      });
    }]);
