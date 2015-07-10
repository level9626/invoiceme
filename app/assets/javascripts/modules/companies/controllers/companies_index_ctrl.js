'use strict';

angular.module('CompaniesApp')
    .controller('CompaniesIndexCtrl',
        ['$scope',
         '$sce',
         'Company',
         function ($scope, $sce, Company) {

             Company.query(function (data, company) {
                 $scope.companies = data.companies;

                 $scope.company = company;
                 $scope.company.address = $sce.trustAsHtml(company.address);
             });

         }]);
