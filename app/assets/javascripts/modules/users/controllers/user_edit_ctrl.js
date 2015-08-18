'use strict';

angular.module('UsersApp')
  .controller('UserEditCtrl',[
  '$scope',
  '$location',
  'Auth',
  'Company',
  function ($scope, $location, Auth, Company) {

    $scope.default_company = {};

    Auth.getCurrentUser().then( function (user) {
      $scope.user = Auth.currentUser();
    });

    Company.query($location.search(), function (data) {
      _.each(data.companies, function(el){
        if (el.default)
          $scope.default_company.id = el.id;
      });
      $scope.companies = data.companies;
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
          text: 'Please fix validation errors, and try again !'
        });
        // Show form-field specific errors
        $scope.errors = err_obj.data.errors;
      });
    };

    $scope.update_default_company = function () {
      Company.update_default({id: $scope.default_company.id}, function (company) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Default Company successfully updated.'
        });
      }, function (responce) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix validation errors, and try again !'
        });
      });
    }
  }]);