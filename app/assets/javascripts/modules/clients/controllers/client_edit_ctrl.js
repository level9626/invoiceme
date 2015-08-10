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
        $mdDialog.hide();
      }, function (responce) {
        $scope.errors = responce.data.errors;
      });
    };
  }]