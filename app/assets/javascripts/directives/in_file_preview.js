'use strict';

angular.module('InvMe')
  .directive('inFilePreview', function () {
    return {
      restrict: 'A',
      link: function (scope, el) {
        el.bind("change", function (e) {
          var file   = (e.srcElement || e.target).files[0],
              reader = new FileReader();
          reader.onload = function (e) {
            el.parent()
              .find('label')
              .css({'background-image': 'url(' + e.target.result + ')'});
          }
          reader.readAsDataURL(file);
        });
      }
    }
  });
