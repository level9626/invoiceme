'use strict';

angular.module('InvMe')
  .directive('inSlideDown', function () {
    return {
      scope: {
        hidden: '='
      },
      restrict: 'A',
      link: function (scope, el) {

        $('#in-slide-down-trigger').click( function () {
          scope.hidden = !scope.hidden;
          scope.$apply();
        });

        scope.$watch('hidden', function (hidden) {
          if (hidden) {
            el.stop().slideUp();
          } else {
            el.stop().slideDown();
          }
        });
      }
    };
  });
