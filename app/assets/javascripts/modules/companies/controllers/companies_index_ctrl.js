'use strict';

angular.module('CompaniesApp')
    .controller('CompaniesIndexCtrl',
    ['$scope',
        '$sce',
        'Company',
        function ($scope, $sce, Company) {

            Company.query(function (data) {
                $scope.companies = data.companies;
            });

        }]);
