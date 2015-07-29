'use strict';

angular.module('InvMe')
  .directive('activeLink',
  ['$location',
  function($location){
    return {
      restrict: 'A',
      link: function(scope, element){
        scope.location = $location;
        scope.$watch('location.path()', function(currentPath) {
          var url = currentPath.split('/');
          if('/' + url[1] === element[0].attributes['href'].nodeValue) {
            element.parent().addClass('active-menu-link');
            element.parent().removeClass('removed');
            $('li.active-menu-link').find('.nav-icon').addClass('active-menu-icon');
          } else {
            element.parent().addClass('removed');
            element.parent().removeClass('active-menu-link');
            $('li.removed').find('.nav-icon').removeClass('active-menu-icon');
          }
        });
      }
    };
  }]);
