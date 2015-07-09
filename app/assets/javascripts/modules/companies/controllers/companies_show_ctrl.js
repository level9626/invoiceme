'use strict';

angular.module('CompaniesApp')
    .controller('CompaniesShowCtrl',
        ['$scope',
         '$sce',
         'Companies',
            function ($scope, $sce, Company) {

                Company.query(function (data, company) {
                    $scope.companies = data.companies;

                    $scope.company = company;
                    $scope.company.address = $sce.trustAsHtml(company.address);
                });

            }]);
