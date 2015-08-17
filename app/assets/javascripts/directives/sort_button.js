'use strict';

angular.module('InvMe')
  .directive('sortButton',
  ['$location',
    function ($location) {
      return {
        restrict: 'A',
        transclude: true,
        template: '<span ng-click="sort()"><ng-transclude></ng-transclude></span>',
        scope: {
          sortButton: '@'
        },
        link: function (scope, element) {
          // Initialize and pre-populate filter form
          scope.palarity = true;

          scope.sort = function () {
            $location.search($.param({q: {s: scope.sortButton + _getPol()}}));
            scope.palarity = !scope.palarity;
          };

          function _getPol() {
            if (scope.palarity) return ' asc';
            return ' desc'
          }
        }
      };
    }]);
