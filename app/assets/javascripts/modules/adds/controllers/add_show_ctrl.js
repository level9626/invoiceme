'use strict';

angular.module('AddsApp')
  .controller('AddShowCtrl',
    ['$scope',
    '$routeParams',
    'Adds',
    function ($scope, $routeParams, Adds) {

      Adds.get({ id: $routeParams.addId }, function (data) {
        $scope.add = data.add;
      });

    }]);