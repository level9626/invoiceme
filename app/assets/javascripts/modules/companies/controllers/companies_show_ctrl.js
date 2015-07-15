'use strict';

angular.module('CompaniesApp')
       .controller('CompaniesShowCtrl',
        ['$scope',
         '$routeParams',
         'Company',
             function ($scope, $routeParams, Company) {

                 Company.get({id: $routeParams['id']}, function (company) {
                     $scope.company = company;
                 });

             }]);
