'use strict';

angular.module('InvMe')
  .directive('inSpeedDial',
  function () {
    return {
      restrict: 'E',
      link: function (_, element) {
        var shown = false;
        slide()

        element.find('trigger').click( function () {
          slide();
        });

        function slide () {
          if (shown) {
            element.find('trigger md-icon').first().hide();
            element.find('trigger md-icon').last().show(100);
            element.find('actions').show(50);
          } else {
            element.find('trigger md-icon').last().hide(100);
            element.find('trigger md-icon').first().show();
            element.find('actions').hide(50);
          }
          shown = !shown;
        }
      }
    };
  });
