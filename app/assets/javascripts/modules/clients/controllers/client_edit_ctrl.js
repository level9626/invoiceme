'use strict';

var ClientEditCtrl = [
  '$scope',
  '$mdDialog',
  'Client',
  'id',
  function ($scope, $mdDialog, Client, id) {
    Client.get({id: id}, function (client) {
      $scope.client = client;
    });

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.saveClient = function () {
      Client.update($scope.client, function (client) {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Client successfully updated.'
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
  }]