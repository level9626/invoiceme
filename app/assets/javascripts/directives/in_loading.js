'use strict';

angular.module('InvMe')
  .directive('inLoading',
  function () {
    return {
      restrict: 'E',
      replace: true,
      template: '<md-content class="md-padding" \
                             ng-show="collection == undefined "> \
                   <h5 class="text-center">Loading...</h5> \
                 </md-content>',
      scope: {
        collection: '='
      }
    };
  });
