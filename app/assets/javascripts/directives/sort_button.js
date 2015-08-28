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

        scope.up = function () {
          if (_polarity() == ' desc')
            $('span.active').children().find('i').removeClass('fa fa-sort').addClass('fa fa-caret-up');
        };

        scope.down = function () {
          if (_polarity() == ' asc')
            $('span.active').children().find('i').removeClass('fa fa-sort').addClass('fa fa-caret-down');
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
