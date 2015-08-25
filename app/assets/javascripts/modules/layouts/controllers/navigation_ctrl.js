'use strict';

angular.module('LayoutsApp')
  .controller('NavigationCtrl',[
    '$scope',
    'Auth',
    function ($scope, Auth) {
      Auth.getCurrentUser().then( function (user) {
        $scope.user = Auth.currentUser();
      });
    }]);
