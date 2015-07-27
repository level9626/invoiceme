'use strict';

angular.module('InvMe')
  .directive('filterButton',
  ['$location',
    function ($location) {
      return {
        restrict: 'A',
        transclude: true,
        template: '<span ng-click="filter()"><ng-transclude></ng-transclude></span>',
        scope: {
          filterButton: '@',
          value: '@'
        },
        link: function (scope) {
          var params = {};
          params[scope.filterButton] = scope.value;
          scope.filter = function () {
            $location.search($.param({q: params}));
          };

        }
      };
    }]);
