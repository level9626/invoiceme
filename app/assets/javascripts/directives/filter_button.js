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
          filterButton2: '@',
          value: '@'
        },
        link: function (scope) {

          var currentTime  = new Date();
          var currentYear  = currentTime.getFullYear();
          var currentMonth = currentTime.getMonth() + 1;
          var currentDay   = currentTime.getDate();
          var today        = currentYear + '-' + currentMonth + '-' + currentDay;

          var params = {};

          if (scope.value === 'week') {
            scope.value = currentYear + '-' + currentMonth + '-' + (currentDay - 7);
            params[scope.filterButton] = scope.value;
            params[scope.filterButton2] = today;
          }
          else if (scope.value === 'month') {
            scope.value = currentYear + '-' + (currentMonth - 1) + '-01';
            params[scope.filterButton] = scope.value;
            params[scope.filterButton2] = currentYear + '-' + currentMonth + '-01';
          }
          else if (scope.value === 'year') {
            scope.value = (currentYear - 1) + '-01-01';
            params[scope.filterButton] = scope.value;
            params[scope.filterButton2] = currentYear + '-01-01';
          }
          else {
            params[scope.filterButton] = scope.value;
          }

          scope.filter = function () {
            $location.search($.param({q: params}));
          };

        }
      };
    }]);
