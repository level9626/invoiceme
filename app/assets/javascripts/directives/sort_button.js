'use strict';

angular.module('InvMe')
  .directive('sortButton',[
  'Search',
  function (Search) {
    return {
      restrict: 'A',
      transclude: true,
      template: '<span class="sort-button" \
                       ng-class="{active: active()}" \
                       ng-click="sort()"> \
                   <ng-transclude></ng-transclude> \
                 </span>',
      scope: {
        sortButton: '@'
      },
      link: function (scope, element) {
        // Initialize and pre-populate filter form
        scope.palarity = true;

        scope.sort = function () {
          Search.search({s: scope.sortButton + _getPol()});
          scope.palarity = !scope.palarity;
        };

        scope.active = function () {
          return Search.q_params()['q[s]'] && Search.q_params()['q[s]'].match(scope.sortButton);
        };

        function _getPol() {
          if (scope.palarity) return ' asc';
          return ' desc'
        }
      }
    };
  }]);
