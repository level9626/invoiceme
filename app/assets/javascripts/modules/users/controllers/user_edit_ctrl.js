'use strict';

angular.module('UsersApp')
  .controller('UserEditCtrl',[
  '$scope',
  '$location',
  'Auth',
  function ($scope, $location, Auth) {
    Auth.getCurrentUser().then( function (user) {
      $scope.user = Auth.currentUser();
    });

    $scope.update_user = function () {
      Auth.updateProfile({
        email:                 $scope.user.email,
        password:              $scope.user.password,
        password_confirmation: $scope.user.password_confirmation,
        current_password:      $scope.user.current_password
      })
      .then( function() {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'User Login Info successfully updated.'
        });
        $location.path('/');
      }, function(err_obj) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix errors, and try again !'
        });
        // Show form-field specific errors
        $scope.errors = err_obj.data.errors;
      });
    };
  }]);