'use strict';

angular.module('AddsApp')
  .controller('AddIndexCtrl',
    ['$scope',
    'Adds',
    '$location',
    function ($scope, Adds, $location) {
      // Privat scope
      var _addIndex = _addIndex || {};

      Adds.query({page: $location.search().page || 1 }, function (data) {
        $scope.adds  = data.adds;
        $scope.pages = data.meta.pagination.pages;
      });

      $scope.showAdd = function (addId) {
        $location.path('/adds/'+addId);
      }

    }]);
