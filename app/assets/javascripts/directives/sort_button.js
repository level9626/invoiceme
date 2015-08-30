'use strict';

angular.module('InvMe')
  .directive('sortButton',[
  'Search',
  '$location',
  function (Search, $location) {
    return {
      restrict: 'A',
      transclude: true,
      template: '<span class="sort-button" \
                       ng-class="{active: active(), up: up(), down: down()}" \
                       ng-click="sort()"> \
                   <ng-transclude></ng-transclude> \
                   <i class="fa fa-sort"></i> \
                   <i class="fa fa-caret-down"></i> \
                   <i class="fa fa-caret-up"></i> \
                 </span>',
      scope: {
        sortButton: '@'
      },
      link: function (scope, element) {
        // Initialize and pre-populate filter form
        scope.palarity = true;

        scope.sort = function () {
          Search.search_q({s: scope.sortButton + _getPol()});
          scope.palarity = !scope.palarity;
        };

        scope.active = function () {
          return Search.q_params()['q[s]'] && Search.q_params()['q[s]'].match(scope.sortButton);
        };

        scope.up = function () {
          return _polarity() == ' desc';
        };

        scope.down = function () {
          return _polarity() == ' asc';
        };

        function _polarity () {
          if ($location.url().match(/asc/))
            return ' desc';
          else if ($location.url().match(/desc/))
            return ' asc'
        }

        function _getPol() {
          if (scope.palarity) return ' asc';
          return ' desc'
        }
      }
    };
  }]);
