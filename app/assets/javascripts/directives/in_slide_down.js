'use strict';

angular.module('InvMe')
  .directive('inSlideDown', function () {
    return {
      scope: {
        hidden: '='
      },
      restrict: 'A',
      link: function (scope, el) {

        $('#main-content').on('click', '#in-slide-down-trigger', function () {
          $(this).toggleClass('active');

          if($(this).is('.active')){
            $(this).find('.fa').addClass('fa-chevron-up');
            $(this).find('.fa').removeClass('fa-chevron-down');
          }else{
            $(this).find('.fa').addClass('fa-chevron-down');
            $(this).find('.fa').removeClass('fa-chevron-up');
          }

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
