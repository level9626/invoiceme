'use strict';

var ClientNewCtrl =[
  '$scope',
  '$mdDialog',
  'Client',
  function ($scope, $mdDialog, Client) {
    $scope.client = {
      name: '',
      email: '',
      address: ''
    };

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.saveClient = function () {
      Client.save($scope.client, function (client) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Client successfully created.'
        });
        $mdDialog.hide();
      }, function (responce) {
        $scope.$emit('notify', {
          type: 'warn',
          text: 'Please fix validation errors, and try again!'
        });
        $scope.errors = responce.data.errors;
      });
    };
  }];