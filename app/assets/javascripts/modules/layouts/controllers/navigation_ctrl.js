'use strict';

angular.module('LayoutsApp')
  .controller('NavigationCtrl',[
    '$rootScope',
    '$scope',
    'Auth',
    function ($rootScope, $scope, Auth) {
      Auth.getCurrentUser().then( function (user) {
        $scope.user = Auth.currentUser();
      });
    }]);
