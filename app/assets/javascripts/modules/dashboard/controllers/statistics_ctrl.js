'use strict';

angular.module('DashboardApp')
  .controller('StatisticsCtrl',[
  '$scope',
  '$rootScope',
  'Invoice',
  function ($scope, $rootScope, Invoice) {

    _init();

    // private scope

    function _init() {
      Invoice.statistics(function (data) {
        $scope.statistics = data.statistics;
      });
    }

  }]);
