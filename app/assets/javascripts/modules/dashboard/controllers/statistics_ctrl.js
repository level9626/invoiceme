'use strict';

angular.module('DashboardApp')
  .controller('StatisticsCtrl',
    ['$scope',
    'Invoice',
    function ($scope, Invoice) {

      Invoice.statistics(function (data) {
        $scope.statistics = data.statistics;
      });

    }]);
